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
        NSLog(@"とってきた情報: %@", responseObject);
        NSArray *dateComad = [responseObject objectForKey:@"date_comad"];
        NSArray *newComad = [responseObject objectForKey:@"new_comad"];
        NSArray *popularComad = [responseObject objectForKey:@"popular_comad"];
        NSArray *myComad = [responseObject objectForKey:@"my_comad"];
        
        newComadTable.NewComad = newComad;
        [newComadTable.tableView reloadData];
        dateComadTable.DateComad = dateComad;
        popularComadTable.PopularComad = popularComad;
        myComadTable.myComad = myComad;
        
        [SVProgressHUD dismiss];
        /*
         date_comad
         new_comad
        _willComads = [responseObject objectForKey:@"will"];
        _groupComad = [responseObject objectForKey:@"group"];
        _comads = [responseObject objectForKey:@"comad"];
        NSLog(@"%@",_comads);
        NSLog(@"success");
        [SVProgressHUD dismiss];
        [self reloadData];
         */
    } failure:^(int statusCode, NSString *errorString) {
        /*
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"サーバーにアクセスできません。" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
         */
        [SVProgressHUD dismiss];
    }];
}

- (void)configure {
    float iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    NSLog(@"iosVersion: %f", iOSVersion);

    newComadTable = [[NewComadViewController alloc]init];
    dateComadTable = [[DateComadViewController alloc]init];
    popularComadTable = [[PopularComadViewController alloc]init];
    myComadTable = [[MyComadViewController alloc]init];

    NSLog(@"tabbar Height: %f", self.tabBar.frame.size.height);
    NSLog(@"newComad: %f", newComadTable.view.frame.size.height);
    
   
    NSArray *tabs = [NSArray arrayWithObjects: newComadTable, dateComadTable, popularComadTable, myComadTable,nil];
    [self setViewControllers:tabs animated:NO];
}
@end
