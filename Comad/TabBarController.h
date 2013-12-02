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
#import "ComadsViewController.h"
#import "FriendsViewController.h"
#import "OthersViewController.h"
#import "BlackMask.h"

@interface TabBarController : UITabBarController <FriendViewControllerDelegate, UserModalDelegate, BlackMaskDelegate> {
    UserModal *userModal;
    BlackMask *blackMask;
    
    ComadsViewController *cc;
    FriendsViewController *fc;
    OthersViewController *oc;
}

-(void)showModalView;
-(void)closeModalBtnClickedDelegate;
@end
