
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
        
        NSMutableArray *friendsMutableArray = [NSMutableArray array];
        for (int i = 0; [_friends count] > i; i++) {
            [friendsMutableArray addObject:[_friends objectAtIndex:i]];
        }
        
        //userDefaultのfriendsにしまう。
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSData *friendsData = [NSKeyedArchiver archivedDataWithRootObject: friendsMutableArray];
        [userDefaults setObject: friendsData forKey:@"friends"];
        [userDefaults synchronize];
        
        [SVProgressHUD dismiss];
        [friendsTable reloadData];
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
    friendsTable.frame = CGRectMake(0, 78, windowSize.size.width, windowSize.size.height - 127);
    
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

//タイトル
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 1:
            return @"プロフィール";
            break;
        case 2:
            return @"新しいコマとも";
            break;
        case 3:
            return @"グループ";
            break;
        case 4:
            return @"コマとも";
            break;
        default:
            return @"その他";
            break;
    }
}

//For UITableViewDelegate
//ヘッダーの高さ
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 60.0;
            break;
        case 1:
            return 30.0;
            break;
        case 2:{
            if([_newFriends count] == 0){
                return 0;
            }else{
                return 30.0;
            }
            break;
        }
        case 3:{
            if([_groups count] == 0){
                return 0;
            }else{
                return 30.0;
            }
            break;
        }
        case 4:{
            if([_friends count] == 0){
                return 0;
            }else{
                return 30.0;
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
    CGRect windowSize = [[UIScreen mainScreen] bounds];
    UIView *headerView = [[UIView alloc]init];
    headerView.frame = CGRectMake(0, 0, windowSize.size.width, 60);
    
    if(section == 0){
        search = [[UISearchBar alloc]init];
        search.delegate = self;
        search.placeholder = @"Search";
        search.tintColor = [UIColor colorWithRed:0.796 green:0.816 blue:0.839 alpha:1.0];
        search.frame = CGRectMake(0, 0, windowSize.size.width, 60);
        search.showsCancelButton = NO;
        [headerView addSubview:search];
        headerView.backgroundColor = [UIColor colorWithRed:0.796 green:0.816 blue:0.839 alpha:1.0];
    }else{
        BasicLabel *headerLabel = [[BasicLabel alloc]initWithName: TableHeader];
        switch (section) {
            case 1:
                headerLabel.text = @"プロフィール";
                break;
            case 2:
                headerLabel.text = @"新しいコマとも";
                break;
            case 3:
                headerLabel.text = @"グループ";
                break;
            case 4:
                headerLabel.text = @"コマとも";
                break;
            default:
                break;
        }
        
        CGSize headerLabelSize = [headerLabel sizeThatFits:CGSizeZero];
        headerLabel.frame = CGRectMake( 10, 10, headerLabelSize.width, headerLabelSize.height);
        [headerView addSubview: headerLabel];
        headerView.backgroundColor = [UIColor colorWithRed:0.965 green:0.969 blue:0.973 alpha:1.0];
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
