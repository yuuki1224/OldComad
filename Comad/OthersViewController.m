//
//  OthersViewController.m
//  Comad
//
//  Created by 浅野 友希 on 2013/10/12.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "OthersViewController.h"
#import "Account.h"
#import "Header.h"
#import "OthersButton.h"
#import "SettingsViewController.h"
#import "ShowUserViewController.h"
#import "AddFriendViewController.h"
#import "MessagesListViewController.h"
#import "MapViewController.h"
#import "HistoryViewController.h"
#import "OthersLabel.h"

@interface OthersViewController ()

@end

@implementation OthersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor colorWithRed:0.855 green:0.886 blue:0.929 alpha:1.0];
        windowSize = [[UIScreen mainScreen] bounds];
        iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        
        Header *header = [[Header alloc]init];
        [header setTitle:@"その他"];
        
        float statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        if((int)iOSVersion == 6){
            header.frame = CGRectMake(0, statusBarHeight, windowSize.size.width, 48);
        }
        
        [self.view addSubview: header];
        
        Account *accountView = [[Account alloc]init];
        if((int)iOSVersion == 6){
            //statusbarの裏を黒に
            UIView *statusBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, windowSize.size.width, statusBarHeight)];
            statusBar.backgroundColor = [UIColor blackColor];
            [self.view addSubview: statusBar];
            accountView.frame = CGRectMake(0, 48 + statusBarHeight, windowSize.size.width, accountView.frame.size.height);
        }
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, accountView.frame.origin.y + accountView.frame.size.height, windowSize.size.width, 2)];
        line.backgroundColor = [[UIColor alloc]initWithRed:0.702 green:0.729 blue:0.769 alpha:1.0];
        
        //userDefaultからuserInfoを取りにいってセット
        [self.view addSubview: accountView];
        [self.view addSubview: line];
        [accountView setLabel];
        
        OthersButton *addFriend = [[OthersButton alloc]initWithName:AddFriend];
        OthersLabel *addFriendLabel = [[OthersLabel alloc]initWithName:@"友達追加"];
        OthersButton *myPage = [[OthersButton alloc]initWithName:MyPage];
        OthersLabel *myPageLabel = [[OthersLabel alloc]initWithName:@"マイページ"];
        OthersButton *settings = [[OthersButton alloc]initWithName:Settings];
        OthersLabel *settingsLabel = [[OthersLabel alloc]initWithName:@"設定"];
        OthersButton *map = [[OthersButton alloc]initWithName:Map];
        OthersLabel *mapLabel = [[OthersLabel alloc]initWithName:@"コマドスポット"];
        OthersButton *history = [[OthersButton alloc]initWithName:History];
        OthersLabel *historyLabel = [[OthersLabel alloc]initWithName:@"コマド履歴"];
        OthersButton *message = [[OthersButton alloc]initWithName:Message];
        OthersLabel *messageLabel = [[OthersLabel alloc]initWithName:@"メッセージ"];
        
        addFriend.frame = CGRectMake(25, 287, addFriend.frame.size.width, addFriend.frame.size.height);
        addFriendLabel.frame = CGRectMake(40, 371, addFriendLabel.frame.size.width, addFriendLabel.frame.size.height);
        myPage.frame = CGRectMake(121, 287, myPage.frame.size.width, myPage.frame.size.height);
        myPageLabel.frame = CGRectMake(131, 371, myPageLabel.frame.size.width, myPageLabel.frame.size.height);
        settings.frame = CGRectMake(217, 287, settings.frame.size.width, settings.frame.size.height);
        settingsLabel.frame = CGRectMake(243, 371, settingsLabel.frame.size.width, settingsLabel.frame.size.height);
        map.frame = CGRectMake(25, 388, map.frame.size.width, map.frame.size.height);
        mapLabel.frame = CGRectMake(23, 472, mapLabel.frame.size.width, mapLabel.frame.size.height);
        history.frame = CGRectMake(121, 388, history.frame.size.width, history.frame.size.height);
        historyLabel.frame = CGRectMake(130, 472, historyLabel.frame.size.width, historyLabel.frame.size.height);
        message.frame = CGRectMake(217, 388, message.frame.size.width, message.frame.size.height);
        messageLabel.frame = CGRectMake(225, 472, messageLabel.frame.size.width, messageLabel.frame.size.height);
        NSLog(@"widht: %f height: %f",message.frame.size.width, message.frame.size.height);
        
        [self.view addSubview:addFriend];
        [self.view addSubview:addFriendLabel];
        [self.view addSubview:myPage];
        [self.view addSubview:myPageLabel];
        [self.view addSubview:settings];
        [self.view addSubview:settingsLabel];
        [self.view addSubview:map];
        [self.view addSubview:mapLabel];
        [self.view addSubview:history];
        [self.view addSubview:historyLabel];
        [self.view addSubview:message];
        [self.view addSubview:messageLabel];
        
        [addFriend addTarget:self action:@selector(addFriendBtn:) forControlEvents:UIControlEventTouchUpInside];
        [myPage addTarget:self action:@selector(myPageBtn:) forControlEvents:UIControlEventTouchUpInside];
        [settings addTarget:self action:@selector(settingsBtn:) forControlEvents:UIControlEventTouchUpInside];
        [map addTarget:self action:@selector(mapBtn:) forControlEvents:UIControlEventTouchUpInside];
        [history addTarget:self action:@selector(historyBtn:) forControlEvents:UIControlEventTouchUpInside];
        [message addTarget:self action:@selector(messageBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController.tabBarController.tabBar setHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addFriendBtn:(UIButton *)button {
    AddFriendViewController *ac = [[AddFriendViewController alloc]init];
    ac.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ac animated:YES];
}

- (void)myPageBtn:(UIButton *)button {
    ShowUserViewController *sc = [[ShowUserViewController alloc]init];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"浅野友希", @"name",
                         @"asano.png", @"image_name",
                         @"エンジニア", @"occupation",
                         @"yuuki1224", @"comad_id",
                         @"学生エンジニアです。好きな言語はPHPです。", @"description", nil];
    sc.userInfo = dic;
    sc.me = YES;
    sc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sc animated:YES];
}

- (void)settingsBtn:(UIButton *)button {
    SettingsViewController *sc = [[SettingsViewController alloc]init];
    sc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sc animated:YES];
}

- (void)mapBtn:(UIButton *)button {
    [self.navigationController.tabBarController.tabBar setHidden:YES];
    MapViewController *mc = [[MapViewController alloc]init];
    mc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mc animated:YES];
}

- (void)historyBtn:(UIButton *)button {
    [self.navigationController.tabBarController.tabBar setHidden:YES];
    HistoryViewController *hc = [[HistoryViewController alloc]init];
    hc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:hc animated:YES];
}

- (void)messageBtn:(UIButton *)button {
    MessagesListViewController *mc = [[MessagesListViewController alloc]init];
    mc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mc animated:YES];
}
@end
