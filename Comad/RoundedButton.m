//
//  RundedButton.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/11.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "RoundedButton.h"
#import <QuartzCore/QuartzCore.h>

@implementation RoundedButton
@synthesize name, text;

- (id)initWithName:(RoundedButtonName)name {
    //self.name = name;
    self = [super init];
    if (self) {
        iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        switch (name) {
            case HeaderDone:{
                [self.layer setBorderColor:[[UIColor whiteColor] CGColor]];
                [self.layer setBorderWidth:1.0];
                [self.layer setCornerRadius:6.0];
                [self setClipsToBounds:YES];
                [self setBackgroundColor:[UIColor colorWithRed:0.282 green:0.549 blue:0.898 alpha:1.0]];
                //[self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                //UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W6" size:15.0f];
                //[self setFont:font];
                //[self setTitle:@"完了" forState:UIControlStateNormal];
                break;
            }
            case AddFriendInvite:{
                [self.layer setBorderColor:[[UIColor whiteColor] CGColor]];
                [self.layer setBorderWidth:1.0];
                [self.layer setCornerRadius:6.0];
                [self setClipsToBounds:YES];
                [self setBackgroundColor:[UIColor colorWithRed:0.965 green:0.714 blue:0.318 alpha:1.0]];
                [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W6" size:15.0f];
                [self setFont:font];
                [self setText: @"招待する"];
                break;
            }
            case AddFriendInCreateGroup:{
                [self.layer setBorderColor:[[UIColor alloc]initWithRed:0.459 green:0.827 blue:0.333 alpha:1.0].CGColor];
                [self.layer setBorderWidth:1.0];
                [self.layer setCornerRadius:6.0];
                [self setClipsToBounds:YES];
                [self setBackgroundColor: [UIColor whiteColor]];
                break;
            }
            case Plus:{
                [self.layer setBorderColor:[UIColor whiteColor].CGColor];
                [self.layer setBorderWidth:1.0];
                [self.layer setCornerRadius:6.0];
                [self setClipsToBounds:YES];
                [self setBackgroundColor: [UIColor blackColor]];
                [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W6" size:15.0f];
                [self setFont:font];
                if((int)iOSVersion == 6){
                    [self setTitleEdgeInsets:UIEdgeInsetsMake(6, 0, 0, 0)];
                }
                [self setTitle:@"+" forState:UIControlStateNormal];
                break;
            }
            default:
                break;
        }
    }
    return self;
}

- (void)setTitleInButton:(NSString *)title {
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W6" size:15.0f];
    [self setFont:font];
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setName:(NSString *)nameString {
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W3" size:11.0f];
    [self setFont:font];
    [self setTitle:nameString forState:UIControlStateNormal];
}

@end
