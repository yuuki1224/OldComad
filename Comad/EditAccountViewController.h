//
//  EditAccountViewController.h
//  Comad
//
//  Created by 浅野 友希 on 2013/11/02.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditAccountViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    UITableView *editAccountTable;
    CGRect windowSize;
    float iOSVersion;
}

- (void)configure;
@end
