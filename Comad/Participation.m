//
//  Participation.m
//  Comad
//
//  Created by 浅野 友希 on 2013/10/25.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "Participation.h"
#import "Image.h"
#import "ComadJsonClient.h"
#import "BasicLabel.h"

@implementation Participation
@synthesize attendPersonNum, comadInfo;

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
        
        UIButton *attendComadBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        attendComadBtn.backgroundColor = [UIColor colorWithRed:0.875 green:0.647 blue:0.333 alpha:1.0];
        [attendComadBtn setTintColor:[UIColor whiteColor]];
        [attendComadBtn setFont:[UIFont fontWithName:@"HiraKakuProN-W3" size:12.0f]];
        [attendComadBtn setTitle:@"参加する" forState:UIControlStateNormal];
        attendComadBtn.frame = CGRectMake(windowSize.size.width - 63, 0, 63, 30);
        [attendComadBtn addTarget:self action:@selector(attend:) forControlEvents:UIControlEventTouchUpInside];
        //[btn setImage:buttonImage forState:UIControlStateNormal];
        [content addSubview:attendComadBtn];
        
        attendPersonNum = 0;
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    BasicLabel *titleLabel = [[BasicLabel alloc]initWithName:ShowComadParticipationTitle];
    titleLabel.text = title;
    [titleLabel sizeToFit];
    titleLabel.frame = CGRectMake(10, 11, titleLabel.frame.size.width, titleLabel.frame.size.height);
    [content addSubview: titleLabel];
}

- (void)setContent:(NSString *)content {
    
}

- (void)attend:(UIButton *)button {
    [[ComadJsonClient sharedClient] attendComad:@"1" :[comadInfo objectForKey:@"id"] :^(AFHTTPRequestOperation *operation, NSHTTPURLResponse *response, id responseObject) {
        UIImage *attendPersonImage = [UIImage imageNamed:@"asano.png"];
        UIImage *attendPersonImageResize = [Image resizeImage:attendPersonImage resizeWidth:50 resizeHeight:50];
        UIImage *cornerAttendPersonImage = [Image makeCornerRoundImage:attendPersonImageResize];
        UIImageView *attendPerson = [[UIImageView alloc]initWithImage:cornerAttendPersonImage];
        int setImageWidth = (int)attendPersonNum * 60 + 10;
        attendPerson.frame = CGRectMake(setImageWidth, 37, 50, 50);
        [self addSubview:attendPerson];
        attendPersonNum++;
        attendPerson.alpha = 0.2f;
        [UIView animateWithDuration:0.5f
                         animations:^{
                             attendPerson.alpha = 1.0f;
                         }];
    } failure:^(int statusCode, NSString *errorString) {
    }];
}

@end
