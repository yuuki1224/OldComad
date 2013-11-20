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
    }else{
        bubble = [[Bubble alloc]initWithName:Left];
    }
    bubble.mail = conversationText;
    bubble.userName = userName;
    bubble.frame = CGRectMake(0, conversationHeight, windowSize.size.width, 100);
    [self addSubview: bubble];
    self.contentSize = CGSizeMake(windowSize.size.width, conversationHeight + 200);
    NSLog(@"%d", conversationHeight);
    conversationHeight += bubble.frame.size.height;
}

- (void)addStamp:(int)stampNum :(NSString *)userName {
    NSBundle* bundle = [NSBundle mainBundle];
    NSString* path = [bundle pathForResource:@"Stamp" ofType:@"plist"];
    NSDictionary* dic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    UIImage *stampImage = [UIImage imageNamed: [dic objectForKey:[NSString stringWithFormat:@"%i",stampNum]]];
    UIImage *stampResize = [Image resizeImage:stampImage resizeWidth:120 resizeHeight:120];
    UIImageView *stampView = [[UIImageView alloc]initWithImage: stampResize];
    stampView.frame = CGRectMake(150, conversationHeight, 120, 120);
    
    [self addSubview: stampView];
    self.contentSize = CGSizeMake(windowSize.size.width, conversationHeight + 200);
    NSLog(@"%d", conversationHeight);
    conversationHeight += stampView.frame.size.height;
}

@end
