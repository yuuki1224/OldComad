//
//  ComadsViewController+View.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/28.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "ComadsViewController.h"
#import "SVProgressHUD.h"
#import "ComadJsonClient.h"
#import "Image.h"

@implementation ComadsViewController (View)
- (void)setInfo {
    [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeBlack];
    
    //ネットワーク通信してる
    [[ComadJsonClient sharedClient] getIndexWhenSuccess:^(AFHTTPRequestOperation *operation, NSHTTPURLResponse *response, id responseObject) {
        NSDictionary *dateComad = [responseObject objectForKey:@"date_comads"];
        NSArray *newComad = [responseObject objectForKey:@"new_comads"];
        NSArray *popularComad = [responseObject objectForKey:@"popular_comads"];
        NSArray *myComad = [responseObject objectForKey:@"my_comads"];
        
        newComadTable.NewComad = newComad;
        [newComadTable.tableView reloadData];
        dateComadTable.DateComad = dateComad;
        popularComadTable.PopularComad = popularComad;
        myComadTable.myComad = myComad;
        
        [SVProgressHUD dismiss];
    } failure:^(int statusCode, NSString *errorString) {
        [SVProgressHUD dismiss];
    }];
}

- (void)configure {

    newComadTable = [[NewComadViewController alloc]init];
    dateComadTable = [[DateComadViewController alloc]init];
    popularComadTable = [[PopularComadViewController alloc]init];
    myComadTable = [[MyComadViewController alloc]init];
   
    NSArray *tabs = [NSArray arrayWithObjects: newComadTable, dateComadTable, popularComadTable, myComadTable,nil];
    [self setViewControllers:tabs animated:NO];
}
@end
