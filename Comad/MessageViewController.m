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
#import "Configuration.h"
#import "Toast+UIView.h"

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
        iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        self.view.backgroundColor = [UIColor whiteColor];
        Header *header = [[Header alloc]init];
        [header setTitle:@"メッセージ"];
        [header setBackBtn];
        header.delegate = self;
        
        [self.view addSubview:header];
        
        userId = [[[Configuration user] objectForKey:@"id"] intValue];
        
        [self configure];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    if(isOffline){
        [self.view makeToast:@"ネットワークにつながっていないため、現在メッセージは利用できません。"];
    }else{
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
        conversation.scrollsToTop = conversation.conversationHeight - 100;
        [self.navigationController.tabBarController.tabBar setHidden:YES];
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

- (void)intoRoom {
    switch (type) {
        case PrivateMessage:{
            socketIO = [[SocketIO alloc] initWithDelegate:self];
            socketIO.delegate = self;
             [socketIO connectToHost:@"localhost"
                              onPort:9000
                          withParams:[NSDictionary dictionaryWithObjectsAndKeys:@"1234", @"auth_token", nil]
             ];
            [socketIO sendEvent:@"init" withData:@{@"userId":@(userId), @"friendId":@(friendId), @"type":@"private", @"room":@"test", @"name":@"asano"}];
            break;
        }
        default:
            break;
    }
}

- (void)sendClicked:(NSString *)text {
    if(![text isEqualToString:@""]){
        NSString *imageName = [[Configuration user] objectForKey:@"image_name"];
        NSString *userName = [[Configuration user] objectForKey:@"name"];
        
        [socketIO sendEvent:@"message" withData:@{@"message": text, @"userId": [[Configuration user] objectForKey:@"id"], @"type": @"private", @"roomName": roomName, @"imageName": imageName, @"userName": userName}];
    }
}

- (void)plusClicked {
    mask = [[BlackMask alloc]init];
    mask.alpha = 0.4;
    mask.delegate = self;
    //スタンプのビューをmaskの上に付ける。
    sm = [[SpecialMoji alloc]init];
    sm.delegate = self;
    
    [self.view addSubview: mask];
    [self.view addSubview: sm];
}

# pragma SocketIODelegate
- (void)socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet {
    //表示するとき
    if([packet.args[0] isEqual: @"endInit"]){
        roomName = packet.args[1];
        NSArray *messages = packet.args[2];
        
        for (int i = 0; [messages count]>i; i++) {
            NSString *content = [messages[i] objectForKey:@"content"];
            NSRange range = [content rangeOfString:@"(stamp_"];
            NSString *imageName = [messages[i] objectForKey:@"image_name"];
            NSString *userName = [messages[i] objectForKey:@"user_name"];
            //自分のIDのとき
            if([[messages[i] objectForKey:@"user_id"] isEqual:@(userId)]){
                if (range.location != NSNotFound) {
                    NSString *stampNum = [content substringWithRange: NSMakeRange(7, content.length - 8)];
                    [conversation addStamp:[stampNum intValue] :userName :imageName];
                } else {
                    [conversation addConversation:content :userName :imageName];
                }
            //相手のIDのとき
            }else{
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
    conversation.contentSize = CGSizeMake(windowSize.size.width, conversation.contentSize.height + 70);
}

# pragma SpecialMojiDelegate

- (void)stampClickedDelegate:(int)stampNum {
    [mask removeFromSuperview];
    [sm removeFromSuperview];
    NSString *stampName = [NSString stringWithFormat:@"(stamp_%i)", stampNum];
    NSString *imageName = [[Configuration user] objectForKey:@"image_name"];
    NSString *userName = [[Configuration user] objectForKey:@"name"];
    
    [socketIO sendEvent:@"message" withData:@{@"message": stampName, @"userId": [[Configuration user] objectForKey:@"id"], @"type": @"private", @"roomName": roomName, @"imageName": imageName, @"userName": userName}];
}

- (void)blackMaskTapped {
    [sm removeFromSuperview];
    [mask removeFromSuperview];
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
