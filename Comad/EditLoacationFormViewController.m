//
//  EditLoacationFormViewController.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/03.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "EditLoacationFormViewController.h"
#import "EditLoacationFormViewController+View.m"
#import "Header.h"
#import "Image.h"
#import "RoundedButton.h"

@interface EditLoacationFormViewController ()

@end

@implementation EditLoacationFormViewController
@synthesize location;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        windowSize = [[UIScreen mainScreen] bounds];
        iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        [self.view setBackgroundColor:[UIColor colorWithRed:0.855 green:0.886 blue:0.929 alpha:1.0]];
        Header *header = [[Header alloc]init];
        [header setTitle:@"場所設定"];
        
        [self.view addSubview:header];
        [self setBackBtnInHeader];
        
        RoundedButton *button = [[RoundedButton alloc] initWithName:HeaderDone];
        [button setTitleInButton:@"完了"];
        if((int)iOSVersion == 7){
            button.frame = CGRectMake(windowSize.size.width - 60, 37, 48, 28);
        }else if((int)iOSVersion == 6){
            button.frame = CGRectMake(windowSize.size.width - 60, 10, 48, 28);
            [button setTitleEdgeInsets:UIEdgeInsetsMake(10, 0, 0, 0)];
        }
        [button addTarget:self action:@selector(saveClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
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
    UIImage *image = [UIImage imageNamed:@"back.png"];
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

-(void)saveClicked:(UIButton *)btn {
    //前の画面のプロパティに渡したい delegate?
    [self.delegate changeLocation:self.location];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
