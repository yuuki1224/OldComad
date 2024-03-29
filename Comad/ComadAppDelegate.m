//
//  ComadAppDelegate.m
//  Comad
//
//  Created by 浅野 友希 on 2013/10/12.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "ComadAppDelegate.h"
#import "TabBarController.h"
#import "LoginViewController.h"
#import "Configuration.h"

@implementation ComadAppDelegate

@synthesize window, largeFont, smallFont, friendReload;
static ComadAppDelegate* _sharedInstance = nil;

- (id)init {
    self = [super init];
    if(!self){
        return nil;
    }
    _sharedInstance = self;
    return self;
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];  //statusbar白くなる
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.friendReload = NO;
    
    if([Configuration user]){
        tc = [[TabBarController alloc]init];
        //[self.window addSubview:tc.view];
        [self.window setRootViewController: tc];
    }else{
        lc = [[LoginViewController alloc]init];
        //[self.window addSubview:lc.view];
        [self.window setRootViewController: lc];
    }
    [self.window makeKeyAndVisible];
}

+(ComadAppDelegate *)sharedAppDelegate {
    return _sharedInstance;
}

@end
