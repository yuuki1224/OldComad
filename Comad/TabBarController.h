//
//  TabBarController.h
//  Comad
//
//  Created by 浅野 友希 on 2013/10/12.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendsViewController.h"
#import "UserModal.h"
#import "BlackMask.h"
#import "WorksViewController.h"
#import "FriendsViewController.h"
#import "OthersViewController.h"

@interface TabBarController : UITabBarController <FriendViewControllerDelegate, UserModalDelegate> {
    UserModal *userModal;
    BlackMask *blackMask;
    
    WorksViewController *wc;
    FriendsViewController *fc;
    OthersViewController *oc;
}

-(void)showModalView;
-(void)closeModalBtnClickedDelegate;
@end
