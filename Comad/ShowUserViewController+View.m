//
//  ShowUserViewController+View.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/15.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "ShowUserViewController.h"
#import "ShowUserList.h"
#import "BasicLabel.h"
#import "Image.h"
#import "MessageViewController.h"
#import "EditProfileViewController.h"

@implementation ShowUserViewController (View)

- (void)configure {
    iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    scrollView = [[UIScrollView alloc]init];
    if((int)iOSVersion == 7){
        scrollView.frame = CGRectMake(0, 77, windowSize.size.width, windowSize.size.height - 77);
        scrollView.contentSize = CGSizeMake(windowSize.size.width, 640);
    }else if((int)iOSVersion == 6){
        scrollView.frame = CGRectMake(0, 48, windowSize.size.width, windowSize.size.height);
        scrollView.contentSize = CGSizeMake(windowSize.size.width, 500);
    }
    [self.view addSubview: scrollView];
    
    nameLabel = [[BasicLabel alloc]initWithName:ShowUserName];
    userIdLabel = [[BasicLabel alloc]initWithName:ShowUserComadId];
    occupationLabel = [[BasicLabel alloc]initWithName:ShowUserOccupation];
    
    [scrollView addSubview: nameLabel];
    [scrollView addSubview: userIdLabel];
    [scrollView addSubview:occupationLabel];
    
    showUserList = [[ShowUserList alloc]initWithFrame:CGRectMake(0, 236, windowSize.size.width, 82)];
    [scrollView addSubview: showUserList];
    [showUserList setTitle:@"ひとこと"];
    
    question1 = [[ShowUserList alloc]initWithFrame:CGRectMake(0, 319, windowSize.size.width, 82)];
    [question1 setTitle:@"所属"];
    [scrollView addSubview:question1];
    
}

-(void)reloadLabel {
    iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userInfo = [userDefaults valueForKey:@"user"];
 
    //名前, comadId, 職業の設定
    if(self.me){
        nameLabel.text = [userInfo objectForKey:@"name"];
        
        if([[userInfo objectForKey:@"comadId"] isEqualToString:@""]){
            userIdLabel.text = @"コマドIDは設定されていません。";
        }else{
            userIdLabel.text = [userInfo objectForKey:@"comadId"];
        }
        occupationLabel.text = [userInfo objectForKey:@"occupation"];
    
        [nameLabel sizeToFit];
        [userIdLabel sizeToFit];
        [occupationLabel sizeToFit];
    
        nameLabel.frame = CGRectMake(windowSize.size.width/2 - nameLabel.frame.size.width/2, 115, nameLabel.frame.size.width, nameLabel.frame.size.height);
        userIdLabel.frame = CGRectMake(windowSize.size.width/2 - userIdLabel.frame.size.width/2, 140, userIdLabel.frame.size.width, userIdLabel.frame.size.height);
        occupationLabel.frame = CGRectMake(windowSize.size.width/2 - occupationLabel.frame.size.width/2, 160, occupationLabel.frame.size.width, occupationLabel.frame.size.height);
    }else{
        nameLabel.text = [self.userInfo objectForKey:@"name"];
        if([[self.userInfo objectForKey:@"comad_id"] isEqualToString:@""]){
            userIdLabel.text = @"コマドIDは設定されていません。";
        }else{
            userIdLabel.text = [self.userInfo objectForKey:@"comad_id"];
        }
        occupationLabel.text = [self.userInfo objectForKey:@"occupation"];
        
        [nameLabel sizeToFit];
        [userIdLabel sizeToFit];
        [occupationLabel sizeToFit];
        
        nameLabel.frame = CGRectMake(windowSize.size.width/2 - nameLabel.frame.size.width/2, 115, nameLabel.frame.size.width, nameLabel.frame.size.height);
        userIdLabel.frame = CGRectMake(windowSize.size.width/2 - userIdLabel.frame.size.width/2, 140, userIdLabel.frame.size.width, userIdLabel.frame.size.height);
        occupationLabel.frame = CGRectMake(windowSize.size.width/2 - occupationLabel.frame.size.width/2, 160, occupationLabel.frame.size.width, occupationLabel.frame.size.height);
        
    }
    
    //サムネイル
    UIImage *thumbnailImage = [UIImage imageNamed:[self.userInfo objectForKey:@"image_name"]];
    UIImage *cornerThumbnail = [Image makeCornerRoundImage:thumbnailImage];
    UIImageView *thumbnail = [[UIImageView alloc]initWithImage:cornerThumbnail];
    
    //ここの分岐がいるのか
    if((int)iOSVersion == 7){
        thumbnail.frame = CGRectMake(windowSize.size.width/2 - 39, 16, 78, 78);
    }else if((int)iOSVersion == 6){
        thumbnail.frame = CGRectMake(windowSize.size.width/2 - 39, 16, 78, 78);
    }
    thumbnail.layer.cornerRadius = 14.0f;
    
    [scrollView addSubview:thumbnail];
    
    //それぞれのボタンの設定
    if(self.me){
        //マイページ
        UIImage *editProfileImage = [UIImage imageNamed:@"editProfileBtn.png"];
        UIImageView *editProfileBtn = [[UIImageView alloc]initWithImage:editProfileImage];

        editProfileBtn.frame = CGRectMake((windowSize.size.width - 126)/2, 183, 126, 32.5);
        UITapGestureRecognizer *editProfileTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(editProfileBtnClicked:)];
        [editProfileBtn addGestureRecognizer: editProfileTapGesture];
        editProfileBtn.userInteractionEnabled = YES;
        
        [scrollView addSubview: editProfileBtn];
         
        [showUserList setContent:[self.userInfo objectForKey:@"description"]];
        
        [question1 setContent:[userInfo objectForKey:@"question1"]];
        [question2 setContent:[userInfo objectForKey:@"question2"]];
    }else{
        UIImage *messageImage = [UIImage imageNamed:@"messageButton.png"];
        UIImageView *messageBtn = [[UIImageView alloc]initWithImage:messageImage];
        messageBtn.frame = CGRectMake((windowSize.size.width - 116)/2, 183, 116, 32.5);
        UITapGestureRecognizer *messageTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(messageBtnClicked:)];
        [messageBtn addGestureRecognizer:messageTapGesture];
        messageBtn.userInteractionEnabled = YES;
        
        [scrollView addSubview: messageBtn];
        [showUserList setContent:[self.userInfo objectForKey:@"description"]];
        
        [question1 setContent:[self.userInfo objectForKey:@"question1"]];
        [question2 setContent:[self.userInfo objectForKey:@"question2"]];
    }
}

- (void)editProfileBtnClicked:(UITapGestureRecognizer *)sender {
    EditProfileViewController *ec = [[EditProfileViewController alloc]init];
    [self.navigationController pushViewController:ec animated:YES];
}

@end
