//
//  CreateGroupViewController.m
//  Comad
//
//  Created by 浅野 友希 on 2013/10/14.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "CreateGroupViewController.h"
#import "CreateGroupViewController+View.m"
#import "Header.h"
#import "Image.h"
#import "RoundedButton.h"
#import "UserJsonClient.h"
#import "SVProgressHUD.h"

@interface CreateGroupViewController ()

@end

@implementation CreateGroupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        memberLabelWidth = 10;
        memberLabelHeight = 28;
        windowSize = [[UIScreen mainScreen] bounds];
        self.view.backgroundColor = [UIColor whiteColor];
        Header *header = [[Header alloc]init];
        [header setTitle:@"グループ作成"];
        
        [self.view addSubview:header];
        [self setBackBtnInHeader];
        
        RoundedButton *button = [[RoundedButton alloc] initWithName:HeaderDone];
        [button setTitleInButton:@"保存"];
        button.frame = CGRectMake(windowSize.size.width - 60, 37, 48, 28);
        [button addTarget:self action:@selector(saveClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    btn.frame = CGRectMake(15, 33, 20, 28);
    [btn setImage:imageResize forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backBtnClicked:)forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:btn];
}

- (void)backBtnClicked:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveClicked:(UIButton *)button {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"hoge", @"name",
                            @"999-9999-9999", @"tel",
                            @"東京都", @"address",nil];
    [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeBlack];
    [[UserJsonClient sharedClient]createGroup:params success:^(AFHTTPRequestOperation *operation, NSHTTPURLResponse *response, id responseObject) {
        NSLog(@"成功!");
        [SVProgressHUD dismiss];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(int statusCode, NSString *errorString) {
        NSLog(@"失敗");
        [SVProgressHUD dismiss];
    }];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    [tv resignFirstResponder];
    return YES;
}

- (void)cancelButtonDelegate {
    [selectPeopleView removeFromSuperview];
}

- (void)inviteButtonDelegate {
    [selectPeopleView removeFromSuperview];
}
@end
