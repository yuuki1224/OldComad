//
//  OtherViewController.m
//  Comad
//
//  Created by 浅野 友希 on 2013/12/03.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "OtherViewController.h"
#import "Header.h"
#import "AddFriendViewController.h"
#import "SettingsViewController.h"
#import "MessagesListViewController.h"
#import "Image.h"
#import "BasicLabel.h"
#import "ShowUserViewController.h"
#import "Configuration.h"
#import "SVProgressHUD.h"

@interface OtherViewController ()

@end

@implementation OtherViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor colorWithRed:0.902 green:0.890 blue:0.875 alpha:1.0];
        windowSize = [[UIScreen mainScreen] bounds];
        iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        
        self.view.frame = CGRectMake(0, 0, windowSize.size.width, windowSize.size.height);
        
        Header *header = [[Header alloc]init];
        [header setTitle:@"その他"];
        
        float statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        if((int)iOSVersion == 6){
            header.frame = CGRectMake(0, 0, windowSize.size.width, 48);
        }
        
        [self.view addSubview: header];
        
        UIImage *addFriendImage = [UIImage imageNamed:@"otherAddFriend.png"];
        UIImageView *addFriendButton = [[UIImageView alloc]initWithImage:addFriendImage];
        UITapGestureRecognizer *addFriendTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addFriendTapped:)];
        addFriendButton.userInteractionEnabled = YES;
        [addFriendButton addGestureRecognizer:addFriendTapGesture];
        BasicLabel *addFriendLabel = [[BasicLabel alloc]initWithName:OtherLabel];
        addFriendLabel.text = @"友達追加";
        [addFriendLabel sizeToFit];
        
        UIImage *mypageImage = [UIImage imageNamed:@"otherMypage.png"];
        UIImageView *mypageButton = [[UIImageView alloc]initWithImage:mypageImage];
        UITapGestureRecognizer *mypageTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mypageTapped:)];
        mypageButton.userInteractionEnabled = YES;
        [mypageButton addGestureRecognizer:mypageTapGesture];
        BasicLabel *mypageLabel = [[BasicLabel alloc]initWithName:OtherLabel];
        mypageLabel.text = @"マイページ";
        [mypageLabel sizeToFit];
        
        UIImage *messageImage = [UIImage imageNamed:@"otherMessage.png"];
        UIImageView *messageButton = [[UIImageView alloc]initWithImage:messageImage];
        UITapGestureRecognizer *messageTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(messageTapped:)];
        messageButton.userInteractionEnabled = YES;
        [messageButton addGestureRecognizer:messageTapGesture];
        BasicLabel *messageLabel = [[BasicLabel alloc]initWithName:OtherLabel];
        messageLabel.text = @"メッセージ";
        [messageLabel sizeToFit];
        
        UIImage *settingImage = [UIImage imageNamed:@"otherSetting.png"];
        UIImageView *settingButton = [[UIImageView alloc]initWithImage:settingImage];

        UITapGestureRecognizer *settingTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(settingTapped:)];
        settingButton.userInteractionEnabled = YES;
        [settingButton addGestureRecognizer:settingTapGesture];
        BasicLabel *settingLabel = [[BasicLabel alloc]initWithName:OtherLabel];
        settingLabel.text = @"設定";
        [settingLabel sizeToFit];
        
        if ((int)iOSVersion == 6) {
            addFriendButton.frame = CGRectMake(29, 68, 68, 70);
            addFriendLabel.frame = CGRectMake(37, addFriendButton.frame.origin.y + addFriendButton.frame.size.height + 8, addFriendLabel.frame.size.width, addFriendLabel.frame.size.height);
            mypageButton.frame = CGRectMake(addFriendButton.frame.origin.x + addFriendButton.frame.size.width + 29, addFriendButton.frame.origin.y, 68, 70);
            mypageLabel.frame = CGRectMake(128, addFriendLabel.frame.origin.y, mypageLabel.frame.size.width, mypageLabel.frame.size.height);
            messageButton.frame = CGRectMake(mypageButton.frame.origin.x + mypageButton.frame.size.width + 29, addFriendButton.frame.origin.y, 68, 70);
            messageLabel.frame = CGRectMake(224, addFriendLabel.frame.origin.y, messageLabel.frame.size.width, messageLabel.frame.size.height);
            settingButton.frame = CGRectMake(addFriendButton.frame.origin.x, addFriendButton.frame.origin.y + addFriendButton.frame.size.height + 30, 68, 70);
            settingLabel.frame = CGRectMake(50, settingButton.frame.origin.y + settingButton.frame.size.height + 8, settingLabel.frame.size.width, settingLabel.frame.size.height);
        }else if((int)iOSVersion == 7) {
            addFriendButton.frame = CGRectMake(29, 90, 68, 70);
            addFriendLabel.frame = CGRectMake(37, addFriendButton.frame.origin.y + addFriendButton.frame.size.height + 8, addFriendLabel.frame.size.width, addFriendLabel.frame.size.height);
            mypageButton.frame = CGRectMake(addFriendButton.frame.origin.x + addFriendButton.frame.size.width + 29, addFriendButton.frame.origin.y, 68, 70);
            mypageLabel.frame = CGRectMake(128, addFriendLabel.frame.origin.y, mypageLabel.frame.size.width, mypageLabel.frame.size.height);
            messageButton.frame = CGRectMake(mypageButton.frame.origin.x + mypageButton.frame.size.width + 29, addFriendButton.frame.origin.y, 68, 70);
            messageLabel.frame = CGRectMake(224, addFriendLabel.frame.origin.y, messageLabel.frame.size.width, messageLabel.frame.size.height);
            settingButton.frame = CGRectMake(addFriendButton.frame.origin.x, addFriendButton.frame.origin.y + addFriendButton.frame.size.height + 30, 68, 70);
            settingLabel.frame = CGRectMake(50, settingButton.frame.origin.y + settingButton.frame.size.height + 8, settingLabel.frame.size.width, settingLabel.frame.size.height);
        }
        
        [self.view addSubview:addFriendButton];
        [self.view addSubview:addFriendLabel];
        [self.view addSubview:mypageButton];
        [self.view addSubview:mypageLabel];
        [self.view addSubview:messageButton];
        [self.view addSubview:messageLabel];
        [self.view addSubview:settingButton];
        [self.view addSubview:settingLabel];
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


- (void)addFriendTapped:(UITapGestureRecognizer *)sender {
    [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeBlack];
    AddFriendViewController *ac = [[AddFriendViewController alloc]init];
    ac.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ac animated:YES];
}

- (void)mypageTapped:(UITapGestureRecognizer *)sender {
    ShowUserViewController *sc = [[ShowUserViewController alloc]init];
    sc.userInfo = [Configuration user];
    sc.me = YES;
    sc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sc animated:YES];
}

- (void)settingTapped:(UITapGestureRecognizer *)sender {
    SettingsViewController *sc = [[SettingsViewController alloc]init];
    sc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sc animated:YES];
}

- (void)messageTapped:(UITapGestureRecognizer *)sender {
    MessagesListViewController *mc = [[MessagesListViewController alloc]init];
    mc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mc animated:YES];
}

@end
