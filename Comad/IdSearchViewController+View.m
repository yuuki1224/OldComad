//
//  IdSearchViewController+View.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/18.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "IdSearchViewController.h"
#import "UserJsonClient.h"
#import "Image.h"
#import "BasicLabel.h"

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
    //ここでViewをセットする
    NSString *userName = [responseObject objectForKey:@"name"];
    NSString *imageName = [responseObject objectForKey:@"image_name"];
    
    UIView *addFriendView = [[UIView alloc]init];
    addFriendView.frame = CGRectMake(0, 200, windowSize.size.width, 150);
    addFriendView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview: addFriendView];
    
    //Image
    UIImage *thumbnailImage = [UIImage imageNamed: imageName];
    UIImage *thumbnailImageResize = [Image resizeImage:thumbnailImage resizeWidth:80 resizeHeight:80];
    UIImage *cornerThumbnailImage = [Image makeCornerRoundImage:thumbnailImageResize];
    UIImageView *thumbnail = [[UIImageView alloc]initWithImage:cornerThumbnailImage];
    thumbnail.frame = CGRectMake((windowSize.size.width - 80)/2, 10, 80, 80);
    [addFriendView addSubview:thumbnail];
    
    BasicLabel *name = [[BasicLabel alloc]initWithName:ShowUserName];
    name.text = userName;
    [name sizeToFit];
    name.frame = CGRectMake((windowSize.size.width - name.frame.size.width)/2, 100, name.frame.size.width, name.frame.size.height);
    [addFriendView addSubview:name];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    NSLog(@"textFied: %@", textField.text);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [[UserJsonClient sharedClient]findUserWithComadId:^(AFHTTPRequestOperation *operation, NSHTTPURLResponse *response, id responseObject) {
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

@end
