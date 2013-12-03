//
//  EditProfileFormViewController.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/04.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "EditProfileFormViewController.h"
#import "EditProfileFormViewController+View.m"
#import "Image.h"
#import "Header.h"
#import "RoundedButton.h"

@interface EditProfileFormViewController ()

@end

@implementation EditProfileFormViewController
@synthesize cellType, editText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    windowSize = [[UIScreen mainScreen] bounds];
    iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.894 green:0.902 blue:0.906 alpha:1.0];
    Header *header = [[Header alloc]init];
    [self.view addSubview: header];
    [header setTitle:@"編集"];
    [self setBackBtnInHeader];
    
    if((int)iOSVersion == 7){
        RoundedButton *button = [[RoundedButton alloc] initWithName:HeaderDone];
        [button setTitleInButton:@"作成"];
        button.frame = CGRectMake(windowSize.size.width - 60, 37, 48, 28);
        //[button addTarget:self action:@selector(saveClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }else if((int)iOSVersion == 6){
        //UIImageView *button = [[UIImageView alloc]initWithFrame:CGRectMake(windowSize.size.width - 60, 10, 48, 28)];
        UIImage *buttonImage = [Image resizeImage:[UIImage imageNamed:@"done.png"] resizePer:0.5];
        UIImageView *createButton = [[UIImageView alloc]initWithImage:buttonImage];
        createButton.frame = CGRectMake(windowSize.size.width - buttonImage.size.width - 10, 10, buttonImage.size.width, buttonImage.size.height);
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(saveClicked:)];
        [createButton addGestureRecognizer: tapGesture];
        createButton.userInteractionEnabled = YES;
        [self.view addSubview: createButton];
    }
    
    [self configure];
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

- (void)saveClicked:(UITapGestureRecognizer *)sender {
    [self.delegate doneClicked: self.cellType text: tv.text];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
