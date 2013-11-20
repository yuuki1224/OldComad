//
//  AddFriendMenu.h
//  Comad
//
//  Created by 浅野 友希 on 2013/11/17.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddFriendMenuDelegate;

@interface AddFriendMenu : UIView {
    CGRect windowSize;
}

@property (nonatomic, weak) id<AddFriendMenuDelegate> delegate;
@end

@protocol AddFriendMenuDelegate <NSObject>
- (void)idSearchDelegate;
- (void)qrCodeDelegate;
- (void)addFriendDelegate;
@end