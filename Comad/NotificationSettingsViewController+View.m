//
//  NotificationSettingsViewController+View.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/05.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "NotificationSettingsViewController.h"

@implementation NotificationSettingsViewController (View)

-(void)configure {
    notificationSettingsTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 48, windowSize.size.width, windowSize.size.height - 48) style:UITableViewStyleGrouped];
    notificationSettingsTable.delegate = self;
    notificationSettingsTable.dataSource = self;
    
    [self.view addSubview:notificationSettingsTable];
}

//Rowの数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 1;
            break;
        default:
            break;
    }
    return 0;
}

//セクションの数
-(NSInteger)numberOfSectionsInTableView: (UITableView *)tableView {
    return 1;
}

//セルの高さ
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:{
            return 40;
        }
            break;
        case 1:{
            return 40;
        }
            break;
        case 2:{
            return 40;
        }
            break;
        default:
            break;
    }
    return 0;
}

//ヘッダーの高さ
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

//ヘッダーの内容
/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc]init];
    switch (section) {
        case 0:{
            header.frame = CGRectMake(0, 0, windowSize.size.width, 100);
            //header.backgroundColor = [UIColor colorWithRed:0.894 green:0.902 blue:0.906 alpha:1.0];
            break;
        }
        case 1:{
            header.frame = CGRectMake(0, 0, windowSize.size.width, 70);
            //header.backgroundColor = [UIColor colorWithRed:0.894 green:0.902 blue:0.906 alpha:1.0];
            break;
        }
        case 2:{
            header.frame = CGRectMake(0, 0, windowSize.size.width, 70);
            //header.backgroundColor = [UIColor colorWithRed:0.894 green:0.902 blue:0.906 alpha:1.0];
            break;
        }
        default:
            break;
    }
    return header;
}
 */

//セルの内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"a"];
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14.0f];
    cell.detailTextLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14.0f];
    
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"通知";
                    break;
                case 1:
                    cell.textLabel.text = @"一時停止";
                    break;
                case 2:
                    cell.textLabel.text = @"通知サウンド";
                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    cell.detailTextLabel.text = @"タップで編集";
                    break;
                default:
                    break;
            }
            break;
        case 2:
            switch (indexPath.row) {
                case 0:
                    cell.detailTextLabel.text = @"タップで編集";
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
    
    return cell;
}

@end
