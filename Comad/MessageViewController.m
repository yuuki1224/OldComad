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
    [socketIO sendEvent:@"init" withData:@{@"room":@"test", @"name":@"asano"}];
}

- (void)sendClicked:(NSString *)text {
    [socketIO sendEvent:@"message" withData:@{@"message" : text}];
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
    
    NSLog(@"%@", packet.args[0]);
    if ([packet.args[0] isEqual:@"yuuki1224"]) {
        // 存在する場合の処理
        [conversation addConversation:packet.args[1] :@"murata.png"];
    }else if([packet.args[0] isEqual:@"asano"]){
        [conversation addConversation:packet.args[1] :@"asano.png"];
    }
}

- (void)stampClickedDelegate:(int)stampNum {
    [mask removeFromSuperview];
    [sm removeFromSuperview];
    [conversation addStamp:stampNum :@"asano"];
}

@end
