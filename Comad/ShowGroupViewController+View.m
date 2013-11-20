//
//  ShowGroupViewController+View.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/05.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "ShowGroupViewController.h"
#import "FriendCell.h"
#import "Image.h"

@implementation ShowGroupViewController (View)
-(void)configure {
    NSLog(@"wififiiiii");
    UITableView *locationStatusTable = [[UITableView alloc]init];
    locationStatusTable.frame = CGRectMake(0, 77, windowSize.size.width, windowSize.size.height - 77);
    locationStatusTable.dataSource = self;
    locationStatusTable.delegate = self;
    
    [self.view addSubview:locationStatusTable];
}

//Rowの数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return 10;
    }else if(section == 1){
        return 0;
    }
    return 0;
}

#pragma UITableViewDataSource methods
//セクションの数
-(NSInteger)numberOfSectionsInTableView: (UITableView *)tableView {
    return 2;
}

//セルの高さ
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64.0;
}

//ヘッダーの高さ
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 0){
        return 100;
    }else if(section == 1){
        return 0;
    }
    return 50;
}

//ヘッダーの内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc]init];
    header.backgroundColor = [UIColor colorWithRed:0.894 green:0.902 blue:0.906 alpha:1.0];
    UIImage *thumbnailImage = [UIImage imageNamed:@"picola.png"];
    UIImage *thumbnailImageResize = [Image resizeImage:thumbnailImage resizeWidth:70 resizeHeight:70];
    UIImageView *thumbnail = [[UIImageView alloc]initWithImage:thumbnailImageResize];
    thumbnail.backgroundColor = [UIColor whiteColor];
    thumbnail.frame = CGRectMake(20, 15, 70, 70);
    [header addSubview:thumbnail];
    
    return header;
}

//セルの内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendCell *cell = [[FriendCell alloc]init];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"浅野友希", @"name",
                         @"asano.png", @"image_name", nil];
    cell.userInfo = dic;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14.0f];
    cell.detailTextLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14.0f];
    [cell setFriendCell:NO];
    return cell;
}

@end
