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
        
        [self configure];
    }
    return self;
}

- (void)viewDidLoad
{
    [self intoRoom];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
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
    socketIO = [[SocketIO alloc] initWithDelegate:self];
    socketIO.delegate = self;
    
    [socketIO connectToHost:@"localhost"
                     onPort:9000
                 withParams:[NSDictionary dictionaryWithObjectsAndKeys:@"1234", @"auth_token", nil]
     ];
    [socketIO sendEvent:@"init" withData:@{@"userId":@10, @"friendId":@1, @"type":@"private", @"room":@"test", @"name":@"asano"}];
}

- (void)sendClicked:(NSString *)text {
    //userDefaultからとってくる
    
    
    [socketIO sendEvent:@"message" withData:@{@"message": text, @"userId": @10, @"type": @"private", @"roomName": roomName}];
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
    
    if([packet.args[0] isEqual: @"endInit"]){
        roomName = packet.args[1];
        NSLog(@"endInitしました roomName: %@", roomName);
        NSLog(@"いままでのmessage: %@", packet.args[2]);
        NSArray *messages = packet.args[2];
        for (int i = 0; [messages count]>i; i++) {
            NSLog(@"user_id :%@",[messages[i] objectForKey:@"user_id"]);
            NSLog(@"user_idのclass :%@",[[messages[i] objectForKey:@"user_id"] class]);
            NSLog(@"user_id :%@",[messages[i] objectForKey:@"content"]);
            NSLog(@"user_id :%@",[messages[i] objectForKey:@"datetime"]);
            
            if([[messages[i] objectForKey:@"user_id"] isEqual:@10]){
                NSString *content = [messages[i] objectForKey:@"content"];
                NSRange range = [content rangeOfString:@"(stamp_"];
                if (range.location != NSNotFound) {
                    //stampがあった場合 左側の描画
                    NSString *stampNum = [content substringWithRange: NSMakeRange(7, content.length - 8)];
                    [conversation addStamp: [stampNum intValue]:@"asano"];
                } else {
                    //stampがない場合
                    [conversation addConversation:content :@"asano.png"];
                }
            }else if([[messages[i] objectForKey:@"user_id"] isEqual:@1]){
                NSString *content = [messages[i] objectForKey:@"content"];
                NSRange range = [content rangeOfString:@"(stamp_"];
                if (range.location != NSNotFound) {
                    //stampがあった場合 左側の描画
                    NSString *stampNum = [content substringWithRange: NSMakeRange(7, content.length - 8)];
                    [conversation addStamp: [stampNum intValue]:@"yuuki1224"];
                } else {
                    //stampがない場合
                    [conversation addConversation:content :@"murata.png"];
                }
            }
        }
    }else if([packet.args[0] isEqual: @"privateMessage"]){
        NSString *statement = packet.args[2];
        if ([packet.args[1] isEqual:@1]) {
            NSRange range = [statement rangeOfString:@"(stamp_"];
            if (range.location != NSNotFound) {
                //stampがあった場合 左側の描画
                NSString *stampNum = [statement substringWithRange: NSMakeRange(7, statement.length - 8)];
                [conversation addStamp: [stampNum intValue]:@"yuuki1224"];
            } else {
                //stampがない場合
                [conversation addConversation:statement :@"murata.png"];
            }
        }else if([packet.args[1] isEqual:@10]){
            NSRange range = [statement rangeOfString:@"(stamp_"];
            if (range.location != NSNotFound) {
                //stampがあった場合 右側の描画
                NSString *stampNum = [statement substringWithRange:NSMakeRange(7, statement.length - 8)];
                [conversation addStamp:[stampNum intValue] :@"asano"];
            } else {
                //stampがない場合
                [conversation addConversation:statement :@"asano.png"];
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
