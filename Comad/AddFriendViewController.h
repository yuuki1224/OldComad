//
//  AddFriendViewController.h
//  Comad
//
//  Created by 浅野 友希 on 2013/10/14.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import "AddFriendMenu.h"
#import "UserModal.h"
#import "BlackMask.h"
#import "FriendCell.h"
#import "Header.h"

@interface AddFriendViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, AddFriendMenuDelegate, UserModalDelegate, FriendCellDelegate, BlackMaskDelegate, HeaderDelegate, UIAlertViewDelegate> {
    CGRect windowSize;
    float iOSVersion;
    UserModal *userModal;
    BlackMask *blackMask;
    UITableView *addFriendsTable;
    NSMutableArray *facebookFriends;
}

-(void)configure;
- (void)setInfo;
@end
