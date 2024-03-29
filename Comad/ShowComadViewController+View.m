//
//  ShowComadViewController+View.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/13.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "ShowComadViewController.h"
#import "ConversationTextBox.h"
#import "Conversation.h"
#import "BasicLabel.h"
#import "Image.h"
#import <QuartzCore/QuartzCore.h>
#import "Configuration.h"

@implementation ShowComadViewController (View)
- (void)configure {
    //UIView *baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 48, windowSize.size.width, windowSize.size.height - 48)];
    UIScrollView *baseView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 48, windowSize.size.width, windowSize.size.height - 123)];
    if((int)iOSVersion == 7){
        baseView.frame = CGRectMake(0, 77, windowSize.size.width, windowSize.size.height - 132);
    }
    baseView.contentSize = CGSizeMake(windowSize.size.width, windowSize.size.height);
    baseView.backgroundColor = [UIColor colorWithRed:0.902 green:0.890 blue:0.875 alpha:1.0];
    baseView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scrollViewTapped:)];
    [baseView addGestureRecognizer: tapGesture];
    
    UIView *cellView = [[UIView alloc]initWithFrame:CGRectMake(10, 15, windowSize.size.width - 20, 93)];
    cellView.backgroundColor = [UIColor whiteColor];
    cellView.layer.cornerRadius = 5;
    cellView.clipsToBounds = true;
    
    NSString *imageUrl = [NSString stringWithFormat:@"%@/images/profile/%@",HOST_URL, [self.comadInfo objectForKey:@"image_name"]];
    UIImage *thumbnailImage = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString: imageUrl]]];
    UIImage *cornerThumbnail = [Image makeCornerRoundImage:thumbnailImage];
    UIImageView *thumbnail = [[UIImageView alloc]initWithImage:cornerThumbnail];
    thumbnail.frame = CGRectMake(4.5, 4.5, 62, 62);
    thumbnail.layer.cornerRadius = 14.0f;
    
    [cellView addSubview:thumbnail];
    
    BasicLabel *name = [[BasicLabel alloc]initWithName:BlueTitle];
    name.text = [self.comadInfo objectForKey:@"name"];
    [name sizeToFit];
    name.frame = CGRectMake(77, 11, name.frame.size.width, name.frame.size.height);
    BasicLabel *comadId = [[BasicLabel alloc]initWithName:ComadId];
    comadId.text = [self.comadInfo objectForKey:@"comad_id"];
    [comadId sizeToFit];
    comadId.frame = CGRectMake(name.frame.origin.x + name.frame.size.width + 5, name.frame.origin.y + 1, comadId.frame.size.width, comadId.frame.size.height);
    
    //タイトル
    BasicLabel *title = [[BasicLabel alloc]initWithName:ComadCellTitle];
    title.numberOfLines = 2;
    if([[self.comadInfo objectForKey:@"title"] isEqualToString:@""]){
        title.text = @"タイトルなし";
    }else{
        title.text = [self.comadInfo objectForKey:@"title"];
    }
    title.frame = CGRectMake(77, name.frame.origin.y + name.frame.size.height + 3, 180, 0);
    [title sizeToFit];
    
    //時間
    UIImage *datetimeIcon = [UIImage imageNamed:@"datetimeIcon.png"];
    UIImageView *datetimeIconView = [[UIImageView alloc]initWithImage: datetimeIcon];
    datetimeIconView.frame = CGRectMake(77, title.frame.origin.y + title.frame.size.height + 3, 17.5, 17.5);
    BasicLabel *dateTime = [[BasicLabel alloc]initWithName:ShowUserComadId];
    if([[self.comadInfo objectForKey:@"date_time"] isEqual:[NSNull null]]){
        dateTime.text = @"未定";
    }else{
        NSString *dateTimeString = [[self.comadInfo objectForKey:@"date_time"] stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        dateTime.text = [dateTimeString substringToIndex:([dateTimeString length] - 8)];
    }
    
    //dateTime.text = @"未定";
    [dateTime sizeToFit];
    dateTime.frame = CGRectMake(93, title.frame.origin.y + title.frame.size.height + 5, dateTime.frame.size.width, dateTime.frame.size.height);
    
    //場所
    UIImage *locationIcon = [UIImage imageNamed:@"locationIcon.png"];
    UIImageView *locationIconView = [[UIImageView alloc]initWithImage: locationIcon];
    locationIconView.frame = CGRectMake(77, dateTime.frame.origin.y + dateTime.frame.size.height + 3, 14.5, 19);
    BasicLabel *location = [[BasicLabel alloc]initWithName:ShowUserComadId];
    if([[self.comadInfo objectForKey:@"location"] isEqualToString:@""]){
        location.text = @"未定";
    }else{
        location.text = [self.comadInfo objectForKey:@"location"];
    }
    [location sizeToFit];
    location.frame = CGRectMake(93, dateTime.frame.origin.y + dateTime.frame.size.height + 5, location.frame.size.width, location.frame.size.height);
    
    //右上の時間
    NSString *createdTime = [self.comadInfo objectForKey:@"created_at"];
    NSString *createdTimeReplace = [createdTime substringToIndex:([createdTime length] - 8)];
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm"];
    NSDate *createdAt = [inputFormatter dateFromString:createdTimeReplace];
    
    //現在時間
    NSDate* now = [NSDate date];
    
    float tmp = [now timeIntervalSinceDate: createdAt];
    int hh = (int)(tmp / 3600);
    int mm = (int)((tmp-hh) / 60);
    
    BasicLabel *time = [[BasicLabel alloc]initWithName:GrayLabel];
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
    
    //iOS6対応
    if((int)iOSVersion == 6){
        title.frame = CGRectMake(77, name.frame.origin.y + name.frame.size.height - 2, title.frame.size.width, title.frame.size.height);
        datetimeIconView.frame = CGRectMake(75, 48, 17.5, 17.5);
        dateTime.frame = CGRectMake(93, 50, dateTime.frame.size.width, dateTime.frame.size.height);
        locationIconView.frame = CGRectMake(76, 66, 14.5, 19);
        location.frame = CGRectMake(93, 68, location.frame.size.width, location.frame.size.height);
    }else if((int)iOSVersion == 7){
        title.frame = CGRectMake(77, name.frame.origin.y + name.frame.size.height - 2, title.frame.size.width, title.frame.size.height);
        datetimeIconView.frame = CGRectMake(75, 53, 17.5, 17.5);
        dateTime.frame = CGRectMake(93, 55, dateTime.frame.size.width, dateTime.frame.size.height);
        locationIconView.frame = CGRectMake(76, 71, 14.5, 19);
        location.frame = CGRectMake(93, 73, location.frame.size.width, location.frame.size.height);
    }
    
    [cellView addSubview: name];
    [cellView addSubview: comadId];
    [cellView addSubview: title];
    [cellView addSubview: dateTime];
    [cellView addSubview: datetimeIconView];
    [cellView addSubview: location];
    [cellView addSubview: locationIconView];
    [cellView addSubview: time];
    
    [baseView addSubview: cellView];
    
    //リボン
    NSString *ribbonImageName = @"";
    if([[self.comadInfo objectForKey:@"tense"] isEqualToString:@"なう"]){
        ribbonImageName = @"nowRibbon.png";
    }else if ([[self.comadInfo objectForKey:@"tense"] isEqualToString:@"今日"]){
        ribbonImageName = @"todayRibbon.png";
    }else if([[self.comadInfo objectForKey:@"tense"] isEqualToString:@"明日"]){
        ribbonImageName = @"tommorowRibbon.png";
    }else if([[self.comadInfo objectForKey:@"tense"] isEqualToString:@"明日以降"]){
        ribbonImageName = @"futureRibbon.png";
    }else if([[self.comadInfo objectForKey:@"tense"] isEqualToString:@"いつでも"]){
        ribbonImageName = @"wheneverRibbon.png";
    }else {
        ribbonImageName = @"futureRibbon.png";
    }
    UIImage *ribbon = [UIImage imageNamed: ribbonImageName];
    UIImageView *ribbonView = [[UIImageView alloc]initWithImage:ribbon];
    ribbonView.frame = CGRectMake(8, 12, 70.5, 41);
    [baseView addSubview: ribbonView];
    /*
    scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(0, 78, windowSize.size.width, windowSize.size.height - 132);
    scrollView.contentSize = CGSizeMake(windowSize.size.width, 608);
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: scrollView];
    */
    UIView *innerTitleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, windowSize.size.width, 31)];
    UIView *outerTitleView = [[UIView alloc]initWithFrame:CGRectMake(0, cellView.frame.origin.y + cellView.frame.size.height + 10, windowSize.size.width, 32)];
    innerTitleView.backgroundColor = [UIColor colorWithRed:0.600 green:0.592 blue:0.580 alpha:1.0];
    outerTitleView.backgroundColor = [UIColor colorWithRed:0.761 green:0.757 blue:0.749 alpha:1.0];
    [outerTitleView addSubview:innerTitleView];
    [baseView addSubview:outerTitleView];
    
    BasicLabel *titleLabel = [[BasicLabel alloc]initWithName: AddFriendMenuLabel];
    titleLabel.text = @"会話";
    [titleLabel sizeToFit];
    titleLabel.backgroundColor = [UIColor colorWithRed:0.600 green:0.592 blue:0.580 alpha:1.0];
    titleLabel.frame = CGRectMake(10, 11, titleLabel.frame.size.width, titleLabel.frame.size.height);
    [innerTitleView addSubview: titleLabel];
    
    conversation = [[Conversation alloc]init];
    [conversation setNoConversation];
    conversation.frame = CGRectMake(0, outerTitleView.frame.origin.y + outerTitleView.frame.size.height, windowSize.size.width, windowSize.size.height - 135);
    conversation.backgroundColor = [UIColor whiteColor];
    [baseView addSubview:conversation];
    
    textBox = [[ConversationTextBox alloc]init];
    if((int)iOSVersion == 6){
        textBox.frame = CGRectMake(0, 405, windowSize.size.width, 55);
    }else if((int)iOSVersion == 7){
        //textBox.frame = CGRectMake(0, windowSize.size.height, windowSize.size.width, 55);
    }
    textBox.delegate = self;
    [self.view addSubview: baseView];
    [self.view addSubview: textBox];
}

