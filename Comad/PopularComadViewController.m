//
//  PopularComadViewController.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/28.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "PopularComadViewController.h"
#import "ComadCell.h"
#import "ShowComadViewController.h"

@interface PopularComadViewController ()

@end

@implementation PopularComadViewController
@synthesize PopularComad;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        // Custom initialization
        self.view.backgroundColor = [UIColor colorWithRed:0.902 green:0.890 blue:0.875 alpha:1.0];
        self.view.frame = CGRectMake(0, 127, 380, 400);
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.contentInset = UIEdgeInsetsMake(133, 0, 0, 0);
        
        if((int)iOSVersion == 7){
            self.tableView.contentInset = UIEdgeInsetsMake(133, 0, 0, 0);
        }else if((int)iOSVersion == 6){
            self.tableView.contentInset = UIEdgeInsetsMake(105, 0, 0, 0);
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// セルのView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ComadCell *cell = [[ComadCell alloc]initWithFrame:CGRectMake(0, 0, 380, 95)];
    cell.comadInfo = [PopularComad objectAtIndex:indexPath.row];
    [cell setComadCell];
    return cell;
}

// セクションの数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// セルの数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [PopularComad count];
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
    ShowComadViewController *sc = [[ShowComadViewController alloc]init];
    sc.hidesBottomBarWhenPushed = YES;
    [self.tabBarController.navigationController pushViewController:sc animated:YES];
}
@end
