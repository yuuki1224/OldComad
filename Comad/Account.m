//
//  Account.m
//  Comad
//
//  Created by 浅野 友希 on 2013/10/16.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "Account.h"
#import "Image.h"
#import <QuartzCore/QuartzCore.h>

@implementation Account
@synthesize userInfo;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGRect windowSize = [[UIScreen mainScreen] bounds];
        self.frame = CGRectMake(0, 78, windowSize.size.width, 200);
        self.backgroundColor = [UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1.000];
        //[image drawInRect:CGRectMake(10, 10, 50, 50)];
    }
    return self;
}

- (void)setLabel {
    
    CGRect windowSize = [[UIScreen mainScreen] bounds];
    
    UILabel *nameLabel = [[UILabel alloc]init];
    UILabel *userIdLabel = [[UILabel alloc]init];
    UILabel *occupationLabel = [[UILabel alloc]init];
    
    nameLabel.textColor = [UIColor blackColor];
    userIdLabel.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
    occupationLabel.textColor = [UIColor colorWithRed:0.133 green:0.384 blue:0.561 alpha:1.0];
    
    UIFont *fontName = [UIFont fontWithName:@"HiraKakuProN-W6" size:18.0f];
    UIFont *fontComadId = [UIFont fontWithName:@"HiraKakuProN-W3" size:12.0f];
    UIFont *fontOccupation = [UIFont fontWithName:@"HiraKakuProN-W3" size:12.0f];
    
    nameLabel.font = fontName;
    userIdLabel.font = fontComadId;
    occupationLabel.font = fontOccupation;
    
    nameLabel.text = @"浅野 友希";
    userIdLabel.text = @"yuuki1224";
    occupationLabel.text = @"エンジニア";
    
    [nameLabel sizeToFit];
    [userIdLabel sizeToFit];
    [occupationLabel sizeToFit];
    
    float nameWidth = nameLabel.frame.size.width;
    float nameHeight = nameLabel.frame.size.height;
    float userIdWidth = userIdLabel.frame.size.width;
    float userIdHeight = userIdLabel.frame.size.height;
    float occupationWidth = occupationLabel.frame.size.width;
    float occupationHeight = occupationLabel.frame.size.height;
    
    nameLabel.frame = CGRectMake(windowSize.size.width/2 - nameWidth/2, 115, nameWidth, nameHeight);
    userIdLabel.frame = CGRectMake(windowSize.size.width/2 - userIdWidth/2, 140, userIdWidth, userIdHeight);
    occupationLabel.frame = CGRectMake(windowSize.size.width/2 - occupationWidth/2, 160, occupationWidth, occupationHeight);
    
    [self addSubview: nameLabel];
    [self addSubview: userIdLabel];
    [self addSubview:occupationLabel];
    
    UIImage *thumbnailImage = [UIImage imageNamed:@"asano.png"];
    UIImage *thumbnailImageResize = [Image resizeImage:thumbnailImage resizeWidth:78 resizeHeight:78];
    UIImage *cornerThumbnail = [Image makeCornerRoundImage:thumbnailImageResize];
    UIImageView *thumbnail = [[UIImageView alloc]initWithImage:cornerThumbnail];
    thumbnail.frame = CGRectMake(windowSize.size.width/2 - 39, 16, 78, 78);
    thumbnail.layer.cornerRadius = 14.0f;
    
    [self addSubview:thumbnail];
}

@end
