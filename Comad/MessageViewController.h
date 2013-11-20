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

@interface MessageViewController : UIViewController <ConversationTextBoxDelegate, SocketIODelegate, SpecialMojiDelegate> {
    CGRect windowSize;
    Conversation *conversation;
    SocketIO *socketIO;
    BlackMask *mask;
    SpecialMoji *sm;
}
-(void)configure;
@end
