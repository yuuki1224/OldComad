//
//  MessagesListViewController+View.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/06.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "MessagesListViewController.h"
#import "MessageViewController.h"
#import "Image.h"

@implementation MessagesListViewController (View)

- (void)configure {
    messageListView = [[UITableView alloc]initWithFrame:CGRectMake(0, 77, windowSize.size.width, windowSize.size.height - 77) style:UITableViewStylePlain];
    if((int)iOSVersion == 6){
        messageListView.frame = CGRectMake(0, 48, windowSize.size.width, windowSize.size.height - 48);
    }
    [self.view addSubview: messageListView];
    messageListView.dataSource = self;
    messageListView.delegate = self;
}

//Rowの数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [friendsArray count];
}

//セクションの数
-(NSInteger)numberOfSectionsInTableView: (UITableView *)tableView {
    return 1;
}

//セルの高さ
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

//ヘッダーの高さ
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

//フッターの高さ
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

//ヘッダーの内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc]init];
    return header;
}

//セルの内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"a"];
    UIImage *thumbnailImage = [UIImage imageNamed: [[friendsArray objectAtIndex:indexPath.row] objectForKey:@"image_name"]];
    UIImage *thumbnailImageResize = [Image resizeImage:thumbnailImage resizeWidth:60 resizeHeight:60];
    
    cell.imageView.image = thumbnailImageResize;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14.0f];
    cell.detailTextLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14.0f];

    cell.textLabel.text = [[friendsArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [friendsArray objectAtIndex:indexPath.row];
    
    MessageViewController *mc = [[MessageViewController alloc]init];
    mc.type = PrivateMessage;
    mc.friendId = [[[friendsArray objectAtIndex:indexPath.row] objectForKey:@"id"] intValue];
    [self.navigationController pushViewController:mc animated:YES];
}

@end
