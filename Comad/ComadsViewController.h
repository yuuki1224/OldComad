//
//  ComadsViewController.h
//  Comad
//
//  Created by 浅野 友希 on 2013/11/28.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewComadViewController.h"
#import "DateComadViewController.h"
#import "PopularComadViewController.h"
#import "MyComadViewController.h"

@interface ComadsViewController : UITabBarController {
    CGRect windowSize;
    
    NewComadViewController *newComadTable;
    DateComadViewController *dateComadTable;
    PopularComadViewController *popularComadTable;
    MyComadViewController *myComadTable;
}

- (void)setInfo;
- (void)configure;
@end