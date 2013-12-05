//
//  Header.m
//  Comad
//
//  Created by 浅野 友希 on 2013/10/16.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "Header.h"
#import "Image.h"

@implementation Header

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        windowSize = [[UIScreen mainScreen] bounds];
        iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        
        // iOS7
        if((int)iOSVersion == 7){
            UIView *headerRect = [[UIView alloc]initWithFrame:CGRectMake(0, 0, windowSize.size.width, 77)];
            headerRect.backgroundColor = [UIColor colorWithRed:0.282 green:0.549 blue:0.898 alpha:1.0];
            
            UIView *bottomBorder = [[UIView alloc]initWithFrame:CGRectMake(0, 77, windowSize.size.width, 1)];
            bottomBorder.backgroundColor = [UIColor colorWithRed:0.608 green:0.624 blue:0.639 alpha:1.0];
            
            [self addSubview:headerRect];
            [self addSubview:bottomBorder];
        //iOS6
        }else if((int)iOSVersion == 6){
            self.frame = CGRectMake(0, 0, windowSize.size.width, 48);
            self.backgroundColor = [UIColor blackColor];
            UIImage *headerImage = [UIImage imageNamed:@"headerForiOS6.png"];
            UIImageView *headerImageView = [[UIImageView alloc]initWithImage: headerImage];
            headerImageView.frame = CGRectMake(0, 0, windowSize.size.width, 48);
            [self addSubview: headerImageView];
        }
    }
    return self;
}

- (void)setTitle:(NSString *)titleString {
    UILabel *title = [[UILabel alloc]init];
    title.shadowColor = [UIColor colorWithRed:0.251 green:0.451 blue:0.780 alpha:1.0];
    title.shadowOffset = CGSizeMake(0, -1);
    title.textColor = [UIColor whiteColor];
    UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W6" size:18.0f];
    title.font = font;
    title.text = titleString;
    title.backgroundColor = [UIColor colorWithRed:0.298 green:0.541 blue:0.925 alpha:1.0];
    [title sizeToFit];
    
    if((int)iOSVersion == 7){
        title.frame = CGRectMake(windowSize.size.width/2 - title.frame.size.width/2, 40, title.frame.size.width, title.frame.size.height);
    }else if ((int)iOSVersion == 6){
        title.frame = CGRectMake(windowSize.size.width/2 - title.frame.size.width/2, 17, title.frame.size.width, title.frame.size.height);
    }
    [self addSubview:title];
}

- (void)setComadTitle {
    UIImage *comadLogo = [UIImage imageNamed:@"comadInHeader.png"];
    UIImageView *comadLogoImageView = [[UIImageView alloc]initWithImage: comadLogo];
    comadLogoImageView.frame = CGRectMake((windowSize.size.width - 97)/2, 16, 97, 20);
    [self addSubview: comadLogoImageView];
}

- (void)setButton:(NSString *)btnImageName {
    UIImage *buttonImage = [UIImage imageNamed:btnImageName];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    if((int)iOSVersion == 7){
        btn.frame = CGRectMake(10, 10, 50, 50);
    }else if((int)iOSVersion == 6){
        btn.frame = CGRectMake(10, 0, 50, 50);
    }
    
    [btn setImage:buttonImage forState:UIControlStateNormal];
    [self addSubview:btn];
}

- (void)setBackBtn {
    /*
    UIImage *image = [UIImage imageNamed:@"back.png"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(10, 120, 50, 50);
    [btn setImage:image forState:UIControlStateNormal];
    //[btn addTarget:self action:@selector(backBtnClicked:)forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn2.frame = CGRectMake(10, 110, 100, 30);
    [btn2 setTitle:@"押してね" forState:UIControlStateNormal];
    [btn2 setTitle:@"ぽち" forState:UIControlStateHighlighted];
    [btn2 setTitle:@"押せません" forState:UIControlStateDisabled];
    // ボタンがタッチダウンされた時にhogeメソッドを呼び出す
    [self addSubview:btn2];
    */
}

- (void)backBtnClicked:(UIButton *)button {
    //[self.delegate backBtnClickedDelegate];
}

@end
