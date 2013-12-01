//
//  TweetButton.m
//  Comad
//
//  Created by 浅野 友希 on 2013/12/02.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "TweetButton.h"
#import "Image.h"

@implementation TweetButton
@synthesize tweet;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = CGRectMake(0, 0, 75, 30);
        UIImage *onBack = [UIImage imageNamed:@"onBack.png"];
        UIImage *offBack = [UIImage imageNamed:@"offBack.png"];
        UIImage *onCover = [UIImage imageNamed:@"onCover.png"];
        UIImage *offCover = [UIImage imageNamed:@"offCover.png"];
        
        onBackResize = [Image resizeImage:onBack resizeWidth:75 resizeHeight:30];
        offBackResize = [Image resizeImage:offBack resizeWidth:75 resizeHeight:30];
        onCoverResize = [Image resizeImage:onCover resizeWidth:35 resizeHeight:26];
        offCoverResize = [Image resizeImage:offCover resizeWidth:35 resizeHeight:26];
        
        backView = [[UIImageView alloc]initWithImage:offBackResize];
        coverView = [[UIImageView alloc]initWithImage:offCover];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backTabpped:)];
        [backView addGestureRecognizer: tapGesture];
        backView.userInteractionEnabled = YES;
        
        coverView.frame = CGRectMake(2, 2, 35, 26);
        [backView addSubview: coverView];
        
        [self addSubview: backView];
    }
    return self;
}

- (void)backTabpped:(UITapGestureRecognizer *)sender {
    //ONの時にタップされたら
    if(tweet){
        tweet = false;
        backView.image = onBackResize;
        [UIView animateWithDuration:0.2f
                         animations:^{
                             coverView.image = onCoverResize;
                             coverView.frame = CGRectMake(39, 2, 35, 26);
                         }];
    //OFFの時にタップされたら
    }else{
        tweet = true;
        backView.image = offBackResize;
        [UIView animateWithDuration:0.2f
                         animations:^{
                             coverView.image = offCoverResize;
                             coverView.frame = CGRectMake(2, 2, 35, 26);
                         }];

    }
}

@end
