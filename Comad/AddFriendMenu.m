//
//  AddFriendMenu.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/17.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "AddFriendMenu.h"
#import "Image.h"
#import "BasicLabel.h"

@implementation AddFriendMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        windowSize = [[UIScreen mainScreen] bounds];
        self.frame = CGRectMake(0, 77, windowSize.size.width, 87);
        self.backgroundColor = [UIColor whiteColor];
        UIView *idSearch = [[UIView alloc]initWithFrame:CGRectMake(0, 1, 106, 86)];
        UIView *qrCode = [[UIView alloc]initWithFrame:CGRectMake(107, 1, 106, 86)];
        UIView *addFriend = [[UIView alloc]initWithFrame:CGRectMake(214, 1, 106, 86)];
        idSearch.backgroundColor = [UIColor colorWithRed:0.282 green:0.549 blue:0.898 alpha:1.0];
        qrCode.backgroundColor = [UIColor colorWithRed:0.282 green:0.549 blue:0.898 alpha:1.0];
        addFriend.backgroundColor = [UIColor colorWithRed:0.282 green:0.549 blue:0.898 alpha:1.0];

        UIImage *idSearchImage = [Image resizeImage:[UIImage imageNamed:@"idSearchMenu.png"] resizeWidth:32 resizeHeight:32];
        UIImage *qrCodeImage = [Image resizeImage:[UIImage imageNamed:@"qrCodeMenu.png"] resizeWidth:64 resizeHeight:64];
        UIImage *addFriendImage = [Image resizeImage:[UIImage imageNamed:@"addFriendMenu.png"] resizeWidth:64 resizeHeight:64];
        
        UIImageView *idSearchImageView = [[UIImageView alloc]initWithImage:idSearchImage];
        UIImageView *qrCodeImageView = [[UIImageView alloc]initWithImage:qrCodeImage];
        UIImageView *addFriendImageView = [[UIImageView alloc]initWithImage:addFriendImage];
        idSearchImageView.frame = CGRectMake(37, 15, 32, 32);
        qrCodeImageView.frame = CGRectMake(37, 15, 32, 32);
        addFriendImageView.frame = CGRectMake(37, 15, 32, 32);
        
        [idSearch addSubview:idSearchImageView];
        [qrCode addSubview:qrCodeImageView];
        [addFriend addSubview:addFriendImageView];
        
        //Label
        BasicLabel *idSearchLabel = [[BasicLabel alloc]initWithName: AddFriendMenuLabel];
        BasicLabel *qrCodeLabel = [[BasicLabel alloc]initWithName: AddFriendMenuLabel];
        BasicLabel *addFriendLabel = [[BasicLabel alloc]initWithName: AddFriendMenuLabel];
        [idSearchLabel setText:@"ID検索"];
        [qrCodeLabel setText:@"QRコード"];
        [addFriendLabel setText:@"友達追加"];
        
        [idSearchLabel sizeToFit];
        [qrCodeLabel sizeToFit];
        [addFriendLabel sizeToFit];
        
        idSearchLabel.frame = CGRectMake((106 - idSearchLabel.frame.size.width)/2, 55, idSearchLabel.frame.size.width, idSearchLabel.frame.size.height);
        qrCodeLabel.frame = CGRectMake((106 - qrCodeLabel.frame.size.width)/2, 55, qrCodeLabel.frame.size.width, qrCodeLabel.frame.size.height);
        addFriendLabel.frame = CGRectMake((106 - addFriendLabel.frame.size.width)/2, 55, addFriendLabel.frame.size.width, addFriendLabel.frame.size.height);
        
        [idSearch addSubview:idSearchLabel];
        [qrCode addSubview:qrCodeLabel];
        [addFriend addSubview:addFriendLabel];
        
        [self addSubview:idSearch];
        [self addSubview:qrCode];
        [self addSubview:addFriend];
        
        UITapGestureRecognizer *idSearchRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(idSearchClicked:)];
        UITapGestureRecognizer *qrCodeRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(qrCodeClicked:)];
        UITapGestureRecognizer *addFriendRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addFriendClicked:)];

        [idSearch addGestureRecognizer: idSearchRecognizer];
        [qrCode addGestureRecognizer: qrCodeRecognizer];
        [addFriend addGestureRecognizer: addFriendRecognizer];
    }
    return self;
}

- (void)idSearchClicked:(UITapGestureRecognizer *)recognizer {
    [self.delegate idSearchDelegate];
}

- (void)qrCodeClicked:(UITapGestureRecognizer *)recognizer {
    [self.delegate qrCodeDelegate];
}

- (void)addFriendClicked:(UITapGestureRecognizer *)recognizer {
    [self.delegate addFriendDelegate];
}

@end
