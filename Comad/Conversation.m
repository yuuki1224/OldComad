//
//  Conversation.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/10.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "Conversation.h"
#import "Bubble.h"
#import "Image.h"
#import "Stamp.h"

@implementation Conversation
@synthesize conversationHeight;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        conversationHeight = 0;
        windowSize = [[UIScreen mainScreen] bounds];
    }
    return self;
}

- (void)viewDidLoad {
}

- (void)addConversation:(NSString *)conversationText :(NSString *)userName {
    Bubble *bubble;
    if([userName isEqual:@"asano.png"]){
        bubble = [[Bubble alloc]initWithName:Right];
        bubble.mail = conversationText;
        bubble.userName = userName;
        
        CGSize bounds = CGSizeMake(150, 500);
        UILineBreakMode mode = UILineBreakModeWordWrap;
        CGSize size = [bubble.mail sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:bounds lineBreakMode:mode];
        float height = size.height + 16;
        
        bubble.frame = CGRectMake(0, conversationHeight, windowSize.size.width, (int)height + 15);
        [self addSubview: bubble];
        self.contentSize = CGSizeMake(windowSize.size.width, conversationHeight + 200);
        conversationHeight += bubble.frame.size.height;
    }else{
        bubble = [[Bubble alloc]initWithName:Left];
        bubble.mail = conversationText;
        bubble.userName = userName;
        
        CGSize bounds = CGSizeMake(150, 500);
        UILineBreakMode mode = UILineBreakModeWordWrap;
        CGSize size = [bubble.mail sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:bounds lineBreakMode:mode];
        float height = size.height + 16;
        
        bubble.frame = CGRectMake(0, conversationHeight, windowSize.size.width, (int)height + 30);
        [self addSubview: bubble];
        self.contentSize = CGSizeMake(windowSize.size.width, conversationHeight + 200);
        conversationHeight += bubble.frame.size.height;
    }
}

- (void)addStamp:(int)stampNum :(NSString *)userName {
    NSBundle* bundle = [NSBundle mainBundle];
    NSString* path = [bundle pathForResource:@"Stamp" ofType:@"plist"];
    NSDictionary* dic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *stampImageName = [dic objectForKey: [NSString stringWithFormat:@"%i", stampNum]];
    
    if([userName isEqual:@"asano"]){
        Stamp *stamp = [[Stamp alloc]initWithName: Right];
        stamp.userName = userName;
        [stamp setStamp: stampImageName conversationHeight: conversationHeight];
        [self addSubview: stamp];
        
        self.contentSize = CGSizeMake(windowSize.size.width, conversationHeight + 200);
        NSLog(@"%d", conversationHeight);
        conversationHeight += stamp.frame.size.height;
    }else{
        Stamp *stamp = [[Stamp alloc]initWithName: Left];
        stamp.userName = @"murata.png";
        [stamp setStamp: stampImageName conversationHeight:conversationHeight];
        [self addSubview: stamp];
        
        self.contentSize = CGSizeMake(windowSize.size.width, conversationHeight + 200);
        NSLog(@"%d", conversationHeight);
        conversationHeight += stamp.frame.size.height;
    }
}

@end