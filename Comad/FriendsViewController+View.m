
//
//  FriendsViewController+View.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/26.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "FriendsViewController.h"
#import "FriendCell.h"
#import "Image.h"
#import "SVProgressHUD.h"
#import "FriendJsonClient.h"
#import "ShowUserViewController.h"
#import "ShowGroupViewController.h"

@implementation FriendsViewController (View)
- (void)setInfo {
    [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeBlack];
    
    [[FriendJsonClient sharedClient] getIndexWhenSuccess:^(AFHTTPRequestOperation *operation, NSHTTPURLResponse *response, id responseObject) {
        NSDictionary *me = [responseObject objectForKey:@"me"];
        
        self.me = me;
        _newFriends = [responseObject objectForKey:@"new"];
        _friends = [responseObject objectForKey:@"friends"];
        _groups = [responseObject objectForKey:@"groups"];
        
        NSLog(@"me: %@", me);
        
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [me objectForKey:@"id"], @"id",
                                  [me objectForKey:@"name"], @"name",
                                  [me objectForKey:@"comad_id"], @"comadId",
                                  [me objectForKey:@"occupation"], @"occupation",
                                  [me objectForKey:@"description"], @"detail",
                                  [me objectForKey:@"image_name"], @"imageName",
                                  [me objectForKey:@"question1"], @"question1", nil];
        
        
        NSMutableArray *friendsMutableArray = [NSMutableArray array];
        for (int i = 0; [_friends count] > i; i++) {
            [friendsMutableArray addObject:[_friends objectAtIndex:i]];
        }
        
        //userDefaultのfriendsにしまう。
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSData *friendsData = [NSKeyedArchiver archivedDataWithRootObject: friendsMutableArray];
        [userDefaults setObject: userInfo forKey:@"user"];
        [userDefaults setObject: friendsData forKey:@"friends"];
        [userDefaults synchronize];
        
        [friendsTable reloadData];
        [SVProgressHUD dismiss];
    } failure:^(int statusCode, NSString *errorString) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:errorString message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [SVProgressHUD dismiss];
    }];
}

- (void)configure {
    friendsTable = [[UITableView alloc] init];
    friendsTable.dataSource = self;
    friendsTable.delegate = self;
    
    windowSize = [[UIScreen mainScreen] bounds];
    if((int)iOSVersion == 7){
        friendsTable.frame = CGRectMake(0, 78, windowSize.size.width, windowSize.size.height - 127);
    }else if ((int)iOSVersion == 6){
        float statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        float tabHeight = [[[self tabBarController] rotatingFooterView] frame].size.height;
        friendsTable.frame = CGRectMake(0, 48 + statusBarHeight, windowSize.size.width, (windowSize.size.height - statusBarHeight - tabHeight - 96));
    }
    
    [self.view addSubview:friendsTable];
}

//For tableViewDataSource
//セクションの中のセルの数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"count数: %d, %d, %d", [_newFriends count], [_groups count], [_friends count]);
    
    switch (section) {
        case 0:
            return 0;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return [_newFriends count];
            break;
        case 3:
            return [_groups count];
            break;
        case 4:
            return [_friends count];
            break;
        default:
            return 0;
            break;
    }
}

//セクションの数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

//セルの内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendCell *cell = [[FriendCell alloc]init];
    //プロフィール
    if(indexPath.section == 1){
        cell.userInfo = self.me;
        [cell setFriendCell:NO];
        //新しいコマとも
    }else if(indexPath.section == 2){
        cell.userInfo = [_newFriends objectAtIndex:indexPath.row];
        [cell setFriendCell:YES];
        //グループ
    }else if(indexPath.section == 3){
        cell.groupInfo = [_groups objectAtIndex:indexPath.row];
        [cell setGroupCell];
        //コマとも
    }else if(indexPath.section == 4){
        cell.userInfo = [_friends objectAtIndex:indexPath.row];
        [cell setFriendCell:NO];
    }else {
    }
    return  cell;
}

