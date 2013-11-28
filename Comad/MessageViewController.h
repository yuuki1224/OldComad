//
//  MessageViewController.h
//  Comad
//
//  Created by 浅野 友希 on 2013/10/14.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConversationTextBox.h"
#import "Conversation.h"
#import "SocketIO.h"
#import "SpecialMoji.h"
#import "BlackMask.h"
#import "Basic.h"

@interface MessageViewController : UIViewController <ConversationTextBoxDelegate, SocketIODelegate, SpecialMojiDelegate> {
    CGRect windowSize;
    Conversation *conversation;
    SocketIO *socketIO;
    BlackMask *mask;
    SpecialMoji *sm;
    NSString *roomName;
}

@property (nonatomic)MessageType type;

@property (nonatomic)int userId;
//for Private
@property (nonatomic)int friendId;
@property (nonatomic, retain)NSString *friendImageName;
//for Group
@property (nonatomic)int groupId;
-(void)configure;
@end
