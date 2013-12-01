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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = CGRectMake(5, 0, 305, 31);
        onNowImage = [Image resizeImage:[UIImage imageNamed:@"nowOn.png"] resizeWidth:61 resizeHeight:32];
        offNowImage = [Image resizeImage:[UIImage imageNamed:@"nowOff.png"] resizeWidth:61 resizeHeight:32];
        onTodayImage = [Image resizeImage:[UIImage imageNamed:@"todayOn.png"] resizeWidth:61 resizeHeight:32];
        offTodayImage = [Image resizeImage:[UIImage imageNamed:@"todayOff.png"] resizeWidth:61 resizeHeight:32];
        onTommorowImage = [Image resizeImage:[UIImage imageNamed:@"tommorowOn.png"] resizeWidth:61 resizeHeight:32];
        offTommorowImage = [Image resizeImage:[UIImage imageNamed:@"tommorowOff.png"] resizeWidth:61 resizeHeight:32];
        onFutureImage = [Image resizeImage:[UIImage imageNamed:@"futureOn.png"] resizeWidth:61 resizeHeight:32];
        offFutureImage = [Image resizeImage:[UIImage imageNamed:@"futureOff.png"] resizeWidth:61 resizeHeight:32];
        onAnytimeImage = [Image resizeImage:[UIImage imageNamed:@"anytimeOn.png"] resizeWidth:61 resizeHeight:32];
        offAnytimeImage = [Image resizeImage:[UIImage imageNamed:@"anytimeOff.png"] resizeWidth:61 resizeHeight:32];
        
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
    nowImageView.image = onNowImage;
    todayImageView.image = offTodayImage;
    tommorowImageView.image = offTommorowImage;
    futureImageView.image = offFutureImage;
    anytimeImageView.image = offAnytimeImage;
}

- (void)todayTabpped:(UITapGestureRecognizer *)sender {
    nowImageView.image = offNowImage;
    todayImageView.image = onTodayImage;
    tommorowImageView.image = offTommorowImage;
    futureImageView.image = offFutureImage;
    anytimeImageView.image = offAnytimeImage;
}

- (void)tommorowTabpped:(UITapGestureRecognizer *)sender {
    nowImageView.image = offNowImage;
    todayImageView.image = offTodayImage;
    tommorowImageView.image = onTommorowImage;
    futureImageView.image = offFutureImage;
    anytimeImageView.image = offAnytimeImage;
}

- (void)futureTabpped:(UITapGestureRecognizer *)sender {
    nowImageView.image = offNowImage;
    todayImageView.image = offTodayImage;
    tommorowImageView.image = offTommorowImage;
    futureImageView.image = onFutureImage;
    anytimeImageView.image = offAnytimeImage;
}

- (void)anytimeTabpped:(UITapGestureRecognizer *)sender {
    nowImageView.image = offNowImage;
    todayImageView.image = offTodayImage;
    tommorowImageView.image = offTommorowImage;
    futureImageView.image = offFutureImage;
    anytimeImageView.image = onAnytimeImage;
}
@end
