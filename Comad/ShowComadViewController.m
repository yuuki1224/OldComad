//
//  ShowComadViewController.m
//  Comad
//
//  Created by 浅野 友希 on 2013/10/14.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "ShowComadViewController.h"
#import "ShowComadViewController+View.m"
#import "ShowComad.h"
#import "Header.h"
#import "Image.h"
#import "ConversationTextBox.h"
#import "SocketIO.h"
#import "SocketIOPacket.h"
#import "RoundedButton.h"

@interface ShowComadViewController ()

@end

@implementation ShowComadViewController
@synthesize name, imageName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        windowSize = [[UIScreen mainScreen] bounds];
        iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        self.view.frame = CGRectMake(0, 0, windowSize.size.width, windowSize.size.height);
    
        self.view.backgroundColor = [UIColor whiteColor];
        Header *header = [[Header alloc]init];
        
        [self.view addSubview: header];
        
        [header setTitle:@"コマド詳細"];
        [self setBackBtnInHeader];
        
        if((int)iOSVersion == 7){
            RoundedButton *button = [[RoundedButton alloc] initWithName:HeaderDone];
            [button setTitleInButton:@"作成"];
            button.frame = CGRectMake(windowSize.size.width - 60, 37, 48, 28);
            //[button addTarget:self action:@selector(saveClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
        }else if((int)iOSVersion == 6){
            UIImage *buttonImage = [UIImage imageNamed:@"tweetButton.png"];
            UIImageView *createButton = [[UIImageView alloc]initWithImage:buttonImage];
            createButton.frame = CGRectMake(windowSize.size.width - 33.5, 15, 18.5, 20);
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tweetButtonClicked:)];
            [createButton addGestureRecognizer: tapGesture];
            createButton.userInteractionEnabled = YES;
            [self.view addSubview: createButton];
        }
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [conversation setContentOffset:CGPointMake(0, 100)];
    [scrollView setContentOffset:CGPointMake(0, 100)];
}

- (void)viewWillAppear:(BOOL)animated {
    [self configure];
    textBox.frame = CGRectMake(0, 405, windowSize.size.width, 55);
    [self intoRoom];
    showComad = [[ShowComad alloc]init];
    showComad.comadInfo = self.comadInfo;
    
    [showComad setLabel];
    [scrollView addSubview: showComad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setBackBtnInHeader {
    NSString *backImageName = @"";
    if((int)iOSVersion == 7){
        backImageName = @"back.png";
    }else if((int)iOSVersion == 6){
        backImageName = @"backForiOS6.png";
    }
    UIImage *image = [UIImage imageNamed:backImageName];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if((int)iOSVersion == 7){
        btn.frame = CGRectMake(15, 36, 20, 28);
    }else if ((int)iOSVersion == 6){
        btn.frame = CGRectMake(15, 11, 20, 28);
    }
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backBtnClicked:)forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:btn];
}

- (void)backBtnClicked:(UIButton *)button {
    [socketIO disconnect];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)intoRoom {
    socketIO = [[SocketIO alloc] initWithDelegate:self];
    socketIO.delegate = self;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userInfo = [defaults objectForKey:@"user"];
    int userId = [[userInfo objectForKey:@"id"] intValue];
    int comadId = [[self.comadInfo objectForKey:@"id"] intValue];
    
    [socketIO connectToHost:@"54.199.53.137"
                     onPort:9000
                 withParams:[NSDictionary dictionaryWithObjectsAndKeys:@"1234", @"auth_token", nil]];
    /*
    [socketIO connectToHost:@"localhost"
                     onPort:9000
                 withParams:[NSDictionary dictionaryWithObjectsAndKeys:@"1234", @"auth_token", nil]];*/
    [socketIO sendEvent:@"init" withData:@{@"userId":@(userId), @"type":@"comad", @"comadId":@(comadId)}];
}

