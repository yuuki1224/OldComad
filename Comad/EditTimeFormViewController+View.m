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
    [self.view setBackgroundColor:[UIColor colorWithRed:0.855 green:0.886 blue:0.929 alpha:1.0]];
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
    timeTable.frame = CGRectMake(0, 127, windowSize.size.width, 80);
    [self.view addSubview:timeTable];
    [self.view addSubview:datePicker];
    [datePicker addTarget:self action:@selector(changeDatePicker:) forControlEvents:UIControlEventValueChanged];
    
}

#pragma UITableDateSource methods
//Rowの数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
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
        if([format stringFromDate:self.afterEditStartTime]){
            cell.detailTextLabel.text = [format stringFromDate:self.afterEditStartTime];
        }else{
            cell.detailTextLabel.text = @"まだ指定されていません";
        }
    }else if(indexPath.row==1){
        cell.textLabel.text = @"終了時刻";
        if([format stringFromDate:self.afterEditEndTime]){
            cell.detailTextLabel.text = [format stringFromDate:self.afterEditEndTime];
        }else{
            cell.detailTextLabel.text = @"まだ指定されていません";
        }
    }
    return cell;
}

@end
