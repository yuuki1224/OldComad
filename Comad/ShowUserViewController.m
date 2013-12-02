//
//  ShowUserViewController.m
//  Comad
//
//  Created by 浅野 友希 on 2013/10/14.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "ShowUserViewController.h"
#import "ShowComadViewController+View.m"
#import "MessageViewController.h"
#import "EditProfileViewController.h"
#import "CreateComadViewController.h"
#import "Header.h"
#import "Image.h"

@interface ShowUserViewController ()
@end

@implementation ShowUserViewController
@synthesize me, userInfo;

- (id)init {
    windowSize = [[UIScreen mainScreen] bounds];
    iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
        Header *header = [[Header alloc]init];
        [header setTitle:@"ユーザー詳細"];
        
        [self.view addSubview:header];
        [self setBackBtnInHeader];
    }
    return self;
}

- (void)viewDidLoad
{
    [self configure];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [self reloadLabel];
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

- (void)inviteBtnClicked:(UIButton *)button {
    CreateComadViewController *cc = [[CreateComadViewController alloc]init];
    [self.navigationController pushViewController:cc animated:YES];
}

- (void)sendMessageBtnClicked:(UIButton *)button {
    int userId = [[userInfo objectForKey:@"id"] intValue];
    MessageViewController *mc = [[MessageViewController alloc]init];
    mc.type = PrivateMessage;
    mc.friendId = userId;
    [self.navigationController pushViewController:mc animated:YES];
}

@end
