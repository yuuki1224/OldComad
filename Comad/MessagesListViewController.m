//
//  MessagesListViewController.m
//  Comad
//
//  Created by 浅野 友希 on 2013/10/14.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "MessagesListViewController.h"
#import "MessagesListViewController+View.m"
#import "Image.h"
#import "Header.h"
#import "Configuration.h"

@interface MessagesListViewController ()

@end

@implementation MessagesListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        windowSize = [[UIScreen mainScreen] bounds];
        iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        self.view.backgroundColor = [UIColor whiteColor];
        Header *header = [[Header alloc]init];
        [header setTitle:@"メッセージ一覧"];
        [header setBackBtn];
        header.delegate = self;
        
        [self.view addSubview:header];

        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSData *friendsData = [userDefaults objectForKey: @"friends"];
        if(friendsData == nil){
            friendsArray = [[NSArray alloc] init];
        }else {
            friendsArray = [NSKeyedUnarchiver unarchiveObjectWithData: friendsData];
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
    [self.navigationController.tabBarController.tabBar setHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma HeaderDelagete methods

- (void)backBtnClickedDelegate {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
