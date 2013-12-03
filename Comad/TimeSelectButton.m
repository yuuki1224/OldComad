//
//  TimeSelectButton.m
//  Comad
//
//  Created by 浅野 友希 on 2013/12/02.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "TimeSelectButton.h"
#import "Image.h"

@implementation TimeSelectButton

@synthesize select;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.select = @"なう";
        // Initialization code
        self.frame = CGRectMake(5, 0, 305, 31);
        onNowImage = [UIImage imageNamed:@"nowOn.png"];
        offNowImage = [UIImage imageNamed:@"nowOff.png"];
        onTodayImage = [UIImage imageNamed:@"todayOn.png"];
        offTodayImage = [UIImage imageNamed:@"todayOff.png"];
        onTommorowImage = [UIImage imageNamed:@"tommorowOn.png"];
        offTommorowImage = [UIImage imageNamed:@"tommorowOff.png"];
        onFutureImage = [UIImage imageNamed:@"futureOn.png"];
        offFutureImage = [UIImage imageNamed:@"futureOff.png"];
        onAnytimeImage = [UIImage imageNamed:@"anytimeOn.png"];
        offAnytimeImage = [UIImage imageNamed:@"anytimeOff.png"];
        
        nowImageView = [[UIImageView alloc]initWithImage:onNowImage];
        todayImageView = [[UIImageView alloc]initWithImage:offTodayImage];
        tommorowImageView = [[UIImageView alloc]initWithImage:offTommorowImage];
        futureImageView = [[UIImageView alloc]initWithImage:offFutureImage];
        anytimeImageView = [[UIImageView alloc]initWithImage:offAnytimeImage];
        
        //Gesture追加
        UITapGestureRecognizer *nowTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(nowTabpped:)];
        UITapGestureRecognizer *todayTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(todayTabpped:)];
        UITapGestureRecognizer *tommorowTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tommorowTabpped:)];
        UITapGestureRecognizer *futureTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(futureTabpped:)];
        UITapGestureRecognizer *anytimeTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(anytimeTabpped:)];
        
        [nowImageView addGestureRecognizer: nowTapGesture];
        [todayImageView addGestureRecognizer: todayTapGesture];
        [tommorowImageView addGestureRecognizer: tommorowTapGesture];
        [futureImageView addGestureRecognizer: futureTapGesture];
        [anytimeImageView addGestureRecognizer: anytimeTapGesture];
        
        nowImageView.userInteractionEnabled = YES;
        todayImageView.userInteractionEnabled = YES;
        tommorowImageView.userInteractionEnabled = YES;
        futureImageView.userInteractionEnabled = YES;
        anytimeImageView.userInteractionEnabled = YES;
        
        nowImageView.frame = CGRectMake(0, 0, 61, 32);
        todayImageView.frame = CGRectMake(61, 0, 61, 32);
        tommorowImageView.frame = CGRectMake(122, 0, 61, 32);
        futureImageView.frame = CGRectMake(183, 0, 61, 32);
        anytimeImageView.frame = CGRectMake(244, 0, 61, 32);
        
        [self addSubview:nowImageView];
        [self addSubview:todayImageView];
        [self addSubview:tommorowImageView];
        [self addSubview:futureImageView];
        [self addSubview:anytimeImageView];
    }
    return self;
}

- (void)nowTabpped:(UITapGestureRecognizer *)sender {
    self.select = @"なう";
    nowImageView.image = onNowImage;
    todayImageView.image = offTodayImage;
    tommorowImageView.image = offTommorowImage;
    futureImageView.image = offFutureImage;
    anytimeImageView.image = offAnytimeImage;
}

- (void)todayTabpped:(UITapGestureRecognizer *)sender {
    self.select = @"今日";
    nowImageView.image = offNowImage;
    todayImageView.image = onTodayImage;
    tommorowImageView.image = offTommorowImage;
    futureImageView.image = offFutureImage;
    anytimeImageView.image = offAnytimeImage;
}

- (void)tommorowTabpped:(UITapGestureRecognizer *)sender {
    self.select = @"明日";
    nowImageView.image = offNowImage;
    todayImageView.image = offTodayImage;
    tommorowImageView.image = onTommorowImage;
    futureImageView.image = offFutureImage;
    anytimeImageView.image = offAnytimeImage;
}

- (void)futureTabpped:(UITapGestureRecognizer *)sender {
    self.select = @"明日以降";
    nowImageView.image = offNowImage;
    todayImageView.image = offTodayImage;
    tommorowImageView.image = offTommorowImage;
    futureImageView.image = onFutureImage;
    anytimeImageView.image = offAnytimeImage;
}

- (void)anytimeTabpped:(UITapGestureRecognizer *)sender {
    self.select = @"いつでも";
    nowImageView.image = offNowImage;
    todayImageView.image = offTodayImage;
    tommorowImageView.image = offTommorowImage;
    futureImageView.image = offFutureImage;
    anytimeImageView.image = onAnytimeImage;
}
@end
