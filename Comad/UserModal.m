//
//  UserModal.m
//  Comad
//
//  Created by 浅野 友希 on 2013/10/13.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "UserModal.h"
#import "Image.h"

@implementation UserModal
@synthesize userInfo;

- (id)initWithName:(UserModalType)name {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(25, 180, 269, 190);
        UIButton *closeModalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        closeModalBtn.backgroundColor = [UIColor whiteColor];
        UIImage *closeImage = [Image resizeImage:[UIImage imageNamed:@"close.png"] resizeWidth:10 resizeHeight:10];
        [closeModalBtn setImage:closeImage forState:UIControlStateNormal];
        closeModalBtn.frame = CGRectMake(self.frame.size.width - 20, 10, closeImage.size.width, closeImage.size.height);
        [closeModalBtn addTarget:self action:@selector(closeModalBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:closeModalBtn];
        switch (name) {
            case Friend:{
                /*
                UIButton *showUserBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                showUserBtn.backgroundColor = [UIColor colorWithRed:0.282 green:0.549 blue:0.898 alpha:1.0];
                [showUserBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                showUserBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                showUserBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
                */
                 
                UIButton *modalHomeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                UIImage *modalHomeImage = [UIImage imageNamed:@"modalHome.png"];
                UIImage *modalHomeResize = [Image resizeImage:modalHomeImage resizeWidth:89 resizeHeight:65];
                [modalHomeBtn setBackgroundImage:modalHomeResize forState:UIControlStateNormal];
                modalHomeBtn.frame = CGRectMake(0, self.frame.size.height - 65, 89, 65);
                [modalHomeBtn addTarget:self action:@selector(showUserBtnClicked) forControlEvents:UIControlEventTouchUpInside];
                
                UIButton *modalInviteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                UIImage *modalInvite = [UIImage imageNamed:@"modalInvite.png"];
                UIImage *modalInviteResize = [Image resizeImage:modalInvite resizeWidth:89 resizeHeight:65];
                [modalInviteBtn setBackgroundImage:modalInviteResize forState:UIControlStateNormal];
                modalInviteBtn.frame = CGRectMake(90, self.frame.size.height - 65, 89, 65);
                [modalInviteBtn addTarget:self action:@selector(inviteComadBtnClicked) forControlEvents:UIControlEventTouchUpInside];
                
                UIButton *sendMessageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                UIImage *backMessageImage = [UIImage imageNamed:@"modalMessage.png"];
                UIImage *backMessageResize = [Image resizeImage:backMessageImage resizeWidth:89 resizeHeight:65];
                [sendMessageBtn setBackgroundImage:backMessageResize forState:UIControlStateNormal];
                sendMessageBtn.frame = CGRectMake(180, self.frame.size.height - 65, 89, 65);
                [sendMessageBtn addTarget:self action:@selector(sendMessageBtnClicked) forControlEvents:UIControlEventTouchUpInside];
                
                [self addSubview:closeModalBtn];
                [self addSubview:modalHomeBtn];
                [self addSubview:modalInviteBtn];
                [self addSubview:sendMessageBtn];
                break;
            }
            case InAddFriend:{
                UIButton *AddFriendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                UIImage *addFriend = [UIImage imageNamed:@"modalAddFriend.png"];
                UIImage *addFriendResize = [Image resizeImage:addFriend resizeWidth:134 resizeHeight:65];
                [AddFriendBtn setBackgroundImage:addFriendResize forState:UIControlStateNormal];
                AddFriendBtn.frame = CGRectMake(135, self.frame.size.height - 65, 134, 65);
                [AddFriendBtn addTarget:self action:@selector(addFriendBtnClicked) forControlEvents:UIControlEventTouchUpInside];
                
                UIButton *BlockBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                UIImage *block = [UIImage imageNamed:@"modalBlock.png"];
                UIImage *blockResize = [Image resizeImage:block resizeWidth:134 resizeHeight:65];
                [BlockBtn setBackgroundImage:blockResize forState:UIControlStateNormal];
                BlockBtn.frame = CGRectMake(0, self.frame.size.height - 65, 134, 65);
                [BlockBtn addTarget:self action:@selector(blockBtnClicked) forControlEvents:UIControlEventTouchUpInside];
                
                [self addSubview: AddFriendBtn];
                [self addSubview: BlockBtn];
                break;
            }
            default:
                break;
        }
    }
    return self;
}

- (void)loadView {
    UIImage *thumbnailImage = [UIImage imageNamed:[userInfo objectForKey:@"image_name"]];
    UIImage *thumbnailImageResize = [Image resizeImage:thumbnailImage resizeWidth:80 resizeHeight:80];
    UIImage *cornerThumbnailImage = [Image makeCornerRoundImage:thumbnailImageResize];
    UIImageView *thumbnail = [[UIImageView alloc]initWithImage:cornerThumbnailImage];
    thumbnail.frame = CGRectMake(9, 20, 80, 80);
    [self addSubview:thumbnail];
    
    UILabel *nameText = [[UILabel alloc]init];
    UILabel *idName = [[UILabel alloc]init];
    UILabel *occupation = [[UILabel alloc]init];
    nameText.textColor = [UIColor blackColor];
    idName.textColor = [UIColor colorWithRed:0.655 green:0.655 blue:0.655 alpha:1.0];
    occupation.textColor = [UIColor colorWithRed:0.424 green:0.588 blue:0.706 alpha:1.0];
    UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W6" size:18.0f];
    UIFont *fontId = [UIFont fontWithName:@"HiraKakuProN-W3" size:14.0f];
    UIFont *fontOccupation = [UIFont fontWithName:@"HiraKakuProN-W3" size:14.0f];
    nameText.font = font;
    idName.font = fontId;
    occupation.font = fontOccupation;
    nameText.text = [userInfo objectForKey:@"name"];
    idName.text = [userInfo objectForKey:@"comad_id"];
    occupation.text = [userInfo objectForKey:@"occupation"];
    [nameText sizeToFit];
    [idName sizeToFit];
    [occupation sizeToFit];
    float width = nameText.frame.size.width;
    float height = nameText.frame.size.height;
    nameText.frame = CGRectMake(105, 30, width, height);
    idName.frame = CGRectMake(105, 52, idName.frame.size.width, idName.frame.size.height);
    occupation.frame = CGRectMake(105, 75, occupation.frame.size.width, occupation.frame.size.height);
    
    [self addSubview:nameText];
    [self addSubview:idName];
    [self addSubview:occupation];
}

- (void)closeModalBtnClicked {
    [self.delegate closeModalBtnClickedDelegate];
}

- (void)showUserBtnClicked {
    [self.delegate showUserBtnClickedDelegate];
}

- (void)inviteComadBtnClicked {
    [self.delegate inviteComadBtnClickedDelegate];
}

- (void)sendMessageBtnClicked {
    [self.delegate sendMessageBtnClickedDelegate];
}

- (void)addFriendBtnClicked {
    int userId = [[userInfo objectForKey:@"id"] intValue];
    [self.delegate addFriendBtnClickedDelegate: userId];
}

- (void)blockBtnClicked {
    [self.delegate blockBtnClickedDelegate];
}

@end