#pragma ConversationTextBoxDelegate methods
//sendButton
- (void)sendClicked:(NSString *)text {
    if(![text isEqualToString:@""]){
        NSString *imageName = [[Configuration user] objectForKey:@"image_name"];
        NSString *userName = [[Configuration user] objectForKey:@"name"];
        NSString *userId = [[Configuration user] objectForKey:@"id"];
        
        [socketIO sendEvent:@"message" withData:@{@"message": text, @"userId": userId, @"type": @"comad",  @"imageName": imageName, @"userName": userName, @"comadId": [self.comadInfo objectForKey:@"id"]}];
    }
}

//stamp出現
-(void)plusClicked {
    mask = [[BlackMask alloc]init];
    mask.delegate = self;
    mask.alpha = 0.4;
    //スタンプのビューをmaskの上に付ける。
    sm = [[SpecialMoji alloc]init];
    sm.delegate = self;
    
    [self.view addSubview: mask];
    [self.view addSubview: sm];
}

- (void)stampClickedDelegate:(int)stampNum {
    [mask removeFromSuperview];
    [sm removeFromSuperview];
    NSString *stampName = [NSString stringWithFormat:@"(stamp_%i)", stampNum];
    NSString *imageName = [[Configuration user] objectForKey:@"image_name"];
    NSString *userName = [[Configuration user] objectForKey:@"name"];
    NSString *userId = [[Configuration user] objectForKey:@"id"];
    
    [socketIO sendEvent:@"message" withData:@{@"message": stampName, @"userId": userId, @"type": @"comad",  @"imageName": imageName, @"userName": userName, @"comadId": [self.comadInfo objectForKey:@"id"]}];
}

- (void)blackMaskTapped {
    [mask removeFromSuperview];
    [sm removeFromSuperview];
}

- (void)scrollViewTapped:(id)sender {
    [textBox removeKeyBoard];
}

@end