//For UITableViewDelegate
//ヘッダーの高さ
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            //return 60.0;
            return 0;
            break;
        case 1:
            return 35.0;
            break;
        case 2:{
            if([_newFriends count] == 0){
                return 0;
            }else{
                return 35.0;
            }
            break;
        }
        case 3:{
            if([_groups count] == 0){
                return 0;
            }else{
                return 35.0;
            }
            break;
        }
        case 4:{
            if([_friends count] == 0){
                return 0;
            }else{
                return 35.0;
            }
            break;
        }
        default:
            return 30.0;
            break;
    }
}

//セルの高さ
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 64.0;
            break;
        case 1:
            return 64.0;
            break;
        // new
        case 2:
            return 64.0;
            break;
        // group
        case 3:
            return 64.0;
            break;
        // friends
        case 4:
            return 64.0;
            break;
        default:
            break;
    }
    return 64;
}

// HeaderのView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    windowSize = [[UIScreen mainScreen] bounds];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, windowSize.size.width, 35)];
    UIView *content = [[UIView alloc]initWithFrame:CGRectMake(0, 0, windowSize.size.width, 33)];
    
    content.backgroundColor = [UIColor colorWithRed:0.902 green:0.898 blue:0.882 alpha:1.0];
    headerView.backgroundColor = [UIColor colorWithRed:0.878 green:0.878 blue:0.871 alpha:1.0];
    
    [headerView addSubview:content];
    
    if(section == 0){
        headerView.frame = CGRectMake(0, 0, windowSize.size.width, 60);
        search = [[UISearchBar alloc]init];
        search.delegate = self;
        search.placeholder = @"Search";
        search.tintColor = [UIColor colorWithRed:0.796 green:0.816 blue:0.839 alpha:1.0];
        search.frame = CGRectMake(0, 0, windowSize.size.width, 60);
        search.showsCancelButton = NO;
        [headerView addSubview:search];
        headerView.backgroundColor = [UIColor colorWithRed:0.796 green:0.816 blue:0.839 alpha:1.0];
    }else{
        UILabel *titleLabel = [[UILabel alloc] init];
        switch (section) {
            case 1:
                titleLabel.text = @"プロフィール";
                break;
            case 2:
                titleLabel.text = @"新しいコマとも";
                break;
            case 3:
                titleLabel.text = @"グループ";
                break;
            case 4:
                titleLabel.text = @"コマとも";
                break;
            default:
                break;
        }
        
        titleLabel.textColor = [UIColor colorWithRed:0.333 green:0.333 blue:0.333 alpha:1.0];
        UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W6" size:12.0f];
        titleLabel.font = font;
        [titleLabel sizeToFit];
        titleLabel.frame = CGRectMake(10, 10, titleLabel.frame.size.width, titleLabel.frame.size.height);
        titleLabel.backgroundColor = [UIColor colorWithRed:0.902 green:0.898 blue:0.882 alpha:1.0];
        
        [content addSubview: titleLabel];
    }
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"touch! %d", indexPath.row);
    //indexPathよりCellの情報取りたい
    FriendCell *cell = [friendsTable cellForRowAtIndexPath: indexPath];
    
    NSDictionary *userInfo= cell.userInfo;
    if(indexPath.section == 1){
        //マイページ
        ShowUserViewController *sc =[[ShowUserViewController alloc]init];
        [sc setMe: YES];
        sc.userInfo = userInfo;
        sc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:sc animated:YES];
    }else if (indexPath.section == 2){
        [self.delegate showModalView: userInfo];
    }else if (indexPath.section == 3){
        //グループ表示
        ShowGroupViewController *sc =[[ShowGroupViewController alloc]init];
        [self.navigationController pushViewController:sc animated:YES];
    }else if (indexPath.section == 4){
        [self.delegate showModalView: userInfo];
    }
}

@end
