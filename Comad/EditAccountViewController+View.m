//
//  EditAccountViewController+View.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/05.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "EditAccountViewController.h"
#import "BasicLabel.h"
#import "Image.h"

@implementation EditAccountViewController (View)

-(void)configure {
    //editAccountTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 77, windowSize.size.width, windowSize.size.height - 77) style:UITableViewStyleGrouped];
    editAccountTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 48, windowSize.size.width, windowSize.size.height - 48) style:UITableViewStyleGrouped];
    editAccountTable.delegate = self;
    editAccountTable.dataSource = self;
    
    [self.view addSubview:editAccountTable];
}

//Rowの数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

//セクションの数
-(NSInteger)numberOfSectionsInTableView: (UITableView *)tableView {
    return 1;
}

//セルの高さ
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

//ヘッダーの高さ
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

//ヘッダーの内容
/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

}
*/
//セルの内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"a"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14.0f];
    cell.detailTextLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14.0f];
    
    cell.textLabel.text = @"メールアドレス";
    cell.detailTextLabel.text = @"yuuki.1224.softtennis@gmail.com";
    
    return cell;
}

@end
