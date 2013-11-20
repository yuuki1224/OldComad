//
//  NotificationSettingsViewController.h
//  Comad
//
//  Created by 浅野 友希 on 2013/11/05.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationSettingsViewController : UIViewController<UITableViewDataSource, UITabBarDelegate> {
    CGRect windowSize;
    UITableView *notificationSettingsTable;
}

@end
