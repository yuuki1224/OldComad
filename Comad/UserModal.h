//
//  UserModal.h
//  Comad
//
//  Created by 浅野 友希 on 2013/10/13.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserModalDelegate;

typedef enum : NSInteger{
    Friend = 0,
    InAddFriend
}UserModalType;

@interface UserModal : UIView {
}

@property (nonatomic, weak) id<UserModalDelegate> delegate;
@property (nonatomic, retain) NSDictionary *userInfo;

- (id)initWithName:(UserModalType)name;
- (void)closeModalBtnClicked;
- (void)loadView;
@end

@protocol UserModalDelegate <NSObject>
- (void)closeModalBtnClickedDelegate;
- (void)showUserBtnClickedDelegate;
- (void)inviteComadBtnClickedDelegate;
- (void)sendMessageBtnClickedDelegate;
- (void)addFriendBtnClickedDelegate:(int)friendId;
- (void)blockBtnClickedDelegate;
@end
