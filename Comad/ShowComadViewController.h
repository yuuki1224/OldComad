//
//  ShowComadViewController.h
//  Comad
//
//  Created by 浅野 友希 on 2013/10/14.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowComad.h"
#import "ConversationTextBox.h"
#import "Conversation.h"
#import "SocketIO.h"

@interface ShowComadViewController : UIViewController <ConversationTextBoxDelegate>{
    ShowComad *showComad;
    CGRect windowSize;
    UIScrollView *scrollView;
    Conversation *conversation;
    SocketIO *socketIO;
}
@property (nonatomic, retain) NSDictionary *comadInfo;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *imageName;
-(void)configure;
@end
