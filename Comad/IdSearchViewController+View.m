//
//  IdSearchViewController+View.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/18.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "IdSearchViewController.h"
#import "UserJsonClient.h"
#import "FriendJsonClient.h"
#import "Image.h"
#import "BasicLabel.h"
#import "RoundedButton.h"
#import "SVProgressHUD.h"

@implementation IdSearchViewController (View)
- (void)configure {
    tv = [[UITextField alloc]init];
    tv.text = @"";
    tv.placeholder = @"友達のIDを入力してください。";
    tv.frame = CGRectMake((windowSize.size.width - 280)/2, 100, 280, 40);
    tv.clearButtonMode = UITextFieldViewModeWhileEditing;
    tv.borderStyle = UITextBorderStyleRoundedRect;
    tv.delegate = self;
    [tv becomeFirstResponder];
    
    [self.view addSubview:tv];
}

- (void)findUser:(id)responseObject {
    self.addFriendID = [[responseObject objectForKey:@"id"] intValue];
    //ここでViewをセットする
    NSString *userName = [responseObject objectForKey:@"name"];
    NSString *imageName = [responseObject objectForKey:@"image_name"];
    
    addFriendView = [[UIView alloc]init];
    addFriendView.frame = CGRectMake(0, 180, windowSize.size.width, 180);
    addFriendView.backgroundColor = [UIColor colorWithRed:0.855 green:0.886 blue:0.929 alpha:1.0];
    [self.view addSubview: addFriendView];
    
    //Image
    UIImage *thumbnailImage = [UIImage imageNamed: imageName];
    UIImage *thumbnailImageResize = [Image resizeImage:thumbnailImage resizeWidth:80 resizeHeight:80];
    UIImage *cornerThumbnailImage = [Image makeCornerRoundImage:thumbnailImageResize];
    UIImageView *thumbnail = [[UIImageView alloc]initWithImage: cornerThumbnailImage];
    thumbnail.frame = CGRectMake((windowSize.size.width - 80)/2, 10, 80, 80);
    [addFriendView addSubview:thumbnail];
    
    BasicLabel *name = [[BasicLabel alloc]initWithName:ShowUserName];
    name.backgroundColor = [UIColor colorWithRed:0.855 green:0.886 blue:0.929 alpha:1.0];
    name.text = userName;
    [name sizeToFit];
    name.frame = CGRectMake((windowSize.size.width - name.frame.size.width)/2, 100, name.frame.size.width, name.frame.size.height);
    [addFriendView addSubview:name];
    
    RoundedButton *addButton = [[RoundedButton alloc]initWithName:AddFriendInvite];
    addButton.frame = CGRectMake((windowSize.size.width - 150)/2, 135, 150, 30);
    [addButton setTitleInButton:@"追加する"];
    [addButton addTarget:self action:@selector(addButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [addFriendView addSubview:addButton];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    [addFriendView removeFromSuperview];
    
    [[UserJsonClient sharedClient]findUserWithComadId:textField.text success:^(AFHTTPRequestOperation *operation, NSHTTPURLResponse *response, id responseObject) {
        NSLog(@"comad user: %@", responseObject);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self findUser:responseObject];
    } failure:^(int statusCode, NSString *errorString) {
        NSLog(@"failed");
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
    
    [tv resignFirstResponder];
    return YES;
}

-(void)addButtonClicked:(UIButton *)button {
    [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeBlack];
    [[FriendJsonClient sharedClient]addFriend:10 friendId:self.addFriendID success:^(AFHTTPRequestOperation *operation, NSHTTPURLResponse *response, id responseObject) {
        [SVProgressHUD dismiss];
        UIAlertView *alert = [[UIAlertView alloc]init];
        alert.delegate = self;
        alert.title = @"お知らせ";
        alert.message = @"友達を追加しました";
        [alert addButtonWithTitle:@"閉じる"];
        [alert show];
    } failure:^(int statusCode, NSString *errorString) {
        NSLog(@"失敗!");
        [SVProgressHUD dismiss];
        UIAlertView *alert = [[UIAlertView alloc]init];
        alert.title = @"お知らせ";
        alert.message = @"友達追加に失敗しました。";
        [alert addButtonWithTitle:@"閉じる"];
        [alert show];
    }];
}

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
