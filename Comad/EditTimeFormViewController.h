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
    UITableView *timeTable;
    UIDatePicker *datePicker;
}

@property (nonatomic, weak) id<EditTimeFormDelegate> delegate;
@property (nonatomic) TimeSelected selected;
@property (nonatomic, retain) NSDate *beforeEditStartTime;
@property (nonatomic, retain) NSDate *beforeEditEndTime;
@property (nonatomic, retain) NSDate *afterEditStartTime;
@property (nonatomic, retain) NSDate *afterEditEndTime;

-(void)hoge:(UIDatePicker*)dp;
-(void)configure;
@end

@protocol EditTimeFormDelegate <NSObject>
- (void)changeTime:(NSDate *)startTime endTime:(NSDate *)endTime;
@end

