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
            //UIImageView *button = [[UIImageView alloc]initWithFrame:CGRectMake(windowSize.size.width - 60, 10, 48, 28)];
            UIImage *buttonImage = [Image resizeImage:[UIImage imageNamed:@"tweetButton.png"] resizePer:0.5];
            UIImageView *createButton = [[UIImageView alloc]initWithImage:buttonImage];
            createButton.frame = CGRectMake(windowSize.size.width - buttonImage.size.width - 15, 15, buttonImage.size.width, buttonImage.size.height);
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tweetButtonClicked:)];
            [createButton addGestureRecognizer: tapGesture];
            createButton.userInteractionEnabled = YES;
            [self.view addSubview: createButton];
        }
        
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
    NSString *backImageName = @"";
    if((int)iOSVersion == 7){
        backImageName = @"back.png";
    }else if((int)iOSVersion == 6){
        backImageName = @"backForiOS6.png";
    }
    UIImage *image = [UIImage imageNamed:backImageName];
    UIImage *imageResize = [Image resizeImage:image resizePer:0.5];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if((int)iOSVersion == 7){
        btn.frame = CGRectMake(15, 36, 20, 28);
    }else if ((int)iOSVersion == 6){
        btn.frame = CGRectMake(15, 11, 20, 28);
    }
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

#pragma SocketIO Delegate
- (void)socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet {
    NSLog(@"イベント受け取った");
    
    NSLog(@"%@", packet.args[0]);
    if ([packet.args[0] isEqual:@"yuuki1224"]) {
        // 存在する場合の処理
        //[conversation addConversation:packet.args[1] :@"murata.png"];
        
    }else if([packet.args[0] isEqual:@"asano"]){
        //[conversation addConversation:packet.args[1] :@"asano.png"];
    }
}

- (void)tweetButtonClicked:(UITapGestureRecognizer *)sender {
    NSLog(@"tweet!!");
}

@end
