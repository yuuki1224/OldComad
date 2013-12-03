//
//  MailSettingsViewController.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/05.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "MailSettingsViewController.h"
#import "MailSettingsViewController+View.m"
#import "Image.h"
#import "Header.h"

@interface MailSettingsViewController ()

@end

@implementation MailSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        windowSize = [[UIScreen mainScreen] bounds];
        iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        Header *header = [[Header alloc]init];
        [header setTitle:@"メール設定"];
        
        [self.view addSubview:header];
        [self setBackBtnInHeader];
        self.view.frame = CGRectMake(0, 77, windowSize.size.width, windowSize.size.height - 77);
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

@end
