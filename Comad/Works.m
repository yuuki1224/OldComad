//
//  Works.m
//  Comad
//
//  Created by 浅野 友希 on 2013/10/13.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "Works.h"
#import "ComadCell.h"
#import "SVProgressHUD.h"
#import "ComadJsonClient.h"

@implementation Works

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeBlack];
        
        //ネットワーク通信してる
        [[ComadJsonClient sharedClient] getIndexWhenSuccess:^(AFHTTPRequestOperation *operation, NSHTTPURLResponse *response, id responseObject) {
            _willComads = [responseObject objectForKey:@"will"];
            _groupComad = [responseObject objectForKey:@"group"];
            _comads = [responseObject objectForKey:@"comad"];
            NSLog(@"%@",_comads);
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
            return [_willComads count];
            break;
        case 1:
            return [_groupComad count];
            break;
        case 2:
            return [_comads count];
            break;
        default:
            return 0;
            break;
    }
}

//セルの内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ComadCell *cell = [[ComadCell alloc]init];
    
    if(indexPath.section == 0){
        cell.comadInfo = [_willComads objectAtIndex:indexPath.row];
        [cell setComadCell];
    }else if(indexPath.section == 1){
        cell.comadInfo = [_groupComad objectAtIndex:indexPath.row];
        [cell setComadCell];
    }else if(indexPath.section == 2){
        cell.comadInfo = [_comads objectAtIndex:indexPath.row];
        [cell setComadCell];
    }
    return  cell;
}

//セクションの数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

//セクションのヘッダーのタイトル
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"参加予定のコマド";
            break;
        case 1:
            return @"グループコマド";
            break;
        case 2:
            return @"普通のコマド";
            break;
        default:
            return @"その他";
            break;
    }
}

@end
