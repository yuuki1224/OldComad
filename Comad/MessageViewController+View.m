//
//  MessageViewController+View.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/10.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "MessageViewController.h"
#import "ConversationTextBox.h"
#import "Conversation.h"

@implementation MessageViewController (View)

-(void)configure {
    conversation = [[Conversation alloc]initWithFrame:CGRectMake(0, 77, windowSize.size.width, windowSize.size.height - 77)];
    if((int)iOSVersion == 6){
        conversation.frame = CGRectMake(0, 48, windowSize.size.width, windowSize.size.height - 48);
    }
    ConversationTextBox *textBox = [[ConversationTextBox alloc]init];
    textBox.delegate = self;
    
    [self.view addSubview:conversation];
    [self.view addSubview:textBox];
}

@end
