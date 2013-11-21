//
//  SelectPeopleTable.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/21.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "SelectPeopleTable.h"
#import "SelectPeopleTableCell.h"
#import "BasicLabel.h"

@implementation SelectPeopleTable

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        windowSize = [[UIScreen mainScreen] bounds];
        self.delegate = self;
        self.dataSource = self;
        self.allowsMultipleSelection = YES;
    }
    return self;
}

# pragma UITableViewDataSource methods
// sectionの数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// rowの数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

// セルのView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SelectPeopleTableCell *cell = [[SelectPeopleTableCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SelectPeopleUITableCell"];
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"浅野友希", @"name",
                         @"asano.png", @"image_name",nil];
    cell.userInfo = userInfo;
    [cell setImageAndName];
    
    UIView *selectedView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, windowSize.size.width, 64)];
    selectedView.backgroundColor = [UIColor grayColor];
    
    cell.selectedBackgroundView = selectedView;
    return cell;
}

// ヘッダーのView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, windowSize.size.width, 30)];
    headerView.backgroundColor = [UIColor colorWithRed:0.965 green:0.969 blue:0.973 alpha:1.0];
    BasicLabel *headerTitle = [[BasicLabel alloc]initWithName: HeaderTitle];
    [headerTitle setText:@"友達"];
    [headerTitle sizeToFit];
    headerTitle.frame = CGRectMake(10, (30 - headerTitle.frame.size.height)/2, headerTitle.frame.size.width, headerTitle.frame.size.height);
    
    [headerView addSubview: headerTitle];
    return headerView;
}

// rowの高さ
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

// headerの高さ
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

// footerの高さ
- (CGFloat)tableView:(UITableView *)tableview heightForFooterInSection:(NSInteger)section {
    return 0;
}

// タップされたら
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"count数: %d",[[self indexPathsForSelectedRows] count]);
    SelectPeopleTableCell *cell = [self indexPathForCell: indexPath];
}

@end
