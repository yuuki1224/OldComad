//
//  ShowComadViewController+View.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/13.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "ShowComadViewController.h"
#import "ConversationTextBox.h"
#import "Conversation.h"
#import "BasicLabel.h"

@implementation ShowComadViewController (View)
- (void)configure {
    scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(0, 78, windowSize.size.width, windowSize.size.height - 132);
    scrollView.contentSize = CGSizeMake(windowSize.size.width, 608);
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: scrollView];
    
    UIView *innerTitleView = [[UIView alloc]initWithFrame:CGRectMake(0, 1, windowSize.size.width, 30)];
    UIView *outerTitleView = [[UIView alloc]initWithFrame:CGRectMake(0, 180, windowSize.size.width, 32)];
    innerTitleView.backgroundColor = [UIColor colorWithRed:0.965 green:0.969 blue:0.973 alpha:1.0];
    outerTitleView.backgroundColor = [UIColor colorWithRed:0.898 green:0.910 blue:0.937 alpha:1.0];
    [outerTitleView addSubview:innerTitleView];
    [scrollView addSubview:outerTitleView];
    
    BasicLabel *titleLabel = [[BasicLabel alloc]initWithName:ShowComadParticipationTitle];
    titleLabel.text = @"会話";
    [titleLabel sizeToFit];
    titleLabel.frame = CGRectMake(10, 11, titleLabel.frame.size.width, titleLabel.frame.size.height);
    [innerTitleView addSubview: titleLabel];
    
    conversation = [[Conversation alloc]init];
    conversation = [[Conversation alloc]initWithFrame:CGRectMake(0, 212, windowSize.size.width, 406)];
    [scrollView addSubview:conversation];
    
    ConversationTextBox *textBox = [[ConversationTextBox alloc]init];
    textBox.delegate = self;
    [self.view addSubview: textBox];
}
@end
