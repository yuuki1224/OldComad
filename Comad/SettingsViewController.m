//
//  SettingsViewController.m
//  Comad
//
//  Created by 浅野 友希 on 2013/10/14.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "SettingsViewController.h"
#import "EditProfileViewController.h"
#import "EditAccountViewController.h"
#import "NotificationSettingsViewController.h"
#import "MailSettingsViewController.h"
#import "Header.h"
#import "Image.h"
#import "LoginViewController.h"
#import "SVProgressHUD.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        windowSize = [[UIScreen mainScreen] bounds];
        iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        Header *header = [[Header alloc]init];
        [header setTitle:@"設定"];
        [self.view addSubview:header];
        [self setBackBtnInHeader];
        
        self.view.backgroundColor = [UIColor colorWithRed:0.902 green:0.890 blue:0.875 alpha:1.0];
        //tableView設置
        UITableView *settingsView = [[UITableView alloc]initWithFrame:CGRectMake(0, 48, windowSize.size.width, windowSize.size.height) style:UITableViewStyleGrouped];
        [self.view addSubview:settingsView];
        settingsView.dataSource = self;
        settingsView.delegate = self;
        settingsView.scrollEnabled = NO;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
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

#pragma UITableViewDataSource methods
//セクション内の列の数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 1;
            break;
        default:
            break;
    }
    return 0;
}

//セルの内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14.0f];
    
    switch (indexPath.section) {
        case 0:
            if(indexPath.row == 0){
                [cell setText:@"プロフィール設定"];
            }else if(indexPath.row == 1){
                [cell setText:@"アカウント設定"];
            }
            break;
        case 1:
            if(indexPath.row == 0){
                [cell setText:@"通知設定"];
            }else if(indexPath.row == 1){
                [cell setText:@"メール設定"];
            }
            break;
        case 2:
            if(indexPath.row == 0){
                [cell setText:@"ログアウト"];
            }
        default:
            break;
    }
    return cell;
}

//セクションの数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

//ヘッダーのタイトル

#pragma UITableViewDelegate methods
//セルの高さ
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

//ヘッダーの高さ
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

//フッターの高さ
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    if(section == 2){
        return 200;
    }else{
        return 0;
    }
}

//クリックされたら
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            if(indexPath.row == 0){
                EditProfileViewController *ec = [[EditProfileViewController alloc]init];
                [self.navigationController pushViewController:ec animated:YES];
            }else if(indexPath.row == 1){
                EditAccountViewController *ec = [[EditAccountViewController alloc]init];
                [self.navigationController pushViewController:ec animated:YES];
            }
            break;
        case 1:
            if(indexPath.row == 0){
                NotificationSettingsViewController *ec = [[NotificationSettingsViewController alloc]init];
                [self.navigationController pushViewController:ec animated:YES];
            }else if (indexPath.row == 1){
                MailSettingsViewController *mc = [[MailSettingsViewController alloc]init];
                [self.navigationController pushViewController:mc animated:YES];
            }
            break;
        case 2:
            if(indexPath.row == 0){
                UIAlertView *alert = [[UIAlertView alloc] init];
                [alert setTitle:@"確認"];
                [alert setMessage:@"本当にログアウトしますか？"];
                [alert addButtonWithTitle:@"いいえ"];
                [alert addButtonWithTitle:@"はい"];
                alert.delegate = self;
                [alert show];
            }
            break;
        default:
            break;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            NSLog(@"キャンセルしました");
            break;
        case 1: {
            NSLog(@"ログアウト処理!!");
            [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeBlack];
            LoginViewController *lc = [[LoginViewController alloc]init];
            UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
            rootViewController.modalPresentationStyle = UIModalPresentationFormSheet;
            rootViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            [self presentViewController:lc animated:YES completion:nil];
            break;
        }
        default:
            break;
    }
}

@end
