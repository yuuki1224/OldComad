//
//  NewComadViewController.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/28.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "NewComadViewController.h"
#import "ComadCell.h"
#import "ShowComadViewController.h"

@interface NewComadViewController ()

@end

@implementation NewComadViewController
@synthesize NewComad;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        windowSize = [[UIScreen mainScreen] bounds];
        iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        
        self.view.backgroundColor = [UIColor colorWithRed:0.902 green:0.890 blue:0.875 alpha:1.0];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        if((int)iOSVersion == 7){
            self.tableView.contentInset = UIEdgeInsetsMake(113, 0, 0, 0);
        }else if((int)iOSVersion == 6){
            self.tableView.contentInset = UIEdgeInsetsMake(105, 0, 0, 0);
        }
        self.tableView.frame = CGRectMake(0, 133, windowSize.size.width, windowSize.size.height - 200);
        sc = [[ShowComadViewController alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //self.tableView.frame = CGRectMake(0, 0, 300, 600);
    //self.tableView.contentSize = CGSizeMake(300, 400);
}

- (void)viewWillAppear:(BOOL)animated {
    if([NewComad count] == 0){
        BasicLabel *nameText = [[BasicLabel alloc]initWithName:FriendCellName];
        nameText.text = @"現在該当のコマドがありません";
        [nameText sizeToFit];
        float width = nameText.frame.size.width;
        float height = nameText.frame.size.height;
        nameText.frame = CGRectMake((windowSize.size.width - width)/2, 32 - height/2, width, height);
        [self.view addSubview: nameText];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Delegate
// セルのView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ComadCell *cell = [[ComadCell alloc]initWithFrame:CGRectMake(0, 0, 380, 95)];
    cell.comadInfo = [NewComad objectAtIndex:indexPath.row];
    [cell setComadCell];
    return cell;
}

// セクションの数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// セルの数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [NewComad count];
}

// セルの高さ
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 102;
}

// ヘッダーの高さ
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

//フッターの高さ
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ComadCell *cell = [tableView cellForRowAtIndexPath: indexPath];
    sc.hidesBottomBarWhenPushed = YES;
    sc.comadInfo = cell.comadInfo;
    [self.tabBarController.navigationController pushViewController:sc animated:YES];
}

@end
