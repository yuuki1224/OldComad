//
//  ShowUserViewController.h
//  Comad
//
//  Created by 浅野 友希 on 2013/10/14.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicLabel.h"
#import "ShowUserList.h"
#import "Header.h"

@interface ShowUserViewController : UIViewController<HeaderDelegate> {
    NSString *_name;
    CGRect windowSize;
    float iOSVersion;
    BasicLabel *nameLabel;
    BasicLabel *userIdLabel;
    BasicLabel *occupationLabel;
    UIScrollView *scrollView;
    ShowUserList *showUserList;
    ShowUserList *question1;
    ShowUserList *question2;
    ShowUserList *question3;
    ShowUserList *question4;
}

@property (nonatomic, assign) BOOL me;
@property (nonatomic, retain) NSDictionary *userInfo;
- (void)configure;
- (void)reloadLabel;
@end