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

        UIImage *idSearchImage = [UIImage imageNamed:@"addFriendTab1.png"];
        UIImage *addFriendImage = [UIImage imageNamed:@"addFriendTab2.png"];
        
        UIImageView *idSearchImageView = [[UIImageView alloc]initWithImage:idSearchImage];
        UIImageView *addFriendImageView = [[UIImageView alloc]initWithImage:addFriendImage];
        idSearchImageView.frame = CGRectMake(0, 1, 159.5, 86);
        addFriendImageView.frame = CGRectMake(160.5, 1, 159.5, 86);
        
        [self addSubview:idSearchImageView];
        [self addSubview:addFriendImageView];
        
        UITapGestureRecognizer *idSearchRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(idSearchClicked:)];
        UITapGestureRecognizer *addFriendRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addFriendClicked:)];

        [idSearchImageView addGestureRecognizer: idSearchRecognizer];
        [addFriendImageView addGestureRecognizer: addFriendRecognizer];
        idSearchImageView.userInteractionEnabled = YES;
        addFriendImageView.userInteractionEnabled = YES;
    }
    return self;
}

- (void)idSearchClicked:(UITapGestureRecognizer *)recognizer {
    [self.delegate idSearchDelegate];
}

- (void)addFriendClicked:(UITapGestureRecognizer *)recognizer {
    [self.delegate addFriendDelegate];
}

@end
