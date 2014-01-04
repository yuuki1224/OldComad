//
//  ComadAppDelegate.h
//  Comad
//
//  Created by 浅野 友希 on 2013/10/12.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "TabBarController.h"
#import "LoginViewController.h"

@interface ComadAppDelegate : NSObject <UIApplicationDelegate> {
    TabBarController *tc;
    LoginViewController *lc;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UIFont *largeFont;
@property (nonatomic, retain) UIFont *smallFont;
@property (nonatomic) BOOL friendReload;

+(ComadAppDelegate *)sharedAppDelegate;
@end
