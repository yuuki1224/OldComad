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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.894 green:0.902 blue:0.906 alpha:1.0];
    Header *header = [[Header alloc]init];
    [self.view addSubview: header];
    [header setTitle:@"編集"];
    [self setBackBtnInHeader];
    
    RoundedButton *button = [[RoundedButton alloc]initWithName: HeaderDone];
    [button setTitleInButton:@"完了"];
    button.frame = CGRectMake(windowSize.size.width - 60, 37, 48, 28);
    [button addTarget:self action:@selector(saveClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [self configure];
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
    btn.frame = CGRectMake(15, 36, 20, 28);
    [btn setImage:imageResize forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backBtnClicked:)forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:btn];
}

- (void)backBtnClicked:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveClicked:(UIButton *)button {
    [self.delegate doneClicked: self.cellType text: tv.text];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
