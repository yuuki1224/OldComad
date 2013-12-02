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
        UITapGestureRecognizer *blackMaskTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(blackMaskTapped:)];
        [self addGestureRecognizer:blackMaskTapGesture];
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(void)blackMaskTapped:(UITapGestureRecognizer *)sender {
    [self.delegate blackMaskTapped];
}

@end
