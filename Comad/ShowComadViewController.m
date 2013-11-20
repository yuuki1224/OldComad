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

@interface ShowComadViewController ()

@end

@implementation ShowComadViewController
@synthesize name, imageName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        windowSize = [[UIScreen mainScreen] bounds];
        self.view.frame = CGRectMake(0, 0, windowSize.size.width, windowSize.size.height);
    
        self.view.backgroundColor = [UIColor whiteColor];
        Header *header = [[Header alloc]init];
        
        [self.view addSubview: header];
        
        [header setTitle:@"コマド詳細"];
        [self setBackBtnInHeader];
        
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

- (void)sendClicked:(NSString *)text {
    //Socket通信
    [socketIO sendEvent:@"message" withData:@{@"message" : text}];
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

#pragma SocketIO Delegate
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


@end
