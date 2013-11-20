//
//  OthersButton.h
//  Comad
//
//  Created by 浅野 友希 on 2013/11/02.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSInteger{
    AddFriend = 0,
    MyPage,
    Settings,
    Map,
    History,
    Message
}OthersButtonName;

@interface OthersButton : UIButton
@property (nonatomic, retain) NSString *imageName;
@property (nonatomic, retain) NSString *labelName;

- (id)initWithName:(OthersButtonName)name;
@end
