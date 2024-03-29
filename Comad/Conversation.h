//
//  Conversation.h
//  Comad
//
//  Created by 浅野 友希 on 2013/11/10.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicLabel.h"

@interface Conversation : UIScrollView {
    CGRect windowSize;
    BasicLabel *noConversationText;
    UIImageView *noConversation;
}
@property (nonatomic) int conversationHeight;

- (void)removeNoConversation;
-(void)addConversation:(NSString *)conversationText:(NSString *)userName:(NSString *)imageName;
-(void)addStamp:(int)stampNum:(NSString *)userName:(NSString *)imageName;
- (void)setNoConversation;
@end