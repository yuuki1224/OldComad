//
//  EditTimeFormViewController+View.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/04.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "EditTimeFormViewController.h"

@implementation EditTimeFormViewController (View)

-(void)configure {
    self.view.backgroundColor = [UIColor colorWithRed:0.902 green:0.890 blue:0.875 alpha:1.0];
    timeTable = [[UITableView alloc]init];
    timeTable.dataSource = self;
    timeTable.delegate = self;
    timeTable.scrollEnabled = NO;
    
    datePicker = [[UIDatePicker alloc]init];
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    gregorian.locale = [NSLocale currentLocale];
    datePicker.calendar = gregorian;
    datePicker.backgroundColor = [UIColor whiteColor];
    datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    datePicker.minuteInterval = 30;
    datePicker.frame = CGRectMake(0, windowSize.size.height - datePicker.frame.size.height, windowSize.size.width, datePicker.frame.size.height);
    
    if((int)iOSVersion == 6){
        timeTable.frame = CGRectMake(0, 68, windowSize.size.width, 40);
    }else if((int)iOSVersion == 7){
        timeTable.frame = CGRectMake(0, 95, windowSize.size.width, 40);
    }
    [self.view addSubview:timeTable];
    [self.view addSubview:datePicker];
    [datePicker addTarget:self action:@selector(changeDatePicker:) forControlEvents:UIControlEventValueChanged];
    
}

#pragma UITableDateSource methods
//Rowの数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

//セクションの数
-(NSInteger)numberOfSectionsInTableView: (UITableView *)tableView {
    return 1;
}

//セルの高さ
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

//ヘッダーの高さ
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

//セルの内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"a"];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.textLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14.0f];
    cell.detailTextLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14.0f];
    
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"MM/dd HH:mm"];
    if(indexPath.row==0){
        cell.textLabel.text = @"開始時刻";
        if([format stringFromDate:self.beforeEditTime]){
            cell.detailTextLabel.text = [format stringFromDate:self.beforeEditTime];
        }else{
            cell.detailTextLabel.text = @"まだ指定されていません";
        }
    }
    return cell;
}

@end
