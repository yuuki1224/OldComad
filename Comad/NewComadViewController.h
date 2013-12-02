//
//  NewComadViewController.h
//  Comad
//
//  Created by 浅野 友希 on 2013/11/28.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowComadViewController.h"

@interface NewComadViewController : UITableViewController {
    CGRect windowSize;
    float iOSVersion;
    ShowComadViewController *sc;
}

@property (nonatomic, retain)NSArray *NewComad;
@end
