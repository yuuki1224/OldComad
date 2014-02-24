//
//  DateComadViewController.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/28.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "DateComadViewController.h"
#import "ComadCell.h"
#import "ShowComadViewController.h"
#import "Basic.h"

@interface DateComadViewController ()
    
@end

@implementation DateComadViewController
@synthesize DateComad;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        windowSize = [[UIScreen mainScreen] bounds];
        
        // Custom initialization
        self.view.backgroundColor = [UIColor colorWithRed:0.902 green:0.890 blue:0.875 alpha:1.0];
        //self.view.frame = CGRectMake(0, 127, 380, 400);
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        if((int)iOSVersion == 7){
            self.tableView.contentInset = UIEdgeInsetsMake(133, 0, 0, 0);
        }else if((int)iOSVersion == 6){
            self.tableView.contentInset = UIEdgeInsetsMake(105, 0, 0, 0);
        }
        
        self.tableView.frame = CGRectMake(0, 133, windowSize.size.width, windowSize.size.height - 200);
        
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

- (void)viewWillAppear:(BOOL)animated {
    int count = [[DateComad objectForKey:@"now"] count] + [[DateComad objectForKey:@"today"] count] + [[DateComad objectForKey:@"tomorrow"] count] + [[DateComad objectForKey:@"day_after_tomorrow"] count] + [[DateComad objectForKey:@"any_time"] count];
    if(count == 0){
        BasicLabel *nameText = [[BasicLabel alloc]initWithName:FriendCellName];
        nameText.text = @"現在該当のコマドがありません";
        [nameText sizeToFit];
        float width = nameText.frame.size.width;
        float height = nameText.frame.size.height;
        nameText.frame = CGRectMake((SCREEN_BOUNDS.size.width - width)/2, 32 - height/2, width, height);
        [self.view addSubview: nameText];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// セルのView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ComadCell *cell = [[ComadCell alloc]initWithFrame:CGRectMake(0, 0, 380, 95)];
    switch (indexPath.section) {
        case 0:
            cell.comadInfo = [[DateComad objectForKey:@"now"] objectAtIndex:indexPath.row];
            break;
        case 1:
            cell.comadInfo = [[DateComad objectForKey:@"today"] objectAtIndex:indexPath.row];
            break;
        case 2:
            cell.comadInfo = [[DateComad objectForKey:@"tomorrow"] objectAtIndex:indexPath.row];
            break;
        case 3:
            cell.comadInfo = [[DateComad objectForKey:@"day_after_tomorrow"] objectAtIndex:indexPath.row];
            break;
        case 4:
            cell.comadInfo = [[DateComad objectForKey:@"any_time"] objectAtIndex:indexPath.row];
            break;
        default:
            break;
    }
    [cell setComadCell];
    return cell;
}

// セクションの数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

// セルの数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:{
            NSLog(@"now: %d", [[DateComad objectForKey:@"now"] count]);
            return [[DateComad objectForKey:@"now"] count];
            break;
        }
        case 1:{
            NSLog(@"today: %d", [[DateComad objectForKey:@"today"] count]);
            return [[DateComad objectForKey:@"today"] count];
            break;
        }
        case 2:{
            NSLog(@"tomorrow: %d", [[DateComad objectForKey:@"tomorrow"] count]);
            return [[DateComad objectForKey:@"tomorrow"] count];
            break;
        }
        case 3:{
            NSLog(@"day_after_tomorrow: %d", [[DateComad objectForKey:@"day_after_tomorrow"] count]);
            return [[DateComad objectForKey:@"day_after_tomorrow"] count];
            break;
        }
        case 4:{
            NSLog(@"any_time: %d", [[DateComad objectForKey:@"any_time"] count]);
            return [[DateComad objectForKey:@"any_time"] count];
            break;
        }
        default:
            return 0;
            break;
    }
    return 0;
}

// セルの高さ
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 102;
}

// ヘッダーの高さ
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:{
            break;
        }
        case 1:{
            break;
        }
        case 2:{
            break;
        }
        case 3:{
            break;
        }
        case 4:{
            break;
        }
        default:
            return 0;
            break;
    }
    return 0;
}

//フッターの高さ
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ComadCell *cell = [tableView cellForRowAtIndexPath: indexPath];
    ShowComadViewController *sc = [[ShowComadViewController alloc]init];
    sc.hidesBottomBarWhenPushed = YES;
    sc.comadInfo = cell.comadInfo;
    [self.tabBarController.navigationController pushViewController:sc animated:YES];
}

@end
