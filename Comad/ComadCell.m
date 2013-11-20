//
//  ComadCell.m
//  Comad
//
//  Created by 浅野 友希 on 2013/10/17.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "ComadCell.h"
#import "Image.h"
#import "Date.h"

@implementation ComadCell

@synthesize comadInfo, start_time, end_time;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setComadCell {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    UIImage *thumbnailImage = [UIImage imageNamed:[self.comadInfo objectForKey:@"image_name"]];
    UIImage *thumbnailImageResize = [Image resizeImage:thumbnailImage resizeWidth:64 resizeHeight:64];
    UIImage *cornerThumbnail = [Image makeCornerRoundImage:thumbnailImageResize];
    UIImageView *thumbnail = [[UIImageView alloc]initWithImage:cornerThumbnail];
    thumbnail.frame = CGRectMake(13, 13, 64, 64);
    thumbnail.layer.cornerRadius = 14.0f;
    
    [self addSubview:thumbnail];
    
    UILabel *nameText = [[UILabel alloc]init];
    UILabel *dateTime = [[UILabel alloc]init];
    UILabel *location = [[UILabel alloc]init];
    UILabel *attendFriend = [[UILabel alloc]init];
    
    nameText.textColor = [UIColor colorWithRed:0.282 green:0.549 blue:0.898 alpha:1.0];
    dateTime.textColor = [UIColor blackColor];
    location.textColor = [UIColor blackColor];
    attendFriend.textColor = [UIColor blackColor];
    
    UIFont *titleFont = [UIFont fontWithName:@"HiraKakuProN-W6" size:16.0f];
    UIFont *subTextFont = [UIFont fontWithName:@"HiraKakuProN-W3" size:12.0f];
    
    nameText.font = titleFont;
    nameText.text = [self.comadInfo objectForKey:@"name"];
    dateTime.font = subTextFont;
    
    self.start_time = [Date modifyDateString:[self.comadInfo objectForKey:@"start_time"]];
    self.end_time = [Date modifyDateString:[self.comadInfo objectForKey:@"end_time"]];
    
    NSString *timeRangeString = [Date timeRangeStringFromDate:self.start_time end_time:self.end_time];
    
    dateTime.text = timeRangeString;
    location.font = subTextFont;
    location.text = [self.comadInfo objectForKey:@"location"];
    attendFriend.font = subTextFont;
    attendFriend.text = @"中川峰志さん他3名";
    
    [nameText sizeToFit];
    float nameTextWidth = nameText.frame.size.width;
    float nameTextHeight = nameText.frame.size.height;
    nameText.frame = CGRectMake(90, 19, nameTextWidth, nameTextHeight);
    
    [dateTime sizeToFit];
    float dateTimeWidth = dateTime.frame.size.width;
    float dateTimeHeight = dateTime.frame.size.height;
    dateTime.frame = CGRectMake(90, nameText.frame.origin.y + nameTextHeight + 6, dateTimeWidth, dateTimeHeight);
    
    [location sizeToFit];
    float locationWidth = location.frame.size.width;
    float locationHeight = location.frame.size.height;
    location.frame = CGRectMake(90, dateTime.frame.origin.y + dateTimeHeight + 6, locationWidth, locationHeight);
    
    [attendFriend sizeToFit];
    float attendFriendWidth = attendFriend.frame.size.width;
    float attendFriendHeight = attendFriend.frame.size.height;
    attendFriend.frame = CGRectMake(location.frame.origin.x + locationWidth + 10, location.frame.origin.y, attendFriendWidth, attendFriendHeight);
    
    [self addSubview:nameText];
    [self addSubview:dateTime];
    [self addSubview:location];
    [self addSubview:attendFriend];
}

@end
