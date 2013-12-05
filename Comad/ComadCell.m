//
//  ComadCell.m
//  Comad
//
//  Created by 浅野 友希 on 2013/10/17.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ComadCell.h"
#import "Image.h"
#import "Date.h"
#import "BasicLabel.h"

@implementation ComadCell

@synthesize comadInfo;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        windowSize = [[UIScreen mainScreen] bounds];
        self.backgroundColor = [UIColor colorWithRed:0.902 green:0.890 blue:0.875 alpha:1.0];
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
    
    UIView *cellView = [[UIView alloc]initWithFrame:CGRectMake(10, 5, windowSize.size.width - 20, 93)];
    cellView.backgroundColor = [UIColor whiteColor];
    cellView.layer.cornerRadius = 5;
    cellView.clipsToBounds = true;
    
    UIImage *thumbnailImage = [UIImage imageNamed:[comadInfo objectForKey:@"imageName"]];
    UIImage *cornerThumbnail = [Image makeCornerRoundImage:thumbnailImage];
    UIImageView *thumbnail = [[UIImageView alloc]initWithImage:cornerThumbnail];
    thumbnail.frame = CGRectMake(4.5, 4.5, 62, 62);
    thumbnail.layer.cornerRadius = 14.0f;
    
    [cellView addSubview:thumbnail];

    BasicLabel *name = [[BasicLabel alloc]initWithName:BlueTitle];
    name.text = [comadInfo objectForKey:@"name"];
    [name sizeToFit];
    name.frame = CGRectMake(77, 11, name.frame.size.width, name.frame.size.height);
    BasicLabel *comadId = [[BasicLabel alloc]initWithName:ComadId];
    comadId.text = [comadInfo objectForKey:@"comadId"];
    [comadId sizeToFit];
    comadId.frame = CGRectMake(name.frame.origin.x + name.frame.size.width + 5, name.frame.origin.y + 1, comadId.frame.size.width, comadId.frame.size.height);
    BasicLabel *title = [[BasicLabel alloc]initWithName:ComadCellTitle];
    if([[comadInfo objectForKey:@"title"] isEqualToString:@""]){
        title.text = @"タイトルなし";
    }else{
        title.text = [comadInfo objectForKey:@"title"];
    }
    [title sizeToFit];
    title.frame = CGRectMake(77, name.frame.origin.y + name.frame.size.height + 3, title.frame.size.width, title.frame.size.height);
    
    //時間
    UIImage *datetimeIcon = [UIImage imageNamed:@"datetimeIcon.png"];
    UIImageView *datetimeIconView = [[UIImageView alloc]initWithImage: datetimeIcon];
    datetimeIconView.frame = CGRectMake(77, title.frame.origin.y + title.frame.size.height + 3, 17.5, 17.5);
    BasicLabel *dateTime = [[BasicLabel alloc]initWithName:ShowUserComadId];
    if([[comadInfo objectForKey:@"dateTime"] isEqualToString:@""]){
        dateTime.text = @"未定";
    }else{
        dateTime.text = [comadInfo objectForKey:@"dateTime"];
    }
    [dateTime sizeToFit];
    dateTime.frame = CGRectMake(93, title.frame.origin.y + title.frame.size.height + 5, dateTime.frame.size.width, dateTime.frame.size.height);
    
    //場所
    UIImage *locationIcon = [UIImage imageNamed:@"locationIcon.png"];
    UIImageView *locationIconView = [[UIImageView alloc]initWithImage: locationIcon];
    locationIconView.frame = CGRectMake(77, dateTime.frame.origin.y + dateTime.frame.size.height + 3, 14.5, 19);
    BasicLabel *location = [[BasicLabel alloc]initWithName:ShowUserComadId];
    location.text = [comadInfo objectForKey:@"location"];
    [location sizeToFit];
    location.frame = CGRectMake(93, dateTime.frame.origin.y + dateTime.frame.size.height + 5, location.frame.size.width, location.frame.size.height);
    
    //右上の時間
    NSString *createdTime = [comadInfo objectForKey:@"created_at"];
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *createdAt = [inputFormatter dateFromString:createdTime];
    
    //現在時間
    NSDate* now = [NSDate date];

    float tmp = [now timeIntervalSinceDate: createdAt];
    int hh = (int)(tmp / 3600);
    int mm = (int)((tmp-hh) / 60);
    float ss = tmp -(float)(hh*3600+mm*60);
    
    BasicLabel *time = [[BasicLabel alloc]initWithName:GrayLabel];
    NSLog(@"%02d:%02d:%05.2f",hh,mm,ss);
    // 1日を超えてる場合
    if(hh >= 24){
        int days = hh/24;
        time.text = [NSString stringWithFormat:@"%d日前",days];
    // 24時間以下の場合
    }else{
        if(hh > 0){
            time.text = [NSString stringWithFormat:@"%d時間前", hh];
        }else{
            time.text = [NSString stringWithFormat:@"%d分前", mm];
        }
    }
    
    time.textColor = [UIColor colorWithRed:0.580 green:0.588 blue:0.600 alpha:1.0];
    [time sizeToFit];
    time.frame = CGRectMake(cellView.frame.size.width - time.frame.size.width - 5, 11, time.frame.size.width, time.frame.size.height);
    
    //会話人数
    BasicLabel *conversationNum = [[BasicLabel alloc]initWithName:ComadId];
    conversationNum.text = [NSString stringWithFormat:@"%d人が会話中",[[comadInfo objectForKey:@"people"] intValue]];
    
    //ピンク
    if([[comadInfo objectForKey:@"tense"] isEqualToString:@"なう"]){
        conversationNum.textColor = [UIColor colorWithRed:0.937 green:0.322 blue:0.510 alpha:1.0];
    //黄色
    }else if ([[comadInfo objectForKey:@"tense"] isEqualToString:@"今日"]){
        conversationNum.textColor = [UIColor colorWithRed:1.000 green:0.729 blue:0.302 alpha:1.0];
    //緑
    }else if([[comadInfo objectForKey:@"tense"] isEqualToString:@"うぃる"]){
        conversationNum.textColor = [UIColor colorWithRed:0.329 green:0.773 blue:0.706 alpha:1.0];
    //青
    }else if([[comadInfo objectForKey:@"tense"] isEqualToString:@"明日以降"]){
        conversationNum.textColor = [UIColor colorWithRed:0.329 green:0.773 blue:0.706 alpha:1.0];
    //紫
    }else if([[comadInfo objectForKey:@"tense"] isEqualToString:@"いつでも"]){
        conversationNum.textColor = [UIColor colorWithRed:0.471 green:0.349 blue:0.690 alpha:1.0];
    }
    
    [conversationNum sizeToFit];
    conversationNum.frame = CGRectMake(cellView.frame.size.width - conversationNum.frame.size.width - 5, title.frame.origin.y + title.frame.size.height + 5, conversationNum.frame.size.width, conversationNum.frame.size.height);
    
    //コメント数
    BasicLabel *commentNum = [[BasicLabel alloc]initWithName:ShowUserComadId];
    commentNum.text = [NSString stringWithFormat:@"%d件",[[comadInfo objectForKey:@"comments"] intValue]];
    [commentNum sizeToFit];
    commentNum.frame = CGRectMake(cellView.frame.size.width - commentNum.frame.size.width - 5, dateTime.frame.origin.y + dateTime.frame.size.height + 5, commentNum.frame.size.width, commentNum.frame.size.height);
    
    NSString *commentIconImageName = @"";
    //ピンク
    if([[comadInfo objectForKey:@"tense"] isEqualToString:@"なう"]){
        commentIconImageName = @"commentIconPinc.png";
        //黄色
    }else if ([[comadInfo objectForKey:@"tense"] isEqualToString:@"今日"]){
        commentIconImageName = @"commentIconOrange.png";
        //緑
    }else if([[comadInfo objectForKey:@"tense"] isEqualToString:@"うぃる"]){
        commentIconImageName = @"commentIconGreen.png";
        //青
    }else if([[comadInfo objectForKey:@"tense"] isEqualToString:@"明日以降"]){
        commentIconImageName = @"commentIconBlue.png";
        //紫
    }else if([[comadInfo objectForKey:@"tense"] isEqualToString:@"いつでも"]){
        commentIconImageName = @"commentIconPurple.png";
    }
    UIImage *commentIcon = [UIImage imageNamed: commentIconImageName];
    UIImageView *commentIconView = [[UIImageView alloc]initWithImage: commentIcon];
    commentIconView.frame = CGRectMake(commentNum.frame.origin.x - 15, dateTime.frame.origin.y + dateTime.frame.size.height + 5, 13.5, 11.5);

    //iOS6対応
    if((int)iOSVersion == 6){
        NSLog(@"hogeeeeeeeeee %f", title.frame.origin.y + title.frame.size.height + 1);
        title.frame = CGRectMake(77, name.frame.origin.y + name.frame.size.height - 2, title.frame.size.width, title.frame.size.height);
        datetimeIconView.frame = CGRectMake(75, 48, 17.5, 17.5);
        dateTime.frame = CGRectMake(93, 50, dateTime.frame.size.width, dateTime.frame.size.height);
        locationIconView.frame = CGRectMake(76, 66, 14.5, 19);
        location.frame = CGRectMake(93, 68, location.frame.size.width, location.frame.size.height);
        conversationNum.frame = CGRectMake(cellView.frame.size.width - conversationNum.frame.size.width - 5, dateTime.frame.origin.y, conversationNum.frame.size.width, conversationNum.frame.size.height);
        commentNum.frame = CGRectMake(cellView.frame.size.width - commentNum.frame.size.width - 5, location.frame.origin.y, commentNum.frame.size.width, commentNum.frame.size.height);
        commentIconView.frame = CGRectMake(commentNum.frame.origin.x - 16, location.frame.origin.y, 13.5, 11.5);
    }
    
    [cellView addSubview: name];
    [cellView addSubview: comadId];
    [cellView addSubview: title];
    [cellView addSubview: dateTime];
    [cellView addSubview: datetimeIconView];
    [cellView addSubview: location];
    [cellView addSubview: locationIconView];
    [cellView addSubview: time];
    [cellView addSubview: conversationNum];
    [cellView addSubview: commentNum];
    [cellView addSubview: commentIconView];
    
    [self addSubview: cellView];
    
    //リボン
    NSString *ribbonImageName = @"";
    if([[comadInfo objectForKey:@"tense"] isEqualToString:@"なう"]){
        ribbonImageName = @"nowRibbon.png";
    }else if ([[comadInfo objectForKey:@"tense"] isEqualToString:@"今日"]){
        ribbonImageName = @"todayRibbon.png";
    }else if([[comadInfo objectForKey:@"tense"] isEqualToString:@"うぃる"]){
        ribbonImageName = @"tommorowRibbon.png";
    }else if([[comadInfo objectForKey:@"tense"] isEqualToString:@"明日以降"]){
        ribbonImageName = @"futureRibbon.png";
    }else if([[comadInfo objectForKey:@"tense"] isEqualToString:@"いつでも"]){
        ribbonImageName = @"wheneverRibbon.png";
    }else {
        ribbonImageName = @"futureRibbon.png";
    }
    UIImage *ribbon = [UIImage imageNamed: ribbonImageName];
    UIImageView *ribbonView = [[UIImageView alloc]initWithImage:ribbon];
    ribbonView.frame = CGRectMake(8, 2, 70.5, 41);
    [self addSubview: ribbonView];
}

@end
