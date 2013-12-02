//
//  EditTimeFormViewController.h
//  Comad
//
//  Created by 浅野 友希 on 2013/11/03.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Basic.h"

@protocol EditTimeFormDelegate;

@interface EditTimeFormViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    CGRect windowSize;
    float iOSVersion;
    UITableView *timeTable;
    UIDatePicker *datePicker;
}

@property (nonatomic, weak) id<EditTimeFormDelegate> delegate;
@property (nonatomic, retain) NSDate *beforeEditTime;

-(void)hoge:(UIDatePicker*)dp;
-(void)configure;
@end

@protocol EditTimeFormDelegate <NSObject>
- (void)changeTime:(NSDate *)time;
@end

