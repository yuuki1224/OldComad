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
    
    UIImage *thumbnailImage = [UIImage imageNamed:@"adachi.png"];
    UIImage *thumbnailImageResize = [Image resizeImage:thumbnailImage resizeWidth:62 resizeHeight:62];
    UIImage *cornerThumbnail = [Image makeCornerRoundImage:thumbnailImageResize];
    UIImageView *thumbnail = [[UIImageView alloc]initWithImage:cornerThumbnail];
    thumbnail.frame = CGRectMake(4.5, 4.5, 62, 62);
    thumbnail.layer.cornerRadius = 14.0f;
    
    [cellView addSubview:thumbnail];

    BasicLabel *name = [[BasicLabel alloc]initWithName:BlueTitle];
    name.text = @"足立壮大";
    [name sizeToFit];
    name.frame = CGRectMake(77, 11, name.frame.size.width, name.frame.size.height);
    BasicLabel *comadId = [[BasicLabel alloc]initWithName:ComadId];
    comadId.text = @"@tkhr";
    [comadId sizeToFit];
    comadId.frame = CGRectMake(name.frame.origin.x + name.frame.size.width + 5, name.frame.origin.y + 1, comadId.frame.size.width, comadId.frame.size.height);
    BasicLabel *title = [[BasicLabel alloc]initWithName:ComadCellTitle];
    title.text = @"スタバでノマドしようぜ!";
    [title sizeToFit];
    title.frame = CGRectMake(77, name.frame.origin.y + name.frame.size.height + 3, title.frame.size.width, title.frame.size.height);
    
    //時間
    UIImage *datetimeIcon = [UIImage imageNamed:@"datetimeIcon.png"];
    UIImage *datetimeIconResize = [Image resizeImage: datetimeIcon resizePer:0.5];
    UIImageView *datetimeIconView = [[UIImageView alloc]initWithImage: datetimeIconResize];
    datetimeIconView.frame = CGRectMake(77, title.frame.origin.y + title.frame.size.height + 3, datetimeIconResize.size.width, datetimeIconResize.size.height);
    BasicLabel *dateTime = [[BasicLabel alloc]initWithName:ShowUserComadId];
    dateTime.text = @"11月13日(水)18:00";
    [dateTime sizeToFit];
    dateTime.frame = CGRectMake(93, title.frame.origin.y + title.frame.size.height + 5, dateTime.frame.size.width, dateTime.frame.size.height);
    
    //場所
    UIImage *locationIcon = [UIImage imageNamed:@"locationIcon.png"];
    UIImage *locationIconResize = [Image resizeImage:locationIcon resizePer:0.5];
    UIImageView *locationIconView = [[UIImageView alloc]initWithImage: locationIconResize];
    locationIconView.frame = CGRectMake(77, dateTime.frame.origin.y + dateTime.frame.size.height + 3, locationIconResize.size.width, locationIconResize.size.height);
    BasicLabel *location = [[BasicLabel alloc]initWithName:ShowUserComadId];
    location.text = @"三条スターバックス";
    [location sizeToFit];
    location.frame = CGRectMake(93, dateTime.frame.origin.y + dateTime.frame.size.height + 5, location.frame.size.width, location.frame.size.height);
    
    //右上の時間
    BasicLabel *time = [[BasicLabel alloc]initWithName:GrayLabel];
    time.text = @"24分前";
    time.textColor = [UIColor colorWithRed:0.580 green:0.588 blue:0.600 alpha:1.0];
    [time sizeToFit];
    time.frame = CGRectMake(cellView.frame.size.width - time.frame.size.width - 5, 11, time.frame.size.width, time.frame.size.height);
    
    //会話人数
    BasicLabel *conversationNum = [[BasicLabel alloc]initWithName:ComadId];
    conversationNum.text = @"6人が会話中";
    conversationNum.textColor = [UIColor colorWithRed:0.937 green:0.322 blue:0.510 alpha:1.0];
    [conversationNum sizeToFit];
    conversationNum.frame = CGRectMake(cellView.frame.size.width - conversationNum.frame.size.width - 5, title.frame.origin.y + title.frame.size.height + 5, dateTime.frame.size.width, dateTime.frame.size.height);
    
    //コメント数
    BasicLabel *commentNum = [[BasicLabel alloc]initWithName:ShowUserComadId];
    commentNum.text = @"23件";
    [commentNum sizeToFit];
    commentNum.frame = CGRectMake(cellView.frame.size.width - commentNum.frame.size.width - 5, dateTime.frame.origin.y + dateTime.frame.size.height + 5, commentNum.frame.size.width, commentNum.frame.size.height);
    UIImage *commentIcon = [UIImage imageNamed:@"commentIconPinc.png"];
    UIImage *commentIconResize = [Image resizeImage:commentIcon resizePer:0.5];
    UIImageView *commentIconView = [[UIImageView alloc]initWithImage: commentIconResize];
    commentIconView.frame = CGRectMake(commentNum.frame.origin.x - 15, dateTime.frame.origin.y + dateTime.frame.size.height + 5, commentIconResize.size.width, commentIconResize.size.height);

    
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
    UIImage *ribbon = [UIImage imageNamed:@"nowRibbon.png"];
    UIImage *ribbonResize = [Image resizeImage:ribbon resizePer:0.5];
    UIImageView *ribbonView = [[UIImageView alloc]initWithImage:ribbonResize];
    ribbonView.frame = CGRectMake(8, 3, ribbonResize.size.width, ribbonResize.size.height);
    [self addSubview: ribbonView];
}

@end
