//
//  OthersLabel.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/02.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "OthersLabel.h"

@implementation OthersLabel

- (id)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        // Initialization code
        self.textColor = [UIColor colorWithRed:0.188 green:0.239 blue:0.314 alpha:1.0];
        UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W3" size:11.0f];
        self.backgroundColor = [UIColor colorWithRed:0.855 green:0.886 blue:0.929 alpha:1.0];
        self.font = font;
        self.text = name;
        [self sizeToFit];
       }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
