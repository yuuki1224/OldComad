//
//  AddFriendViewController.m
//  Comad
//
//  Created by 浅野 友希 on 2013/10/14.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "AddFriendViewController.h"
#import "AddFriendViewController+View.m"
#import "CreateGroupViewController.h"
#import "IdSearchViewController.h"
#import "QrCodeViewController.h"
#import "InviteFriendViewController.h"
#import "Header.h"
#import "Image.h"
#import "UserJsonClient.h"
#import "BlackMask.h"
#import "UserModal.h"
#import "SVProgressHUD.h"
#import "FriendJsonClient.h"

@interface AddFriendViewController ()

@end

@implementation AddFriendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        windowSize = [[UIScreen mainScreen] bounds];
        iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    /*
    [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeBlack];
    [[UserJsonClient sharedClient] getAddFriendInfo:^(AFHTTPRequestOperation *operation, NSHTTPURLResponse *response, id responseObject) {
        facebookFriends = responseObject;
        NSLog(@"%i", [facebookFriends count]);
        [SVProgressHUD dismiss];
        [self configure];
    } failure:^(int statusCode, NSString *errorString) {
        NSLog(@"error");
        [SVProgressHUD dismiss];
    }];
     */
    [self configure];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    Header *header = [[Header alloc]init];
    [self.view addSubview: header];
    [header setTitle:@"友達追加"];
    [self setBackBtnInHeader];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController.tabBarController.tabBar setHidden:YES];
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

#pragma AddFriendMenuDelegate methods
- (void)idSearchDelegate {
    IdSearchViewController *ic = [[IdSearchViewController alloc]init];
    [self.navigationController pushViewController:ic animated:YES];
}

- (void)qrCodeDelegate {
    QrCodeViewController *qc = [[QrCodeViewController alloc]init];
    [self.navigationController pushViewController:qc animated:YES];
}

- (void)addFriendDelegate {
    NSLog(@"push");
}

- (void)createGroupClicked:(UIGestureRecognizer *)recognizer {
    CreateGroupViewController *cc = [[CreateGroupViewController alloc]init];
    [self.navigationController pushViewController:cc animated:YES];
}

//セルタップ時
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        FriendCell *cell = [tableView cellForRowAtIndexPath: indexPath];
        
        userModal = [[UserModal alloc]initWithName: InAddFriend];
        userModal.delegate = self;
        userModal.userInfo = cell.userInfo;
        [userModal loadView];
        
        blackMask = [[BlackMask alloc]init];
        blackMask.alpha = 0.4f;
        [self.view addSubview:blackMask];
        [self.view addSubview:userModal];
        
        [UIView animateWithDuration:0.8f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            blackMask.alpha = 0.7f;
        } completion:^(BOOL finished) {
        }];
    }
}

- (void)closeModalBtnClickedDelegate {
    [userModal removeFromSuperview];
    [blackMask removeFromSuperview];
}

- (void)addFriendBtnClickedDelegate:(int)friendId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userInfo = [defaults dictionaryForKey:@"user"];
    
    [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeBlack];
    [[FriendJsonClient sharedClient]addFriend:[[userInfo objectForKey:@"id"] intValue] friendId:friendId success:^(AFHTTPRequestOperation *operation, NSHTTPURLResponse *response, id responseObject) {
        [userModal removeFromSuperview];
        [blackMask removeFromSuperview];
        [SVProgressHUD dismiss];
        UIAlertView *alert = [[UIAlertView alloc]init];
        alert.title = @"お知らせ";
        alert.message = @"友達を追加しました";
        [alert addButtonWithTitle:@"閉じる"];
        [alert show];
    } failure:^(int statusCode, NSString *errorString) {
        [userModal removeFromSuperview];
        [blackMask removeFromSuperview];
        [SVProgressHUD dismiss];
        UIAlertView *alert = [[UIAlertView alloc]init];
        alert.title = @"お知らせ";
        alert.message = @"友達追加に失敗しました。";
        [alert addButtonWithTitle:@"閉じる"];
        [alert show];
    }];
}

- (void)blockBtnClickedDelegate {
    NSLog(@"ブロックする処理");
    [userModal removeFromSuperview];
    [blackMask removeFromSuperview];
}

- (void)inviteButtonClicked {
    InviteFriendViewController *ic = [[InviteFriendViewController alloc]init];
    [self.navigationController pushViewController:ic animated:YES];
}

@end
