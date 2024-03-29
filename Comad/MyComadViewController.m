//
//  MyComadViewController.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/28.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "MyComadViewController.h"
#import "ComadCell.h"
#import "ShowComadViewController.h"
#import "Basic.h"

@interface MyComadViewController ()

@end

@implementation MyComadViewController

@synthesize myComad;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        
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

- (void)viewWillAppear:(BOOL)animated {
    if([myComad count] == 0){
        BasicLabel *nameText = [[BasicLabel alloc]initWithName:FriendCellName];
        nameText.text = @"現在該当のコマドがありません";
        [nameText sizeToFit];
        float width = nameText.frame.size.width;
        float height = nameText.frame.size.height;
        nameText.frame = CGRectMake((SCREEN_BOUNDS.size.width - width)/2, 32 - height/2, width, height);
        [self.view addSubview: nameText];
    }
}

// セルのView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ComadCell *cell = [[ComadCell alloc]initWithFrame:CGRectMake(0, 0, 380, 95)];
    cell.comadInfo = [myComad objectAtIndex:indexPath.row];
    [cell setComadCell];
    return cell;
}

// セクションの数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// セルの数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [myComad count];
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
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ComadCell *cell = [tableView cellForRowAtIndexPath: indexPath];
    ShowComadViewController *sc = [[ShowComadViewController alloc]init];
    sc.hidesBottomBarWhenPushed = YES;
    sc.comadInfo = cell.comadInfo;
    [self.tabBarController.navigationController pushViewController:sc animated:YES];
}

@end
