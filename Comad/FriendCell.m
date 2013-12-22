//
//  FriendCell.m
//  Comad
//
//  Created by 浅野 友希 on 2013/10/13.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "FriendCell.h"
#import "Image.h"
#import "RoundedButton.h"
#import "BasicLabel.h"
#import "Basic.h"

@implementation FriendCell
@synthesize userInfo, groupInfo;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        windowSize = [[UIScreen mainScreen] bounds];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setFriendCell:(BOOL)isNew {
    if(isNew){
        UIView *baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, windowSize.size.width, 64)];
        baseView.backgroundColor = [UIColor colorWithRed:1.000 green:0.961 blue:0.898 alpha:1.0];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImage *thumbnailImage = [UIImage imageNamed: [userInfo objectForKey:@"image_name"]];
        UIImageView *thumbnail = [[UIImageView alloc]initWithImage:thumbnailImage];
        thumbnail.frame = CGRectMake(0, 0, 64, 64);
        
        [baseView addSubview:thumbnail];
        
        BasicLabel *nameText = [[BasicLabel alloc]initWithName:FriendCellName];
        nameText.text = [userInfo objectForKey:@"name"];
        [nameText sizeToFit];
        float width = nameText.frame.size.width;
        float height = nameText.frame.size.height;
        nameText.frame = CGRectMake(75, 32 - height/2, width, height);
        [baseView addSubview: nameText];
        [self addSubview: baseView];
    }else {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        // Documents/image_name.jpgを取ってくるようにする
        NSString *imageUrl = [NSString stringWithFormat:@"%@/images/profile/%@",HOST_URL, [userInfo objectForKey:@"image_name"]];
        UIImage *thumbnailImage = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString: imageUrl]]];
        UIImageView *thumbnail = [[UIImageView alloc]initWithImage:thumbnailImage];
        thumbnail.frame = CGRectMake(0, 0, 64, 64);
        [self addSubview:thumbnail];
        BasicLabel *nameText = [[BasicLabel alloc]initWithName:FriendCellName];
        nameText.text = [userInfo objectForKey:@"name"];
        [nameText sizeToFit];
        float width = nameText.frame.size.width;
        float height = nameText.frame.size.height;
        nameText.frame = CGRectMake(75, 32 - height/2, width, height);
        [self addSubview: nameText];
    }
}

- (void)setInviteButton {
    UIImage *inviteImage = [UIImage imageNamed:@"inviteButton.png"];
    UIImageView *inviteButtonView = [[UIImageView alloc]initWithImage:inviteImage];
    inviteButtonView.frame = CGRectMake(windowSize.size.width - 70, 20, 60, 25);
    UITapGestureRecognizer *inviteButtonTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(inviteButtonTabpped:)];
    [inviteButtonView addGestureRecognizer: inviteButtonTapGesture];
    inviteButtonView.userInteractionEnabled = YES;
    [self addSubview: inviteButtonView];
}

- (void)inviteButtonTabpped:(UITapGestureRecognizer *)sender {
    [self.delegate inviteButtonClicked];
}
@end
