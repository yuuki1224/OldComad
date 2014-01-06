//
//  AddFriendViewController.m
//  Comad
//
//  Created by 浅野 友希 on 2013/10/14.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "AddFriendViewController.h"
#import "AddFriendViewController+View.m"
#import "IdSearchViewController.h"
#import "Header.h"
#import "Image.h"
#import "BlackMask.h"
#import "UserModal.h"
#import "FriendJsonClient.h"
#import "Configuration.h"
#import "Toast+UIView.h"
#import "SVProgressHUD.h"

@interface AddFriendViewController ()

@end

@implementation AddFriendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        windowSize = [[UIScreen mainScreen] bounds];
        iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    }
    return self;
}

- (void)viewDidLoad
{
    [self configure];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    Header *header = [[Header alloc]init];
    [self.view addSubview: header];
    [header setTitle:@"友達追加"];
    if((int)iOSVersion == 6){
        [header setBackBtn];
        header.delegate = self;
        [self.view addSubview:header];
    }else if((int)iOSVersion == 7){
        NSString *backImageName = @"back.png";
        UIImage *buttonImage = [UIImage imageNamed:backImageName];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(15, 40, 10, 17.5);
        [btn setImage:buttonImage forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(backBtnClicked:)forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:header];
        [self.view addSubview:btn];
    }
    if(isOffline){
        [SVProgressHUD dismiss];
        [self.view makeToast:@"ネットワークにつながっていないため、現在友達追加は利用できません。"];
    }else{
        [self setInfo];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController.tabBarController.tabBar setHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma AddFriendMenuDelegate methods
- (void)idSearchDelegate {
    IdSearchViewController *ic = [[IdSearchViewController alloc]init];
    [self.navigationController pushViewController:ic animated:YES];
}

- (void)addFriendDelegate {
    SLComposeViewController *twitterPostVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    NSString *tweetStatement = [NSString stringWithFormat:@"COMAD（コマド）http://54.199.53.137:3000/ #Comad"];
    [twitterPostVC setInitialText:tweetStatement];
    [self presentViewController:twitterPostVC animated:YES completion:nil];
}

- (void)createGroupClicked:(UIGestureRecognizer *)recognizer {
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
        blackMask.delegate = self;
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
    NSDictionary *userInfo = [Configuration user];
    
    [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeBlack];
    [[FriendJsonClient sharedClient]addFriend:[[userInfo objectForKey:@"id"] intValue] friendId:friendId success:^(AFHTTPRequestOperation *operation, NSHTTPURLResponse *response, id responseObject) {
        [userModal removeFromSuperview];
        [blackMask removeFromSuperview];
        [SVProgressHUD dismiss];
        UIAlertView *alert = [[UIAlertView alloc]init];
        alert.title = @"お知らせ";
        alert.message = @"友達を追加しました";
        alert.delegate = self;
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

- (void)blockBtnClickedDelegate:(int)persionId {
    NSDictionary *userInfo = [Configuration user];
    
    [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeBlack];
    [[FriendJsonClient sharedClient]blockPerson:[[userInfo objectForKey:@"id"] intValue] personId:persionId success:^(AFHTTPRequestOperation *operation, NSHTTPURLResponse *response, id responseObject) {
        [userModal removeFromSuperview];
        [blackMask removeFromSuperview];
        [SVProgressHUD dismiss];
        UIAlertView *alert = [[UIAlertView alloc]init];
        alert.title = @"お知らせ";
        alert.delegate = self;
        alert.message = @"ブロックしました";
        [alert addButtonWithTitle:@"閉じる"];
        [alert show];
    } failure:^(int statusCode, NSString *errorString) {
        [userModal removeFromSuperview];
        [blackMask removeFromSuperview];
        [SVProgressHUD dismiss];
        UIAlertView *alert = [[UIAlertView alloc]init];
        alert.title = @"お知らせ";
        alert.message = @"ブロックに失敗しました。";
        [alert addButtonWithTitle:@"閉じる"];
        [alert show];
    }];
}

- (void)inviteButtonClicked {
    UIAlertView *alert = [[UIAlertView alloc]init];
    alert.title = @"お知らせ";
    alert.message = @"招待しますか?";
    [alert addButtonWithTitle:@"キャンセル"];
    [alert addButtonWithTitle:@"OK"];
    [alert show];
}

- (void)blackMaskTapped {
    [blackMask removeFromSuperview];
    [userModal removeFromSuperview];
}

#pragma HeaderDelagete methods

- (void)backBtnClickedDelegate {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma UIAlertViewDelegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"friendRefresh" object:self userInfo:Nil];
}

- (void)backBtnClicked:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
