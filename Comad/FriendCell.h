//
//  FriendCell.h
//  Comad
//
//  Created by 浅野 友希 on 2013/10/13.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FriendCellDelegate;

@interface FriendCell : UITableViewCell {
    CGRect windowSize;
}

@property (nonatomic, weak) id<FriendCellDelegate> delegate;
@property (nonatomic, retain) NSDictionary *userInfo;
@property (nonatomic, retain) NSDictionary *groupInfo;

- (void)setFriendCell:(BOOL)isNew;
- (void)setFriendCellWithURL;
- (void)setGroupCell;
- (void)setInviteButton;
- (void)setNoFriends;
@end

@protocol FriendCellDelegate <NSObject>
- (void)inviteButtonClicked;
@end
