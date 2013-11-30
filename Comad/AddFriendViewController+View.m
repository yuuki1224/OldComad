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

@implementation AddFriendViewController (View)
- (void)configure {
    AddFriendMenu *menu = [[AddFriendMenu alloc]init];
    menu.delegate = self;
    
    if((int)iOSVersion == 6){
        menu.frame = CGRectMake(0, 48, windowSize.size.width, 87);
    }
    
    UIView *createGroup = [[UIView alloc] init];
    if((int)iOSVersion == 7){
        createGroup.frame = CGRectMake(0, 164, windowSize.size.width, 46);
    }else if((int)iOSVersion == 6){
        createGroup.frame = CGRectMake(0, 135, windowSize.size.width, 46);
    }
    createGroup.backgroundColor = [UIColor colorWithRed:0.796 green:0.816 blue:0.839 alpha:1.0];
    BasicLabel *createGroupLabel = [[BasicLabel alloc]initWithName: AddFriendCreateGroup];
    BasicLabel *createGroupAccessory = [[BasicLabel alloc]initWithName: AddFriendCreateGroup];
    [createGroupLabel setText:@"グループ作成"];
    [createGroupAccessory setText:@">"];
    [createGroupLabel sizeToFit];
    [createGroupAccessory sizeToFit];
    if((int)iOSVersion == 7){
        createGroupLabel.frame = CGRectMake(20, (46 - createGroupLabel.frame.size.height)/2, createGroupLabel.frame.size.width, createGroupLabel.frame.size.height);
        createGroupAccessory.frame = CGRectMake(windowSize.size.width - 25, (46 - createGroupLabel.frame.size.height)/2, createGroupAccessory.frame.size.width, createGroupAccessory.frame.size.height);
    }else if ((int)iOSVersion == 6){
        createGroupLabel.frame = CGRectMake(20, 16, createGroupLabel.frame.size.width, createGroupLabel.frame.size.height);
        createGroupAccessory.frame = CGRectMake(windowSize.size.width - 25, 15, createGroupAccessory.frame.size.width, createGroupAccessory.frame.size.height);
    }
    
    [createGroup addSubview: createGroupLabel];
    [createGroup addSubview: createGroupAccessory];
    
    UITapGestureRecognizer *createGroupRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(createGroupClicked:)];
    [createGroup addGestureRecognizer: createGroupRecognizer];
    
    UITableView *addFriendsTable = [[UITableView alloc]init];
    if((int)iOSVersion == 7){
        addFriendsTable.frame = CGRectMake(0, 77, windowSize.size.width, windowSize.size.height);
    }else if((int)iOSVersion == 6){
        addFriendsTable.frame = CGRectMake(0, 48, windowSize.size.width, windowSize.size.height);
    }
    addFriendsTable.delegate = self;
    addFriendsTable.dataSource = self;
    addFriendsTable.contentInset = UIEdgeInsetsMake(133, 0, 0, 0);
    
    [self.view addSubview: addFriendsTable];
    [self.view addSubview: menu];
    [self.view addSubview:createGroup];
}

#pragma UITableViewDataSourceDelegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return [facebookFriends count];
            break;
        default:
            break;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@",[[facebookFriends objectAtIndex:indexPath.row] objectForKey:@"name"]);
    FriendCell *cell = [[FriendCell alloc]init];
    NSDictionary *userInfo;
    switch (indexPath.section) {
        case 0:{
            switch (indexPath.row) {
                case 0:{
                    userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"7", @"id",
                                @"村田温美", @"name",
                                @"murata.png", @"image_name",nil];
                    break;
                }
                case 1:{
                    userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"2", @"id",
                                @"足立壮大", @"name",
                                @"adachi.png", @"image_name",nil];
                    break;
                }
                case 2:{
                    userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"8", @"id",
                                @"小林大志", @"name",
                                @"kobayashi.png", @"image_name",nil];
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 1:{
            userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                        [[facebookFriends objectAtIndex:indexPath.row] objectForKey:@"name"], @"name",
                        @"asano.png", @"image_name",nil];
            break;
        }
        default:
            break;
    }
    if(indexPath.section == 0){
        cell.userInfo = userInfo;
        [cell setFriendCell:NO];
    }else if(indexPath.section == 1){
        //招待ボタン付ける
        cell.userInfo = userInfo;
        [cell setFriendCellWithURL];
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
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, windowSize.size.width, 60)];
    header.backgroundColor = [UIColor colorWithRed:0.965 green:0.969 blue:0.973 alpha:1.0];
    BasicLabel *headerLabel = [[BasicLabel alloc]initWithName: FriendCellName];
    if(section == 0){
        [headerLabel setText:@"知り合いかも"];
    }else if (section == 1){
        [headerLabel setText:@"友達をコマドに招待しよう!"];
    }
    [headerLabel sizeToFit];
    headerLabel.frame = CGRectMake(10, 10, headerLabel.frame.size.width, headerLabel.frame.size.height);
    headerLabel.backgroundColor = [UIColor colorWithRed:0.965 green:0.969 blue:0.973 alpha:1.0];
    [header addSubview:headerLabel];
    return header;
}

@end
