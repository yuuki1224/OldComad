//
//  Header.m
//  Comad
//
//  Created by 浅野 友希 on 2013/10/16.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "Header.h"

@implementation Header

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGRect windowSize = [[UIScreen mainScreen] bounds];
        
        UIView *headerRect = [[UIView alloc]initWithFrame:CGRectMake(0, 0, windowSize.size.width, 77)];
        headerRect.backgroundColor = [UIColor colorWithRed:0.282 green:0.549 blue:0.898 alpha:1.0];
        
        UIView *bottomBorder = [[UIView alloc]initWithFrame:CGRectMake(0, 77, windowSize.size.width, 1)];
        bottomBorder.backgroundColor = [UIColor colorWithRed:0.608 green:0.624 blue:0.639 alpha:1.0];
        
        [self addSubview:headerRect];
        [self addSubview:bottomBorder];
    }
    return self;
}

- (void)setTitle:(NSString *)titleString {
    CGRect windowSize = [[UIScreen mainScreen] bounds];
    UILabel *title = [[UILabel alloc]init];
    title.textColor = [UIColor whiteColor];
    UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W6" size:20.0f];
    title.font = font;
    title.text = titleString;
    [title sizeToFit];
    float width = title.frame.size.width;
    float height = title.frame.size.height;
    title.frame = CGRectMake(windowSize.size.width/2 - width/2, 40, width, height);
    [self addSubview:title];
}

- (void)setButton:(NSString *)btnImageName {
    CGRect windowSize = [[UIScreen mainScreen] bounds];
    
    UIImage *buttonImage = [UIImage imageNamed:btnImageName];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(10, 10, 50, 50);
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
    NSLog(@"backBtnclicked!!");
    //[self.delegate backBtnClickedDelegate];
}

@end
