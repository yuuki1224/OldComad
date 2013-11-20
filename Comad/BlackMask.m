//
//  BlackMask.m
//  Comad
//
//  Created by 浅野 友希 on 2013/10/15.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "BlackMask.h"

@implementation BlackMask

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGRect windowSize = [[UIScreen mainScreen] bounds];
        self.frame = CGRectMake(0, 0, windowSize.size.width, windowSize.size.height);
        self.backgroundColor = [UIColor blackColor];
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
