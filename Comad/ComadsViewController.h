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
#import "Header.h"
#import "AddComadViewController.h"

@interface ComadsViewController : UITabBarController<AddComadViewDelegate> {
    CGRect windowSize;
    float iOSVersion;
    
    Header *header;
    
    NewComadViewController *newComadTable;
    DateComadViewController *dateComadTable;
    PopularComadViewController *popularComadTable;
    MyComadViewController *myComadTable;
}

- (void)setInfo;
- (void)configure;
@end
