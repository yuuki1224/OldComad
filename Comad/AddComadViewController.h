//
//  AddComadViewController.h
//  Comad
//
//  Created by 浅野 友希 on 2013/12/01.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import "BasicLabel.h"
#import "URBSegmentedControl.h"
#import "EditTimeFormViewController.h"
#import "EditLoacationFormViewController.h"
#import "TimeSelectButton.h"
#import "TweetButton.h"

@protocol AddComadViewDelegate;

@interface AddComadViewController : UIViewController <EditTimeFormDelegate, EditLocationFormDelegate, UIAlertViewDelegate> {
    float iOSVersion;
    CGRect windowSize;
    BasicLabel *wordCount;
    UITextView *tv;
    BasicLabel *datetime;
    BasicLabel *location;
    TimeSelectButton *timeSelect;
    TweetButton *tweetButton;
}
@property (nonatomic, weak) id<AddComadViewDelegate> delegate;
- (void)configure;
@end

@protocol AddComadViewDelegate <NSObject>
- (void)created;
@end

