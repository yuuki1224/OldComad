//
//  Friends.m
//  Comad
//
//  Created by 浅野 友希 on 2013/10/12.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "Friends.h"
#import "FriendCell.h"
#import "Image.h"
#import "SVProgressHUD.h"
#import "FriendJsonClient.h"

@interface Friends () {
}

@end

@implementation Friends

@synthesize me = _me;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
   
        [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeBlack];
        
        [[FriendJsonClient sharedClient] getIndexWhenSuccess:^(AFHTTPRequestOperation *operation, NSHTTPURLResponse *response, id responseObject) {
            NSDictionary *me = [responseObject objectForKey:@"me"];
            
            _me = me;
            _newFriends = [responseObject objectForKey:@"new"];
            _friends = [responseObject objectForKey:@"friends"];
            _groups = [responseObject objectForKey:@"groups"];
          
            NSLog(@"success");
            [SVProgressHUD dismiss];
            [self reloadData];
        } failure:^(int statusCode, NSString *errorString) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:errorString message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [SVProgressHUD dismiss];
        }];
        
        self.dataSource = self;
        CGRect windowSize = [[UIScreen mainScreen] bounds];
        self.frame = CGRectMake(0, 78, windowSize.size.width, windowSize.size.height - 127);
    }
    return self;
}

//For tableViewDataSource
//セクションの中のセルの数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
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
        cell.userInfo = _me;
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

@end
