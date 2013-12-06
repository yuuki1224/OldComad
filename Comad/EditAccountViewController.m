//
//  EditAccountViewController.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/02.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "EditAccountViewController.h"
#import "EditAccountViewController+View.m"
#import "Header.h"
#import "Image.h"

@interface EditAccountViewController ()

@end

@implementation EditAccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        windowSize = [[UIScreen mainScreen] bounds];
        iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        Header *header = [[Header alloc]init];
        [header setTitle:@"アカウント編集"];
        [header setBackBtn];
        header.delegate = self;
        
        [self.view addSubview:header];
        self.view.frame = CGRectMake(0, 48, windowSize.size.width, windowSize.size.height - 48);
        self.view.backgroundColor = [UIColor whiteColor];
        
        [self configure];
    }
    return self;
}

- (void)viewDidLoad
{
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
