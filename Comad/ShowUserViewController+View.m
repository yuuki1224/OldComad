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

@implementation ShowUserViewController (View)

- (void)configure {
    float iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    scrollView = [[UIScrollView alloc]init];
    if(iOSVersion == 7.00){
        scrollView.frame = CGRectMake(0, 77, windowSize.size.width, windowSize.size.height - 77);
    }else{
        scrollView.frame = CGRectMake(0, 77, windowSize.size.width, windowSize.size.height);
    }
    scrollView.contentSize = CGSizeMake(windowSize.size.width, 610);
    [self.view addSubview: scrollView];
    
    nameLabel = [[BasicLabel alloc]initWithName:ShowUserName];
    userIdLabel = [[BasicLabel alloc]initWithName:ShowUserComadId];
    occupationLabel = [[BasicLabel alloc]initWithName:ShowUserOccupation];
    
    [scrollView addSubview: nameLabel];
    [scrollView addSubview: userIdLabel];
    [scrollView addSubview:occupationLabel];
    
    showUserList = [[ShowUserList alloc]initWithFrame:CGRectMake(0, 236, windowSize.size.width, 82)];
    [scrollView addSubview: showUserList];
    [showUserList setTitle:@"プロフィール"];
    
    question1 = [[ShowUserList alloc]initWithFrame:CGRectMake(0, 319, windowSize.size.width, 82)];
    [question1 setTitle:@"よくノマドする地域は？"];
    [scrollView addSubview:question1];
    
    question2 = [[ShowUserList alloc]initWithFrame:CGRectMake(0, 401, windowSize.size.width, 82)];
    [question2 setTitle:@"好きな言語は？"];
    [scrollView addSubview:question2];
    
    question3 = [[ShowUserList alloc]initWithFrame:CGRectMake(0, 483, windowSize.size.width, 82)];
    [question3 setTitle:@"使えるAdobe製品は？"];
    [scrollView addSubview:question3];
    
    question4 = [[ShowUserList alloc]initWithFrame:CGRectMake(0, 565, windowSize.size.width, 82)];
    [question4 setTitle:@"使ってるエディターは？"];
    [scrollView addSubview:question4];
}

-(void)reloadLabel {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userInfo = [userDefaults valueForKey:@"user"];
    
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
    
    UIImage *thumbnailImage = [UIImage imageNamed:[self.userInfo objectForKey:@"image_name"]];
    UIImage *thumbnailImageResize = [Image resizeImage:thumbnailImage resizeWidth:78 resizeHeight:78];
    UIImage *cornerThumbnail = [Image makeCornerRoundImage:thumbnailImageResize];
    UIImageView *thumbnail = [[UIImageView alloc]initWithImage:cornerThumbnail];
    thumbnail.frame = CGRectMake(windowSize.size.width/2 - 39, 16, 78, 78);
    thumbnail.layer.cornerRadius = 14.0f;
    
    [scrollView addSubview:thumbnail];
    
    if(self.me){
        //マイページ
        UIButton *editProfileBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [editProfileBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [editProfileBtn setFont:[UIFont fontWithName:@"HiraKakuProN-W3" size:12.0f]];
        [editProfileBtn setTitle:@"プロフィール編集" forState:UIControlStateNormal];
        editProfileBtn.frame = CGRectMake(windowSize.size.width/2 - 56, 190, 113, 29);
        editProfileBtn.backgroundColor = [UIColor colorWithRed:0.49 green:0.686 blue:0.937 alpha:1.0];
        [[editProfileBtn layer]setCornerRadius:5.0];
        [editProfileBtn setClipsToBounds:YES];
        [editProfileBtn addTarget:self action:@selector(editProfileBtnClicked:)forControlEvents:UIControlEventTouchUpInside];
        
        //[btn setImage:buttonImage forState:UIControlStateNormal];
        [scrollView addSubview:editProfileBtn];
        
        [showUserList setContent:[self.userInfo objectForKey:@"description"]];
        
        [question1 setContent:[userInfo objectForKey:@"question1"]];
        [question2 setContent:[userInfo objectForKey:@"question2"]];
        [question3 setContent:[userInfo objectForKey:@"question3"]];
        [question4 setContent:[userInfo objectForKey:@"question4"]];
    }else{
        UIButton *inviteComadBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        UIButton *sendMessageBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [inviteComadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sendMessageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [inviteComadBtn setFont:[UIFont fontWithName:@"HiraKakuProN-W3" size:12.0f]];
        [sendMessageBtn setFont:[UIFont fontWithName:@"HiraKakuProN-W3" size:12.0f]];
        
        [inviteComadBtn setTitle:@"コマドに誘う" forState:UIControlStateNormal];
        [sendMessageBtn setTitle:@"メッセージ" forState:UIControlStateNormal];
        inviteComadBtn.frame = CGRectMake(36, 190, 113, 29);
        sendMessageBtn.frame = CGRectMake(172, 190, 113, 29);
        
        inviteComadBtn.backgroundColor = [UIColor colorWithRed:0.49 green:0.686 blue:0.937 alpha:1.0];
        sendMessageBtn.backgroundColor = [UIColor colorWithRed:0.612 green:0.757 blue:0.937 alpha:1.0];
        
        [[inviteComadBtn layer]setCornerRadius:5.0];
        [[sendMessageBtn layer]setCornerRadius:5.0];
        [inviteComadBtn setClipsToBounds:YES];
        [sendMessageBtn setClipsToBounds:YES];
        
        [inviteComadBtn addTarget:self action:@selector(inviteBtnClicked:)forControlEvents:UIControlEventTouchUpInside];
        [sendMessageBtn addTarget:self action:@selector(sendMessageBtnClicked:)forControlEvents:UIControlEventTouchUpInside];
        
        //[btn setImage:buttonImage forState:UIControlStateNormal];
        [scrollView addSubview:inviteComadBtn];
        [scrollView addSubview:sendMessageBtn];
        
        [showUserList setContent:[self.userInfo objectForKey:@"description"]];
        
        [question1 setContent:[self.userInfo objectForKey:@"question1"]];
        [question2 setContent:[self.userInfo objectForKey:@"question2"]];
        [question3 setContent:[self.userInfo objectForKey:@"question3"]];
        [question4 setContent:[self.userInfo objectForKey:@"question4"]];
    }
}
@end
