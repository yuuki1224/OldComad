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
#import "BasicLabel.h"

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

- (void)setNoConversation {
    BasicLabel *noConversationText = [[BasicLabel alloc]initWithName:NoConversationText];
    noConversationText.text = @"会話はまだありません。";
    [noConversationText sizeToFit];
    noConversationText.frame = CGRectMake((windowSize.size.width - noConversationText.frame.size.width)/2, 125, noConversationText.frame.size.width, noConversationText.frame.size.height);
    
    UIImage *noConversationImage = [UIImage imageNamed:@"nochat.png"];
    UIImageView *noConversation = [[UIImageView alloc]initWithImage:noConversationImage];
    noConversation.frame = CGRectMake((windowSize.size.width - 97)/2, noConversationText.frame.origin.y + noConversationText.frame.size.height + 5, 97, 20.5);
    [self addSubview: noConversationText];
    [self addSubview: noConversation];
}

- (void)addConversation:(NSString *)conversationText :(NSString *)userName :(NSString *)imageName{
    Bubble *bubble;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *meImageName = [[defaults objectForKey:@"user"] objectForKey:@"imageName"];
    
    //自分のだったら右に付け足す
    if([meImageName isEqual:imageName]){
        NSLog(@"右につける");
        bubble = [[Bubble alloc]initWithName:Right];
        bubble.mail = conversationText;
        bubble.userName = [[defaults objectForKey:@"user"] objectForKey:@"name"];
        bubble.imageName = imageName;
        [bubble setLabel];
        
        CGSize bounds = CGSizeMake(150, 500);
        UILineBreakMode mode = UILineBreakModeWordWrap;
        CGSize size = [bubble.mail sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:bounds lineBreakMode:mode];
        float height = size.height + 16;
        
        bubble.frame = CGRectMake(0, conversationHeight, windowSize.size.width, (int)height + 15);
        [self addSubview: bubble];
        self.contentSize = CGSizeMake(windowSize.size.width, conversationHeight + 200);
        conversationHeight += bubble.frame.size.height;
    
    //自分の以外だったら左に付け足す
    }else{
        NSLog(@"左につける");
        bubble = [[Bubble alloc]initWithName:Left];
        bubble.mail = conversationText;
        bubble.userName = userName;
        bubble.imageName = imageName;
        [bubble setLabel];
        
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

- (void)addStamp:(int)stampNum :(NSString *)userName :(NSString *)imageName {
    NSBundle* bundle = [NSBundle mainBundle];
    NSString* path = [bundle pathForResource:@"Stamp" ofType:@"plist"];
    NSDictionary* dic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *stampImageName = [dic objectForKey: [NSString stringWithFormat:@"%i", stampNum]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *meImageName = [[defaults objectForKey:@"user"] objectForKey:@"imageName"];
    
    //自分のだったら右に付け足す
    if([meImageName isEqual:imageName]){
        Stamp *stamp = [[Stamp alloc]initWithName: Right];
        stamp.userName = userName;
        [stamp setStamp: stampImageName conversationHeight: conversationHeight];
        [self addSubview: stamp];
        
        self.contentSize = CGSizeMake(windowSize.size.width, conversationHeight + 200);
        conversationHeight += stamp.frame.size.height;
    //自分以外だったら左に付け足す
    }else{
        Stamp *stamp = [[Stamp alloc]initWithName: Left];
        stamp.userName = userName;
        stamp.imageName = imageName;
        [stamp setStamp: stampImageName conversationHeight:conversationHeight];
        [self addSubview: stamp];
        
        self.contentSize = CGSizeMake(windowSize.size.width, conversationHeight + 200);
        conversationHeight += stamp.frame.size.height;
    }
}

@end