//
//  AddComadViewController+View.m
//  Comad
//
//  Created by 浅野 友希 on 2013/12/01.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "AddComadViewController.h"
#import "Image.h"
#import "BasicLabel.h"
#import "URBSegmentedControl.h"
#import "SVSegmentedControl.h"
#import <QuartzCore/QuartzCore.h>
#import "TweetButton.h"
#import "TimeSelectButton.h"
#import "EditTimeFormViewController.h"
#import "EditLoacationFormViewController.h"
#import "Configuration.h"

@implementation AddComadViewController (View)
- (void)configure {
    UIView *addComadView = [[UIView alloc]init];
    addComadView.backgroundColor = [UIColor colorWithRed:0.902 green:0.890 blue:0.875 alpha:1.0];
    if((int)iOSVersion == 7){
        addComadView.frame = CGRectMake(0, 77, windowSize.size.width, windowSize.size.height - 77);
    }else if((int)iOSVersion == 6){
        addComadView.frame = CGRectMake(0, 48, windowSize.size.width, windowSize.size.height - 48);
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary* userInfo = [defaults objectForKey:@"user"];
    
    //サムネイル、名前、ComadId
    NSString *imageUrl = [NSString stringWithFormat:@"%@/images/profile/%@",HOST_URL, [[Configuration user] objectForKey:@"image_name"]];
    UIImage *thumbnailImage = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString: imageUrl]]];
    UIImage *cornerThumbnail = [Image makeCornerRoundImage:thumbnailImage];
    UIImageView *thumbnail = [[UIImageView alloc]initWithImage:cornerThumbnail];
    thumbnail.frame = CGRectMake(10, 5, 37, 37);
    thumbnail.layer.cornerRadius = 14.0f;
    
    BasicLabel *name = [[BasicLabel alloc]initWithName:BlueTitle];
    BasicLabel *comadId = [[BasicLabel alloc]initWithName:ComadId];
    
    name.backgroundColor = [UIColor colorWithRed:0.902 green:0.890 blue:0.875 alpha:1.0];
    comadId.backgroundColor = [UIColor colorWithRed:0.902 green:0.890 blue:0.875 alpha:1.0];
    
    name.text = [userInfo objectForKey:@"name"];
    if([[userInfo objectForKey:@"comad_id"] isEqualToString:@""]){
        comadId.text = @"";
    }else {
        comadId.text = [NSString stringWithFormat:@"@%@",[userInfo objectForKey:@"comad_id"]];
    }

    [name sizeToFit];
    [comadId sizeToFit];
    
    name.frame = CGRectMake(52, 12, name.frame.size.width, name.frame.size.height);
    comadId.frame = CGRectMake(name.frame.origin.x, name.frame.origin.y + 16, comadId.frame.size.width, comadId.frame.size.height);
    
    [addComadView addSubview: thumbnail];
    [addComadView addSubview: name];
    [addComadView addSubview: comadId];
    
    //吹き出しのところ
    UIImage *bubbleImage = [UIImage imageNamed:@"addComadBubble.png"];
    UIImageView *bubble = [[UIImageView alloc]initWithImage:bubbleImage];
    bubble.frame = CGRectMake(5, 42, 308.5, 69.5);
    bubble.userInteractionEnabled = YES;
    
    tv = [[UITextView alloc]init];
    tv.backgroundColor = [UIColor whiteColor];
    tv.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14.0f];
    tv.frame = CGRectMake(6, 10, bubble.frame.size.width - 13, bubble.frame.size.height - 13);
    tv.delegate = self;
    tv.layer.cornerRadius = 5;
    tv.keyboardType = UIKeyboardTypeDefault;
    tv.clipsToBounds = true;
    
    placeholder = [[BasicLabel alloc]initWithName: PlaceHolder];
    placeholder.text = @"ひとこと";
    [placeholder sizeToFit];
    placeholder.frame = CGRectMake(5, 9, placeholder.frame.size.width, placeholder.frame.size.height);
    [tv addSubview: placeholder];
    
    wordCount = [[BasicLabel alloc]initWithName:GrayLabel];
    wordCount.text = @"0/30";
    [wordCount sizeToFit];
    if((int)iOSVersion == 6){
        wordCount.frame = CGRectMake(tv.frame.size.width - wordCount.frame.size.width - 10, tv.frame.size.height - wordCount.frame.size.height, wordCount.frame.size.width, wordCount.frame.size.height);
    }else if((int)iOSVersion == 7){
        wordCount.frame = CGRectMake(tv.frame.size.width - wordCount.frame.size.width - 5, tv.frame.size.height - wordCount.frame.size.height - 5, wordCount.frame.size.width, wordCount.frame.size.height);
    }
    
    [tv addSubview: wordCount];
    [bubble addSubview: tv];
    
    [addComadView addSubview: bubble];
    
    //なうとか
    timeSelect = [[TimeSelectButton alloc]init];
    timeSelect.frame = CGRectMake(7, 119, 305, 31);
    [addComadView addSubview: timeSelect];
    
    //時間
    UIImage *timeIcon = [UIImage imageNamed:@"datetimeIcon.png"];
    UIImageView *timeIconView = [[UIImageView alloc]initWithImage: timeIcon];
    timeIconView.frame = CGRectMake(115, 170, 17.5, 17.5);
    BasicLabel *timeLabel = [[BasicLabel alloc]initWithName:AddComadLabel];
    timeLabel.text = @"時間";
    [timeLabel sizeToFit];
    timeLabel.frame = CGRectMake(130, timeIconView.frame.origin.y + 1, timeLabel.frame.size.width, timeLabel.frame.size.height);
    [addComadView addSubview: timeLabel];
    
    UIImage *form = [UIImage imageNamed:@"cell.png"];
    UIImageView *timeFormView = [[UIImageView alloc]initWithImage:form];
    timeFormView.backgroundColor = [UIColor whiteColor];
    timeFormView.layer.cornerRadius = 5;
    timeFormView.clipsToBounds = true;
    timeFormView.frame = CGRectMake(160, timeIconView.frame.origin.y - 3, 150, timeIconView.frame.size.height + 6);
    timeFormView.userInteractionEnabled = YES;
    UITapGestureRecognizer *timeFormTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(timeFormTabpped:)];
    [timeFormView addGestureRecognizer: timeFormTapGesture];
    
    datetime = [[BasicLabel alloc]initWithName:TimeAndLocationLabel];
    datetime.text = @"未定";
    [datetime sizeToFit];
    datetime.frame = CGRectMake((150-datetime.frame.size.width)/2, 4, datetime.frame.size.width, datetime.frame.size.height);
    [timeFormView addSubview: datetime];
    
    [addComadView addSubview: timeIconView];
    [addComadView addSubview: timeFormView];
    
    //場所
    UIImage *locationIcon = [UIImage imageNamed:@"locationIcon.png"];
    UIImageView *locationIconView = [[UIImageView alloc]initWithImage: locationIcon];
    locationIconView.frame = CGRectMake(115, timeIconView.frame.origin.y + timeIconView.frame.size.height + 15, 14.5, 19);
    [addComadView addSubview: locationIconView];
    
    BasicLabel *locationLabel = [[BasicLabel alloc]initWithName:AddComadLabel];
    locationLabel.text = @"場所";
    [locationLabel sizeToFit];
    locationLabel.frame = CGRectMake(130, locationIconView.frame.origin.y + 1, locationLabel.frame.size.width, locationLabel.frame.size.height);
    [addComadView addSubview: locationLabel];
    
    UIImageView *locationFormView = [[UIImageView alloc]initWithImage:form];
    locationFormView.backgroundColor = [UIColor whiteColor];
    locationFormView.layer.cornerRadius = 5;
    locationFormView.clipsToBounds = true;
    locationFormView.frame = CGRectMake(160, locationIconView.frame.origin.y - 3, 150, locationIconView.frame.size.height + 6);
    locationFormView.userInteractionEnabled = YES;
    UITapGestureRecognizer *locationFormTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(locationFormTabpped:)];
    [locationFormView addGestureRecognizer:locationFormTapGesture];
    
    location = [[BasicLabel alloc]initWithName:TimeAndLocationLabel];
    location.text = @"未定";
    [location sizeToFit];
    location.frame = CGRectMake((150-location.frame.size.width)/2, 4, location.frame.size.width, location.frame.size.height);
    [locationFormView addSubview: location];
    
    [addComadView addSubview: locationFormView];
    
    //tweet
    tweetButton = [[TweetButton alloc]init];
    tweetButton.frame = CGRectMake(15, timeLabel.frame.origin.y - 7, tweetButton.frame.size.width, tweetButton.frame.size.height);
    [addComadView addSubview: tweetButton];
    tweetButton.tweet = false;
    
    [self.view addSubview: addComadView];
}

