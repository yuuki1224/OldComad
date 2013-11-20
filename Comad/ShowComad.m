//
//  ShowComad.m
//  Comad
//
//  Created by 浅野 友希 on 2013/10/24.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "ShowComad.h"
#import "Image.h"
#import "Participation.h"
#import "Conversation.h"
#import "Date.h"

@implementation ShowComad
@synthesize comadInfo;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGRect windowSize = [[UIScreen mainScreen] bounds];
        self.frame = CGRectMake(0, 0, windowSize.size.width, windowSize.size.height - 132);
        participationView = [[Participation alloc]initWithFrame:CGRectMake(0, 88, windowSize.size.width, 82)];
        
        [self addSubview: participationView];
        [participationView setTitle:@"参加予定"];
        
    }
    return self;
}

- (void)setLabel {
    participationView.comadInfo = self.comadInfo;
    UILabel *nameLabel = [[UILabel alloc]init];
    UILabel *timeLabel = [[UILabel alloc]init];
    UILabel *locationLabel = [[UILabel alloc]init];
    UILabel *attendLabel = [[UILabel alloc]init];
    
    nameLabel.textColor = [UIColor colorWithRed:0.282 green:0.549 blue:0.898 alpha:1.0];
    timeLabel.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
    locationLabel.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
    attendLabel.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
    
    UIFont *fontLarge = [UIFont fontWithName:@"HiraKakuProN-W6" size:13.0f];
    UIFont *fontSmall = [UIFont fontWithName:@"HiraKakuProN-W3" size:12.0f];
    
    nameLabel.font = fontLarge;
    timeLabel.font = fontSmall;
    locationLabel.font = fontSmall;
    attendLabel.font = fontSmall;
    
    NSDate *startTime = [Date modifyDateString: [self.comadInfo objectForKey:@"start_time"]];
    NSDate *endTime = [Date modifyDateString: [self.comadInfo objectForKey:@"end_time"]];
    NSString *rangeTime = [Date timeRangeStringFromDate:startTime end_time:endTime];
    nameLabel.text = [self.comadInfo objectForKey:@"name"];
    timeLabel.text = rangeTime;
    locationLabel.text = [self.comadInfo objectForKey:@"location"];
    attendLabel.text = @"中川峰志さん他3名";
    
    [nameLabel sizeToFit];
    [timeLabel sizeToFit];
    [locationLabel sizeToFit];
    [attendLabel sizeToFit];
    
    float nameWidth = nameLabel.frame.size.width;
    float nameHeight = nameLabel.frame.size.height;
    float timeWidth = timeLabel.frame.size.width;
    float timeHeight = timeLabel.frame.size.height;
    float locationWidth = locationLabel.frame.size.width;
    float locationHeight = locationLabel.frame.size.height;
    float attendWidth = attendLabel.frame.size.width;
    float attendHeight = attendLabel.frame.size.height;
    
    nameLabel.frame = CGRectMake(82, 10, nameWidth, nameHeight);
    timeLabel.frame = CGRectMake(82, 35, timeWidth, timeHeight);
    locationLabel.frame = CGRectMake(82, 55, locationWidth, locationHeight);
    attendLabel.frame = CGRectMake(locationLabel.frame.origin.x + locationWidth + 10, 55, attendWidth, attendHeight);
    
    [self addSubview: nameLabel];
    [self addSubview: timeLabel];
    [self addSubview: locationLabel];
    [self addSubview: attendLabel];
    
    UIImage *thumbnailImage = [UIImage imageNamed:[self.comadInfo objectForKey:@"image_name"]];
    UIImage *thumbnailImageResize = [Image resizeImage:thumbnailImage resizeWidth:61 resizeHeight:61];
    UIImage *cornerThumbnail = [Image makeCornerRoundImage:thumbnailImageResize];
    UIImageView *thumbnail = [[UIImageView alloc]initWithImage:cornerThumbnail];
    thumbnail.frame = CGRectMake(8, 10, 61, 61);
    thumbnail.layer.cornerRadius = 14.0f;
    
    [self addSubview:thumbnail];
    
}

@end
