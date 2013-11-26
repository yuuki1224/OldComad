//
//  MessageViewController.m
//  Comad
//
//  Created by 浅野 友希 on 2013/10/14.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "MessageViewController.h"
#import "MessagesListViewController+View.m"
#import "SocketIOPacket.h"
#import "Header.h"
#import "Image.h"
#import "BlackMask.h"
#import "SpecialMoji.h"

@interface MessageViewController ()

@end

@implementation MessageViewController
@synthesize type, userId, friendId, friendImageName, groupId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        windowSize = [[UIScreen mainScreen] bounds];
        self.view.backgroundColor = [UIColor whiteColor];
        Header *header = [[Header alloc]init];
        [header setTitle:@"メッセージ"];
        
        [self.view addSubview:header];
        [self setBackBtnInHeader];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        userId = [[[defaults objectForKey:@"user"] objectForKey:@"id"] intValue];
        
        [self configure];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    switch (type) {
        case PrivateMessage:{
            [self intoRoom];
            break;
        }
        case GroupMessage:{
            break;
        }
        default:
            break;
    }
    
    NSLog(@"ここでselfの値を読む %d, %d", type, friendId);
    NSLog(@"contetHeight: %d", conversation.conversationHeight);
    conversation.scrollsToTop = conversation.conversationHeight - 100;
    [self.navigationController.tabBarController.tabBar setHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setBackBtnInHeader {
    UIImage *image = [UIImage imageNamed:@"back.png"];
    UIImage *imageResize = [Image resizeImage:image resizePer:0.5];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(15, 36, 20, 28);
    [btn setImage:imageResize forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backBtnClicked:)forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:btn];
}

- (void)backBtnClicked:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)intoRoom {
    switch (type) {
        case PrivateMessage:{
            
            NSLog(@"privatemessageはじまるよ！userId: %d, friend: %d", userId, friendId);
            
            socketIO = [[SocketIO alloc] initWithDelegate:self];
            socketIO.delegate = self;
            
            [socketIO connectToHost:@"localhost"
                             onPort:9000
                         withParams:[NSDictionary dictionaryWithObjectsAndKeys:@"1234", @"auth_token", nil]
             ];
            [socketIO sendEvent:@"init" withData:@{@"userId":@(userId), @"friendId":@(friendId), @"type":@"private", @"room":@"test", @"name":@"asano"}];
            break;
        }
        case GroupMessage:
            break;
        default:
            break;
    }
}

- (void)sendClicked:(NSString *)text {
    //userDefaultからとってくる
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *imageName = [[defaults objectForKey:@"user"] objectForKey:@"imageName"];
    NSString *userName = [[defaults objectForKey:@"user"] objectForKey:@"name"];
    
    [socketIO sendEvent:@"message" withData:@{@"message": text, @"userId": @10, @"type": @"private", @"roomName": roomName, @"imageName": imageName, @"userName": userName}];
}

- (void)plusClicked {
    mask = [[BlackMask alloc]init];
    mask.alpha = 0.4;
    //スタンプのビューをmaskの上に付ける。
    sm = [[SpecialMoji alloc]init];
    sm.delegate = self;
    
    [self.view addSubview: mask];
    [self.view addSubview: sm];
}

# pragma SocketIODelegate
- (void)socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet {
    NSLog(@"イベント受け取った");
    
    //表示するとき
    if([packet.args[0] isEqual: @"endInit"]){
        roomName = packet.args[1];
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
                    [conversation addStamp:[stampNum intValue] :userName :imageName];
                } else {
                    //stampがない場合
                    [conversation addConversation:content :userName :imageName];
                }
            //相手のIDのとき
            }else{
                NSString *content = [messages[i] objectForKey:@"content"];
                NSRange range = [content rangeOfString:@"(stamp_"];
                NSString *imageName = [messages[i] objectForKey:@"image_name"];
                NSString *userName = [messages[i] objectForKey:@"user_name"];
                
                NSLog(@"imageName: %@, userName: %@", imageName, userName);
                
                if (range.location != NSNotFound) {
                    //stampがあった場合 左側の描画
                    NSString *stampNum = [content substringWithRange: NSMakeRange(7, content.length - 8)];
                    [conversation addStamp:[stampNum intValue] :userName :imageName];
                } else {
                    //stampがない場合
                    [conversation addConversation:content :userName :imageName];
                }
            }
        }
    }else if([packet.args[0] isEqual: @"privateMessage"]){
        NSString *statement = packet.args[2];
        NSString *imageName = packet.args[3];
        NSString *userName = packet.args[4];
        
        NSLog(@"imageName: %@, userName: %@", imageName, userName);
        //自分のIDのとき
        if ([packet.args[1] isEqual: @(userId)]) {
            NSRange range = [statement rangeOfString:@"(stamp_"];
            if (range.location != NSNotFound) {
                //stampがあった場合 左側の描画
                NSString *stampNum = [statement substringWithRange: NSMakeRange(7, statement.length - 8)];
                [conversation addStamp:[stampNum intValue] :userName :imageName];
            } else {
                //stampがない場合
                [conversation addConversation:statement :userName :imageName];
            }
        //相手のIDのとき
        }else if([packet.args[1] isEqual: @(friendId)]){
            NSRange range = [statement rangeOfString:@"(stamp_"];
            if (range.location != NSNotFound) {
                //stampがあった場合 右側の描画
                NSString *stampNum = [statement substringWithRange:NSMakeRange(7, statement.length - 8)];
                [conversation addStamp:[stampNum intValue] :userName :imageName];
            } else {
                //stampがない場合
                [conversation addConversation:statement :userName :imageName];
            }
        }
    }
}

- (void)stampClickedDelegate:(int)stampNum {
    [mask removeFromSuperview];
    [sm removeFromSuperview];
    NSString *stampName = [NSString stringWithFormat:@"(stamp_%i)", stampNum];
    [socketIO sendEvent:@"message" withData:@{@"message": stampName, @"userId": @10, @"type": @"private", @"roomName": roomName}];
}
@end
