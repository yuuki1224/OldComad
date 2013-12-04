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
        self.view.backgroundColor = [UIColor colorWithRed:0.855 green:0.886 blue:0.929 alpha:1.0];
        Header *header = [[Header alloc]init];
        [header setTitle:@"ID検索"];
        
        [self.view addSubview:header];
        [self setBackBtnInHeader];
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

- (void)setBackBtnInHeader {
    NSString *backImageName = @"";
    if((int)iOSVersion == 7){
        backImageName = @"back.png";
    }else if((int)iOSVersion == 6){
        backImageName = @"backForiOS6.png";
    }
    UIImage *image = [UIImage imageNamed:backImageName];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if((int)iOSVersion == 7){
        btn.frame = CGRectMake(15, 36, 20, 28);
    }else if ((int)iOSVersion == 6){
        btn.frame = CGRectMake(15, 11, 20, 28);
    }
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backBtnClicked:)forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:btn];
}

- (void)backBtnClicked:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
