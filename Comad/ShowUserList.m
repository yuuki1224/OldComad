//
//  ShowUserList.m
//  Comad
//
//  Created by 浅野 友希 on 2013/10/25.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "ShowUserList.h"

@implementation ShowUserList

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGRect windowSize = [[UIScreen mainScreen] bounds];
        content = [[UIView alloc]initWithFrame:CGRectMake(0, 0, windowSize.size.width, 33)];
        UIView *outerContent = [[UIView alloc]initWithFrame:CGRectMake(0, 0, windowSize.size.width, 35)];
        
        content.backgroundColor = [UIColor colorWithRed:0.902 green:0.898 blue:0.882 alpha:1.0];
        outerContent.backgroundColor = [UIColor colorWithRed:0.878 green:0.878 blue:0.871 alpha:1.0];
        
        [outerContent addSubview:content];
        [self addSubview: outerContent];
        
        contentLabel = [[UILabel alloc] init];
        [self addSubview: contentLabel];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor colorWithRed:0.333 green:0.333 blue:0.333 alpha:1.0];
    UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W6" size:12.0f];
    titleLabel.font = font;
    titleLabel.text = title;
    [titleLabel sizeToFit];
    titleLabel.frame = CGRectMake(10, 10, titleLabel.frame.size.width, titleLabel.frame.size.height);
    titleLabel.backgroundColor = [UIColor colorWithRed:0.902 green:0.898 blue:0.882 alpha:1.0];
    
    [content addSubview: titleLabel];
}

- (void)setContent:(NSString *)content {
    contentLabel.textColor = [UIColor colorWithRed:0.333 green:0.333 blue:0.333 alpha:1.0];
    UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W3" size:10.0f];
    contentLabel.font = font;
    contentLabel.text = content;
    [contentLabel sizeToFit];
    contentLabel.frame = CGRectMake(18, 47, contentLabel.frame.size.width, contentLabel.frame.size.height);
}


@end
