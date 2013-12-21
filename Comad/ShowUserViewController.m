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
        [header setBackBtn];
        header.delegate = self;
        
        [self.view addSubview:header];
    }
    return self;
}

- (void)viewDidLoad
{
    [self configure];
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [self reloadLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)inviteBtnClicked:(UIButton *)button {
}

- (void)sendMessageBtnClicked:(UIButton *)button {
    int userId = [[userInfo objectForKey:@"id"] intValue];
    MessageViewController *mc = [[MessageViewController alloc]init];
    mc.type = PrivateMessage;
    mc.friendId = userId;
    [self.navigationController pushViewController:mc animated:YES];
}

-(void)messageBtnClicked:(UITapGestureRecognizer *)sender {
    int userId = [[userInfo objectForKey:@"id"] intValue];
    MessageViewController *mc = [[MessageViewController alloc]init];
    mc.type = PrivateMessage;
    mc.friendId = userId;
    [self.navigationController pushViewController:mc animated:YES];
}

#pragma HeaderDelagete methods

- (void)backBtnClickedDelegate {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
