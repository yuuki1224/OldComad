//
//  ComadsViewController+View.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/28.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "ComadsViewController.h"
#import "SVProgressHUD.h"
#import "ComadJsonClient.h"
#import "Image.h"

@implementation ComadsViewController (View)
- (void)setInfo {
    [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeBlack];
    
    //ネットワーク通信してる
    [[ComadJsonClient sharedClient] getIndexWhenSuccess:^(AFHTTPRequestOperation *operation, NSHTTPURLResponse *response, id responseObject) {
        /*
        _willComads = [responseObject objectForKey:@"will"];
        _groupComad = [responseObject objectForKey:@"group"];
        _comads = [responseObject objectForKey:@"comad"];
        NSLog(@"%@",_comads);
        NSLog(@"success");
        [SVProgressHUD dismiss];
        [self reloadData];
         */
    } failure:^(int statusCode, NSString *errorString) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:errorString message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [SVProgressHUD dismiss];
    }];
}

- (void)configure {
    /*
    self.tabBar.frame = CGRectMake(0, 75, 320, 50);
    self.tabBar.backgroundColor = [UIColor blueColor];
    */
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
    /*
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, 0)];
    self.tabBar.backgroundColor = [UIColor redColor];
    
    if(iOSVersion == 7.00){
        self.tabBar.tintColor = [UIColor colorWithRed:0.282 green:0.549 blue:0.898 alpha:1.0];
        self.tabBar.barTintColor = [UIColor colorWithRed:0.067 green:0.067 blue:0.067 alpha:1.0];
    }
    */
    newComadTable = [[NewComadViewController alloc]init];
    dateComadTable = [[DateComadViewController alloc]init];
    popularComadTable = [[PopularComadViewController alloc]init];
    myComadTable = [[MyComadViewController alloc]init];
    
    /*
    newComadTable.tabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:1];
    dateComadTable.tabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:1];
    popularComadTable.tabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemContacts tag:1];
    myComadTable.tabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemContacts tag:1];
    */
    /*
    UIOffset offset1 = UIOffsetMake(newComadTable.tabBarItem.titlePositionAdjustment.horizontal, -4.0);
    UIOffset offset2 = UIOffsetMake(dateComadTable.tabBarItem.titlePositionAdjustment.horizontal, -4.0);
    UIOffset offset3 = UIOffsetMake(popularComadTable.tabBarItem.titlePositionAdjustment.horizontal, -4.0);
    UIOffset offset4 = UIOffsetMake(myComadTable.tabBarItem.titlePositionAdjustment.horizontal, -4.0);
     */
    NSArray *tabs = [NSArray arrayWithObjects: newComadTable, dateComadTable, popularComadTable, myComadTable,nil];
    
    //タブのテキストカラー設定
    //[[wc tabBarItem] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil] forState:UIControlStateNormal];
    
    [self setViewControllers:tabs animated:NO];
}
@end
