//
//  IdSearchViewController.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/17.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "IdSearchViewController.h"
#import "IdSearchViewController+View.m"
#import "Header.h"
#import "Image.h"

@interface IdSearchViewController ()

@end

@implementation IdSearchViewController
@synthesize addFriendID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        self.view.backgroundColor = [UIColor colorWithRed:0.902 green:0.890 blue:0.875 alpha:1.0];
        Header *header = [[Header alloc]init];
        [header setTitle:@"ID検索"];
        [header setBackBtn];
        header.delegate = self;
        
        [self.view addSubview:header];
    }
    return self;
}

- (void)viewDidLoad
{
    windowSize = [[UIScreen mainScreen] bounds];
    [self configure];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
