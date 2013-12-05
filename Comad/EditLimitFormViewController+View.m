//
//  EditLimitFormViewController+View.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/05.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "EditLimitFormViewController.h"

@implementation EditLimitFormViewController (View)

-(void)configure {
    limitTable = [[UITableView alloc]init];
    limitTable.frame = CGRectMake(0, 117, windowSize.size.width, 40);
    limitTable.dataSource = self;
    limitTable.delegate = self;
    limitTable.scrollEnabled = NO;
    [self.view addSubview: limitTable];
    
    picker = [[UIPickerView alloc]init];
    picker.delegate = self;
    picker.dataSource = self;
    picker.frame = CGRectMake(0, windowSize.size.height - 200, windowSize.size.width, 200);
    picker.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:picker];
}

//Rowの数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

#pragma UITableViewDataSource methods
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
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.textLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14.0f];
    cell.detailTextLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14.0f];
    if(indexPath.row==0){
        cell.textLabel.text = @"人数制限";
        if(self.limit){
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%d人", self.limit];
        }else {
            cell.detailTextLabel.text = @"指定しない";
        }
    }
    return cell;
}

#pragma UIPickerView methods
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 20;
}

-(NSString*)pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(row == 0){
        return @"指定しない";
    }else{
        return [NSString stringWithFormat:@"%d人",row];
    }
    return @"";
}
@end
