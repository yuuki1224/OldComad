//
//  RundedButton.h
//  Comad
//
//  Created by 浅野 友希 on 2013/11/11.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSInteger{
    HeaderDone = 0,
    AddFriendInvite,
    AddFriendInCreateGroup,
    Plus
}RoundedButtonName;

@interface RoundedButton : UIButton {
    float iOSVersion;
}
@property(nonatomic)RoundedButtonName *name;
@property(nonatomic, retain)NSString *text;

- (id)initWithName:(RoundedButtonName)name;
-(void)setText:(NSString *)text;
- (void)setTitleInButton:(NSString *)title;
- (void)setName:(NSString *)nameString;
@end
