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
        content = [[UIView alloc]initWithFrame:CGRectMake(0, 1, windowSize.size.width, 30)];
        UIView *outerContent = [[UIView alloc]initWithFrame:CGRectMake(0, 0, windowSize.size.width, 32)];
        
        content.backgroundColor = [UIColor colorWithRed:0.965 green:0.969 blue:0.973 alpha:1.0];
        outerContent.backgroundColor = [UIColor colorWithRed:0.898 green:0.910 blue:0.937 alpha:1.0];
        
        [outerContent addSubview:content];
        [self addSubview: outerContent];
        
        contentLabel = [[UILabel alloc] init];
        [self addSubview: contentLabel];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    UILabel *titleLabel = [[UILabel alloc] init];

    titleLabel.textColor = [UIColor colorWithRed:0.678 green:0.698 blue:0.733 alpha:1.0];
    UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W3" size:10.0f];
    titleLabel.font = font;
    titleLabel.text = title;
    [titleLabel sizeToFit];
    float width = titleLabel.frame.size.width;
    float height = titleLabel.frame.size.height;
    titleLabel.frame = CGRectMake(10, 11, width, height);
    
    [content addSubview: titleLabel];
    
}

- (void)setContent:(NSString *)content {
    contentLabel.textColor = [UIColor colorWithRed:0.333 green:0.333 blue:0.333 alpha:1.0];
    UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W3" size:10.0f];
    contentLabel.font = font;
    contentLabel.text = content;
    [contentLabel sizeToFit];
    float width = contentLabel.frame.size.width;
    float height = contentLabel.frame.size.height;
    contentLabel.frame = CGRectMake(18, 47, width, height);
}


@end
