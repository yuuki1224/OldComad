//
//  EditLocationStatusFormViewController+View.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/05.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "EditLocationStatusFormViewController.h"

@implementation EditLocationStatusFormViewController (View)

-(void)configure {
    locationStatusTable = [[UITableView alloc]init];
    locationStatusTable.frame = CGRectMake(0, 127, windowSize.size.width, 80);
    locationStatusTable.dataSource = self;
    locationStatusTable.delegate = self;
    locationStatusTable.scrollEnabled = NO;
    
    [self.view addSubview:locationStatusTable];
    picker = [[UIPickerView alloc]init];
    picker.delegate = self;
    picker.dataSource = self;
    picker.frame = CGRectMake(0, windowSize.size.height - 200, windowSize.size.width, 200);
    picker.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:picker];
}

//Rowの数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
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
        cell.textLabel.text = @"電源";
        switch (self.powerSource) {
            case IDontKnow:
                cell.detailTextLabel.text = @"指定しない";
                break;
            case Exist:
                cell.detailTextLabel.text = @"あり";
                break;
            case Nothing:
                cell.detailTextLabel.text = @"なし";
                break;
            default:
                cell.detailTextLabel.text = @"設定しない";
                break;
        }
    }else if(indexPath.row==1){
        cell.textLabel.text = @"wifi";
        switch (self.wifi) {
            case IDontKnow:
                cell.detailTextLabel.text = @"指定しない";
                break;
            case Exist:
                cell.detailTextLabel.text = @"あり";
                break;
            case Nothing:
                cell.detailTextLabel.text = @"なし";
                break;
            default:
                cell.detailTextLabel.text = @"設定しない";
                break;
        }
    }
    return cell;
}

#pragma UIPickerView methods
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 3;
}

-(NSString*)pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(row == 0){
        return @"指定しない";
    }else if(row == 1){
        return @"あり";
    }else if(row == 2){
        return @"なし";
    }
    return @"";
}

@end