- (void)segmentedControlChangedValue:(SVSegmentedControl*)segmentedControl {
    switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            segmentedControl.thumb.tintColor = [UIColor colorWithRed:0.937 green:0.322 blue:0.510 alpha:1.0];
            break;
        case 1:
            segmentedControl.thumb.tintColor = [UIColor colorWithRed:1.000 green:0.729 blue:0.302 alpha:1.0];
            break;
        case 2:
            segmentedControl.thumb.tintColor = [UIColor colorWithRed:0.329 green:0.773 blue:0.706 alpha:1.0];
            break;
        case 3:
            segmentedControl.thumb.tintColor = [UIColor colorWithRed:0.298 green:0.537 blue:0.925 alpha:1.0];
            break;
        case 4:
            segmentedControl.thumb.tintColor = [UIColor colorWithRed:0.471 green:0.349 blue:0.690 alpha:1.0];
            break;
        default:
            break;
    }
}

- (void)timeFormTabpped:(UITapGestureRecognizer *)sender {
    EditTimeFormViewController *ec = [[EditTimeFormViewController alloc]init];
    if(![datetime.text isEqualToString:@"未定"]){
        NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
        [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSDate *formatterDate = [inputFormatter dateFromString: datetime.text];
        ec.beforeEditTime = formatterDate;
    }
    ec.delegate = self;
    [self.navigationController pushViewController:ec animated:YES];
}

- (void)locationFormTabpped:(UITapGestureRecognizer *)sender {
    EditLoacationFormViewController *ec = [[EditLoacationFormViewController alloc]init];
    ec.location = location.text;
    ec.delegate = self;
    [self.navigationController pushViewController:ec animated:YES];
}

@end