#pragma SocketIO Delegate
- (void)socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userInfo = [defaults objectForKey:@"user"];
    int userId = [[userInfo objectForKey:@"id"] intValue];
    
    if([packet.args[0] isEqual: @"endInit"]){
        //roomName = packet.args[1];
        NSArray *messages = packet.args[2];
        
        for (int i = 0; [messages count]>i; i++) {
            //自分のIDのとき
            if([[messages[i] objectForKey:@"user_id"] isEqual:@(userId)]){
                NSString *content = [messages[i] objectForKey:@"content"];
                NSRange range = [content rangeOfString:@"(stamp_"];
                NSString *imageName = [messages[i] objectForKey:@"image_name"];
                NSString *userName = [messages[i] objectForKey:@"user_name"];
                
                if (range.location != NSNotFound) {
                    //stampがあった場合 左側の描画
                    NSString *stampNum = [content substringWithRange: NSMakeRange(7, content.length - 8)];
                    [conversation removeNoConversation];
                    [conversation addStamp:[stampNum intValue] :userName :imageName];
                } else {
                    //stampがない場合
                    [conversation removeNoConversation];
                    [conversation addConversation:content :userName :imageName];
                }
                //相手のIDのとき
            }else{
                NSString *content = [messages[i] objectForKey:@"content"];
                NSRange range = [content rangeOfString:@"(stamp_"];
                NSString *imageName = [messages[i] objectForKey:@"image_name"];
                NSString *userName = [messages[i] objectForKey:@"user_name"];
                
                if (range.location != NSNotFound) {
                    //stampがあった場合 左側の描画
                    NSString *stampNum = [content substringWithRange: NSMakeRange(7, content.length - 8)];
                    [conversation removeNoConversation];
                    [conversation addStamp:[stampNum intValue] :userName :imageName];
                } else {
                    //stampがない場合
                    [conversation removeNoConversation];
                    [conversation addConversation:content :userName :imageName];
                }
            }
        }
    }else if([packet.args[0] isEqual: @"comadMessage"]){
        NSString *statement = packet.args[2];
        NSString *imageName = packet.args[3];
        NSString *userName = packet.args[4];
        //自分のIDのとき
        if ([packet.args[1] isEqual: @(userId)]) {
            NSRange range = [statement rangeOfString:@"(stamp_"];
            if (range.location != NSNotFound) {
                //stampがあった場合 左側の描画
                NSString *stampNum = [statement substringWithRange: NSMakeRange(7, statement.length - 8)];
                [conversation removeNoConversation];
                [conversation addStamp:[stampNum intValue] :userName :imageName];
            } else {
                //stampがない場合
                [conversation removeNoConversation];
                [conversation addConversation:statement :userName :imageName];
            }
            //自分じゃないのIDのとき
        }else{
            NSRange range = [statement rangeOfString:@"(stamp_"];
            if (range.location != NSNotFound) {
                //stampがあった場合 右側の描画
                NSString *stampNum = [statement substringWithRange:NSMakeRange(7, statement.length - 8)];
                [conversation removeNoConversation];
                [conversation addStamp:[stampNum intValue] :userName :imageName];
            } else {
                //stampがない場合
                [conversation removeNoConversation];
                [conversation addConversation:statement :userName :imageName];
            }
        }
    }
}

- (void)tweetButtonClicked:(UITapGestureRecognizer *)sender {
    SLComposeViewController *twitterPostVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    void (^completion) (SLComposeViewControllerResult result) = ^(SLComposeViewControllerResult result) {
        textBox.frame = CGRectMake(0, windowSize.size.height - 75, windowSize.size.width, 55);
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                //textbox下げる
                textBox.frame = CGRectMake(0, windowSize.size.height - 75, windowSize.size.width, 55);
                [self dismissViewControllerAnimated:YES completion:nil];
                break;
            case SLComposeViewControllerResultDone:
                //textbox下げる
                [self dismissViewControllerAnimated:YES completion:nil];
                break;
            default:
                break;
        }
    };
    [twitterPostVC setCompletionHandler:completion];
    NSString *title = @"";
    int comadId = [[self.comadInfo objectForKey:@"id"] intValue];
    
    if([[self.comadInfo objectForKey:@"title"] isEqualToString:@""]){
        title = @"タイトルなし";
    }else{
        title = [self.comadInfo objectForKey:@"title"];
    }
    NSString *tweetStatement = [NSString stringWithFormat:@"%@ http://54.199.53.137:3000/comad/%d COMAD（コマド）#Comad", title, comadId];
    [twitterPostVC setInitialText:tweetStatement];
    [self presentViewController:twitterPostVC animated:YES completion:nil];
}

@end
