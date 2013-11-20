//
//  MailSettingsViewController+View.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/05.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "MailSettingsViewController.h"

@implementation MailSettingsViewController (View)

-(void)configure {
    mailSettingsTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 77, windowSize.size.width, windowSize.size.height - 77) style:UITableViewStyleGrouped];
    
    mailSettingsTable.delegate = self;
    mailSettingsTable.dataSource = self;
    mailSettingsTable.frame = CGRectMake(0, 77, windowSize.size.width, windowSize.size.height - 77);
    
    [self.view addSubview: mailSettingsTable];
}

#pragma UITableViewDataSource methods
//セクション内の列の数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 1;
            break;
        default:
            break;
    }
    return 0;
}

//セルの内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14.0f];
    
    switch (indexPath.section) {
        case 0:
            if(indexPath.row == 0){
                [cell setText:@"bar"];
            }else if(indexPath.row == 1){
                [cell setText:@"foo"];
            }
            break;
        case 1:
            if(indexPath.row == 0){
                [cell setText:@"baz"];
            }else if(indexPath.row == 1){
                [cell setText:@"piyo"];
            }
            break;
        case 2:
            if(indexPath.row == 0){
                [cell setText:@"hoge"];
            }
        default:
            break;
    }
    return cell;
}

//セクションの数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

//ヘッダーのタイトル
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"";
}

#pragma UITableViewDelegate methods
//セルの高さ
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

//ヘッダーの高さ
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}


@end
