//
//  MailSettingsViewController.h
//  Comad
//
//  Created by 浅野 友希 on 2013/11/05.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface MailSettingsViewController : UIViewController<HeaderDelegate, UITableViewDataSource, UITableViewDelegate> {
    CGRect windowSize;
    float iOSVersion;
    UITableView *mailSettingsTable;
}

- (void)configure;
@end
