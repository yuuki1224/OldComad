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
#import "Configuration.h"
#import "Toast+UIView.h"

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
        [header setTitle:@"コマド詳細"];
        
        if((int)iOSVersion == 6){
            [header setBackBtn];
            header.delegate = self;
            [self.view addSubview:header];
        }else if((int)iOSVersion == 7){
            NSString *backImageName = @"back.png";
            UIImage *buttonImage = [UIImage imageNamed:backImageName];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(15, 40, 10, 17.5);
            [btn setImage:buttonImage forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(backBtnClicked:)forControlEvents:UIControlEventTouchDown];
            [self.view addSubview:header];
            [self.view addSubview:btn];
        }
        
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [self configure];
    textBox.frame = CGRectMake(0, 405, windowSize.size.width, 55);
    
    showComad = [[ShowComad alloc]init];
    showComad.comadInfo = self.comadInfo;
    
    [showComad setLabel];
    [scrollView addSubview: showComad];
    if(isOffline){
        [self.view makeToast:@"ネットワークにつながっていないため、現在メッセージは利用できません。"];
    }else{
        [self intoRoom];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backBtnClicked:(UIButton *)button {
    [socketIO disconnect];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)intoRoom {
    socketIO = [[SocketIO alloc] initWithDelegate:self];
    socketIO.delegate = self;
    NSDictionary *userInfo = [Configuration user];
    int userId = [[userInfo objectForKey:@"id"] intValue];
    int comadId = [[self.comadInfo objectForKey:@"id"] intValue];
    /*
    [socketIO connectToHost:@"54.199.53.137"
                     onPort:9000
                 withParams:[NSDictionary dictionaryWithObjectsAndKeys:@"1234", @"auth_token", nil]];
     */
    [socketIO connectToHost:@"localhost"
                     onPort:9000
                 withParams:[NSDictionary dictionaryWithObjectsAndKeys:@"1234", @"auth_token", nil]];
    [socketIO sendEvent:@"init" withData:@{@"userId":@(userId), @"type":@"comad", @"comadId":@(comadId)}];
}

#pragma SocketIO Delegate
- (void)socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet {
    NSDictionary *userInfo = [Configuration user];
    int userId = [[userInfo objectForKey:@"id"] intValue];
    
    //部屋に入った時
    if([packet.args[0] isEqual: @"endInit"]){
        NSArray *messages = packet.args[2];
        
        NSLog(@"recieved : %@", packet.args[1]);
        NSString *count = [NSString stringWithFormat:@"%lu", (unsigned long)[packet.args[2] count]];
        if([count isEqualToString:@"0"]){
        }else{
            for (int i = 0; [count intValue]>i; i++) {
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
        }
    //部屋にいるときに受信した時
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
    
    //NSString *tweetStatement = [NSString stringWithFormat:@"%@ http://54.199.53.137:3000/comad/%d COMAD（コマド）#Comad", title, comadId];
    NSString *tweetStatement = [NSString stringWithFormat:@"%@ http://localhost:3000/comad/%d COMAD（コマド）#Comad", title, comadId];
    [twitterPostVC setInitialText:tweetStatement];
    [self presentViewController:twitterPostVC animated:YES completion:nil];
}

#pragma HeaderDelagete methods

- (void)backBtnClickedDelegate {
    [socketIO disconnect];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)keyboardWillShow:(NSNotification*)note {
    CGRect keyboardFrameEnd = [[note.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGRect windowSize = [[UIScreen mainScreen] bounds];
    [UIView animateWithDuration:0.35f
                     animations:^{
                         if((int)iOSVersion == 7){
                             textBox.frame = CGRectMake(0, windowSize.size.height - keyboardFrameEnd.size.height, textBox.frame.size.width, textBox.frame.size.height);
                         }else if((int)iOSVersion == 6){
                             textBox.frame = CGRectMake(0, windowSize.size.height - keyboardFrameEnd.size.height - 75, textBox.frame.size.width, textBox.frame.size.height);
                         }
                     }];
}

@end
