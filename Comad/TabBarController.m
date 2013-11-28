//
//  TabBarController.m
//  Comad
//
//  Created by 浅野 友希 on 2013/10/12.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "TabBarController.h"
#import "ComadsViewController.h"
#import "FriendsViewController.h"
#import "OthersViewController.h"
#import "UserModal.h"
#import "BlackMask.h"
#import "ShowUserViewController.h"
#import "MessageViewController.h"
#import "LoginViewController.h"
#import "CreateComadViewController.h"

#import "Image.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        float iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        NSLog(@"iosVersion: %f", iOSVersion);
        // Custom initialization
        //CGRect windowSize = [[UIScreen mainScreen] bounds];
        //self.view.frame = CGRectMake(0, 10, windowSize.size.width, windowSize.size.height);
        
        //背景画像、SelectionIndicatorImageを設定
        //背景画像 黒
        //[[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tab1.png"]];
        //選択された時に間に入れる
        //[[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tab2.png"]];
         [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, 0)];
        self.tabBar.backgroundColor = [UIColor colorWithRed:0.067 green:0.067 blue:0.067 alpha:1.0];
        
        if(iOSVersion == 7.00){
            self.tabBar.tintColor = [UIColor colorWithRed:0.282 green:0.549 blue:0.898 alpha:1.0];
            self.tabBar.barTintColor = [UIColor colorWithRed:0.067 green:0.067 blue:0.067 alpha:1.0];
        }
        cc = [[ComadsViewController alloc]init];
        fc = [[FriendsViewController alloc]init];
        oc = [[OthersViewController alloc]init];
        
        UIImage *tab1 = [UIImage imageNamed:@"tab1.png"];
        UIImage *tab2 = [UIImage imageNamed:@"tab2.png"];
        UIImage *tab3 = [UIImage imageNamed:@"tab3.png"];
        
        UIImage *tab1Resize = [Image resizeImage:tab1 resizePer:0.5];
        UIImage *tab2Resize = [Image resizeImage:tab2 resizePer:0.5];
        UIImage *tab3Resize = [Image resizeImage:tab3 resizePer:0.5];
        
        UINavigationController *comadTabNav = [[UINavigationController alloc]initWithRootViewController:cc];
        UINavigationController *friendTabNav = [[UINavigationController alloc]initWithRootViewController:fc];
        UINavigationController *accountTabNav = [[UINavigationController alloc]initWithRootViewController:oc];
        
        
        friendTabNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"コマとも" image:tab1Resize tag:0];
        comadTabNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"コマド" image:tab2Resize tag:0];
        accountTabNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"その他" image:tab3Resize tag:0];
        
        UIOffset offset1 = UIOffsetMake(friendTabNav.tabBarItem.titlePositionAdjustment.horizontal, -4.0);
        UIOffset offset2 = UIOffsetMake(comadTabNav.tabBarItem.titlePositionAdjustment.horizontal, -4.0);
        UIOffset offset3 = UIOffsetMake(accountTabNav.tabBarItem.titlePositionAdjustment.horizontal, -4.0);
        
        [friendTabNav.tabBarItem setTitlePositionAdjustment:offset1];
        [comadTabNav.tabBarItem setTitlePositionAdjustment:offset2];
        [accountTabNav.tabBarItem setTitlePositionAdjustment:offset3];
        
        [cc.navigationController setNavigationBarHidden:YES];
        [fc.navigationController setNavigationBarHidden:YES];
        [oc.navigationController setNavigationBarHidden:YES];
        
        fc.delegate = self;
        
        NSArray *tabs = [NSArray arrayWithObjects: friendTabNav, comadTabNav, accountTabNav, nil];
        
        //タブのテキストカラー設定
        //[[wc tabBarItem] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil] forState:UIControlStateNormal];
        
        [self setViewControllers:tabs animated:NO];
        
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

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSLog(@"clicked!");
}

- (void)showModalView:(NSDictionary *)userInfo {
    userModal = [[UserModal alloc]initWithName:Friend];
    userModal.delegate = self;
    userModal.userInfo = userInfo;
    NSLog(@"userInfo: %@", userInfo);
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

- (void)closeModalBtnClickedDelegate {  
    [userModal removeFromSuperview];
    [blackMask removeFromSuperview];
}

//ShowuserViewControllerへ
- (void)showUserBtnClickedDelegate {
    [userModal removeFromSuperview];
    [blackMask removeFromSuperview];
    ShowUserViewController *sc = [[ShowUserViewController alloc]init];
    NSLog(@"userModal: %@", userModal.userInfo);
    [sc setMe: NO];
    sc.userInfo = userModal.userInfo;
    [fc.navigationController pushViewController:sc animated:YES];
}

//CreateComadViewControllerへ
- (void)inviteComadBtnClickedDelegate {
    [userModal removeFromSuperview];
    [blackMask removeFromSuperview];
    
    CreateComadViewController *cc = [[CreateComadViewController alloc]init];
    LoginViewController *lc = [[LoginViewController alloc]init];
    [fc.navigationController.tabBarController.tabBar setHidden:YES];
    [fc.navigationController pushViewController:cc animated:YES];
}

//MessageViewControllerへ
- (void)sendMessageBtnClickedDelegate:(int)friendId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [defaults dictionaryForKey:@"user"];
    if (dict) {
        NSLog(@"%@",[dict objectForKey:@"user"]);
    } else {
        NSLog(@"%@", @"データが存在しません。");
    }
    
    [userModal removeFromSuperview];
    [blackMask removeFromSuperview];
    MessageViewController *mc = [[MessageViewController alloc]init];
    mc.type = PrivateMessage;
    mc.friendId = friendId;
    [fc.navigationController pushViewController:mc animated:YES];
    NSLog(@"friendId, %d", friendId);
}
@end
