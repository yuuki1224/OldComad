//
//  AddFriendViewController+View.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/16.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "AddFriendViewController.h"
#import "AddFriendMenu.h"
#import "BasicLabel.h"
#import "FriendCell.h"
#import "SVProgressHUD.h"
#import "UserJsonClient.h"

@implementation AddFriendViewController (View)
- (void)setInfo {
    [[UserJsonClient sharedClient] getAddFriendInfo:^(AFHTTPRequestOperation *operation, NSHTTPURLResponse *response, id responseObject) {
        facebookFriends = [[NSMutableArray alloc]init];
        for (int i = 0; [responseObject count] > i; i++) {
            [facebookFriends addObject: [responseObject objectAtIndex: i]];
        }
        [SVProgressHUD dismiss];
        [addFriendsTable reloadData];
    } failure:^(int statusCode, NSString *errorString) {
        NSLog(@"error");
        [SVProgressHUD dismiss];
    }];
}

- (void)configure {
    AddFriendMenu *menu = [[AddFriendMenu alloc]init];
    menu.delegate = self;
    
    if((int)iOSVersion == 6){
        menu.frame = CGRectMake(0, 48, windowSize.size.width, 87);
    }
    
    addFriendsTable = [[UITableView alloc]init];
    if((int)iOSVersion == 7){
        addFriendsTable.frame = CGRectMake(0, 77, windowSize.size.width, windowSize.size.height);
    }else if((int)iOSVersion == 6){
        addFriendsTable.frame = CGRectMake(0, 0, windowSize.size.width, windowSize.size.height -16);
    }
    addFriendsTable.delegate = self;
    addFriendsTable.dataSource = self;
    addFriendsTable.contentInset = UIEdgeInsetsMake(133, 0, 0, 0);
    
    [self.view addSubview: addFriendsTable];
    [self.view addSubview: menu];
}

#pragma UITableViewDataSourceDelegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return [facebookFriends count];
            break;
        case 1:
            return 0;
            break;
        default:
            break;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendCell *cell = [[FriendCell alloc]init];
    NSDictionary *userInfo = [facebookFriends objectAtIndex: indexPath.row];
  
    if(indexPath.section == 0){
        cell.userInfo = userInfo;
        [cell setFriendCell:NO];
    }else if(indexPath.section == 1){
        //招待ボタン付ける
        cell.userInfo = userInfo;
        //[cell setFriendCellWithURL];
        [cell setFriendCell:NO];
        [cell setInviteButton];
        cell.delegate = self;
    }
    return cell;
}

#pragma UITableViewDelegate methods
//セルの高さ
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

//ヘッダーの高さ
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

//フッターの高さ
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, windowSize.size.width, 35)];
    UIView *content = [[UIView alloc]initWithFrame:CGRectMake(0, 0, windowSize.size.width, 33)];
    
    content.backgroundColor = [UIColor colorWithRed:0.902 green:0.898 blue:0.882 alpha:1.0];
    headerView.backgroundColor = [UIColor colorWithRed:0.878 green:0.878 blue:0.871 alpha:1.0];
    
    [headerView addSubview:content];
    UILabel *titleLabel = [[UILabel alloc] init];
    if(section == 0){
        [titleLabel setText:@"知り合いかも"];
    }else if (section == 1){
        [titleLabel setText:@"友達をコマドに招待しよう!"];
    }
    titleLabel.textColor = [UIColor colorWithRed:0.333 green:0.333 blue:0.333 alpha:1.0];
    UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W6" size:12.0f];
    titleLabel.font = font;
    [titleLabel sizeToFit];
    titleLabel.frame = CGRectMake(10, 10, titleLabel.frame.size.width, titleLabel.frame.size.height);
    titleLabel.backgroundColor = [UIColor colorWithRed:0.902 green:0.898 blue:0.882 alpha:1.0];
    
    [content addSubview: titleLabel];

    return headerView;
}

@end
