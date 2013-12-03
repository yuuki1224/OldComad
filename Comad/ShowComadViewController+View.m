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

@implementation ShowComadViewController (View)
- (void)configure {
    //UIView *baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 48, windowSize.size.width, windowSize.size.height - 48)];
    UIScrollView *baseView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 48, windowSize.size.width, windowSize.size.height - 123)];
    baseView.contentSize = CGSizeMake(windowSize.size.width, windowSize.size.height);
    baseView.backgroundColor = [UIColor colorWithRed:0.902 green:0.890 blue:0.875 alpha:1.0];
    
    UIView *cellView = [[UIView alloc]initWithFrame:CGRectMake(10, 15, windowSize.size.width - 20, 93)];
    cellView.backgroundColor = [UIColor whiteColor];
    cellView.layer.cornerRadius = 5;
    cellView.clipsToBounds = true;
    
    UIImage *thumbnailImage = [UIImage imageNamed:@"adachi.png"];
    UIImage *cornerThumbnail = [Image makeCornerRoundImage:thumbnailImage];
    UIImageView *thumbnail = [[UIImageView alloc]initWithImage:cornerThumbnail];
    thumbnail.frame = CGRectMake(4.5, 4.5, 62, 62);
    thumbnail.layer.cornerRadius = 14.0f;
    
    [cellView addSubview:thumbnail];
    
    BasicLabel *name = [[BasicLabel alloc]initWithName:BlueTitle];
    name.text = @"足立壮大";
    [name sizeToFit];
    name.frame = CGRectMake(77, 11, name.frame.size.width, name.frame.size.height);
    BasicLabel *comadId = [[BasicLabel alloc]initWithName:ComadId];
    comadId.text = @"tkhr";
    [comadId sizeToFit];
    comadId.frame = CGRectMake(name.frame.origin.x + name.frame.size.width + 5, name.frame.origin.y + 1, comadId.frame.size.width, comadId.frame.size.height);
    BasicLabel *title = [[BasicLabel alloc]initWithName:ComadCellTitle];
    title.text = @"熱海でノマドしませんかあああ？";
    [title sizeToFit];
    title.frame = CGRectMake(77, name.frame.origin.y + name.frame.size.height + 3, title.frame.size.width, title.frame.size.height);
    
    //時間
    UIImage *datetimeIcon = [UIImage imageNamed:@"datetimeIcon.png"];
    UIImageView *datetimeIconView = [[UIImageView alloc]initWithImage: datetimeIcon];
    datetimeIconView.frame = CGRectMake(77, title.frame.origin.y + title.frame.size.height + 3, 17.5, 17.5);
    BasicLabel *dateTime = [[BasicLabel alloc]initWithName:ShowUserComadId];
    /*
    if([[comadInfo objectForKey:@"dateTime"] isEqualToString:@""]){
        dateTime.text = @"未定";
    }else{
        dateTime.text = [comadInfo objectForKey:@"dateTime"];
    }
     */
    dateTime.text = @"未定";
    [dateTime sizeToFit];
    dateTime.frame = CGRectMake(93, title.frame.origin.y + title.frame.size.height + 5, dateTime.frame.size.width, dateTime.frame.size.height);
    
    //場所
    UIImage *locationIcon = [UIImage imageNamed:@"locationIcon.png"];
    UIImageView *locationIconView = [[UIImageView alloc]initWithImage: locationIcon];
    locationIconView.frame = CGRectMake(77, dateTime.frame.origin.y + dateTime.frame.size.height + 3, 14.5, 19);
    BasicLabel *location = [[BasicLabel alloc]initWithName:ShowUserComadId];
    location.text = @"未定";
    [location sizeToFit];
    location.frame = CGRectMake(93, dateTime.frame.origin.y + dateTime.frame.size.height + 5, location.frame.size.width, location.frame.size.height);
    
    //右上の時間
    NSString *createdTime = @"2012-11-22 12:00";
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
    
    //iOS6対応
    if((int)iOSVersion == 6){
        title.frame = CGRectMake(77, name.frame.origin.y + name.frame.size.height - 2, title.frame.size.width, title.frame.size.height);
        datetimeIconView.frame = CGRectMake(75, title.frame.origin.y + title.frame.size.height + 1, 17.5, 17.5);
        dateTime.frame = CGRectMake(93, title.frame.origin.y + title.frame.size.height + 3, dateTime.frame.size.width, dateTime.frame.size.height);
        locationIconView.frame = CGRectMake(77, dateTime.frame.origin.y + dateTime.frame.size.height - 4, 14.5, 19);
        location.frame = CGRectMake(93, dateTime.frame.origin.y + dateTime.frame.size.height - 2, location.frame.size.width, location.frame.size.height);
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
    /*
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
    */
    ribbonImageName = @"nowRibbon.png";
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
    
    ConversationTextBox *textBox = [[ConversationTextBox alloc]init];
    textBox.frame = CGRectMake(0, 405, windowSize.size.width, 55);
    textBox.delegate = self;
    [self.view addSubview: baseView];
    [self.view addSubview: textBox];
}

#pragma ConversationTextBoxDelegate methods
//sendButton
-(void)sendClicked:(NSString *)text {
    [socketIO sendEvent:@"message" withData:@{@"message" : text}];
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
    NSLog(@"add stamp");
    
    [mask removeFromSuperview];
    [sm removeFromSuperview];
    NSString *stampName = [NSString stringWithFormat:@"(stamp_%i)", stampNum];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *imageName = [[defaults objectForKey:@"user"] objectForKey:@"imageName"];
    NSString *userName = [[defaults objectForKey:@"user"] objectForKey:@"name"];
    
   // [socketIO sendEvent:@"message" withData:@{@"message": stampName, @"userId": @(10), @"type": @"private", @"roomName": roomName, @"imageName": imageName, @"userName": userName}];
}

- (void)blackMaskTapped {
    [mask removeFromSuperview];
    [sm removeFromSuperview];
}

@end
