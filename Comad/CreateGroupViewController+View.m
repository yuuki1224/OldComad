//
//  CreateGroupViewController+View.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/18.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "CreateGroupViewController.h"
#import "Image.h"
#import "EditThumbnailMask.h"
#import "BasicLabel.h"
#import "RoundedButton.h"
#import "Image.h"
#import "SelectPeopleView.h"
#import <QuartzCore/QuartzCore.h>

@implementation CreateGroupViewController (View)

- (void)configure {
    UIImage *thumbnailImage = [UIImage imageNamed:@"asano.png"];
    UIImage *thumbnailImageResize = [Image resizeImage:thumbnailImage resizeWidth:80 resizeHeight:80];
    UIImageView *thumbnail = [[UIImageView alloc]initWithImage:thumbnailImageResize];
    thumbnail.frame = CGRectMake(0, 0, 80, 80);
    EditThumbnailMask *mask = [[EditThumbnailMask alloc]init];
    mask.frame = CGRectMake(0, (thumbnail.frame.size.height - 20), 80, 20);
    
    BasicLabel *maskLabel = [[BasicLabel alloc]initWithName:EditThumbnailMaskLabel];
    maskLabel.text = @"編集";
    [maskLabel sizeToFit];
    maskLabel.frame = CGRectMake((80 - maskLabel.frame.size.width)/2, 63, maskLabel.frame.size.width, maskLabel.frame.size.height);
    
    [thumbnail addSubview:mask];
    [thumbnail addSubview:maskLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
    [thumbnail setUserInteractionEnabled:YES];
    [thumbnail addGestureRecognizer:tap];
    
    BasicLabel *groupName = [[BasicLabel alloc]initWithName:GroupNameLabel];
    groupName.text = @"グループ名";
    [groupName sizeToFit];
    groupName.frame = CGRectMake(100, 20, groupName.frame.size.width, groupName.frame.size.height);
    
    tv = [[UITextField alloc]init];
    tv.text = @"";
    tv.placeholder = @"";
    tv.frame = CGRectMake(100, 42, 200, 30);
    tv.clearButtonMode = UITextFieldViewModeWhileEditing;
    tv.borderStyle = UITextBorderStyleRoundedRect;
    tv.delegate = self;
    [tv becomeFirstResponder];
    
    UIView *editGroup = [[UIView alloc]initWithFrame:CGRectMake(-1, 76, windowSize.size.width + 2, 80)];
    editGroup.backgroundColor = [[UIColor alloc]initWithRed:0.855 green:0.886 blue:0.929 alpha:1.0];
    [editGroup addSubview: tv];
    [editGroup addSubview: groupName];
    [editGroup addSubview: thumbnail];
    [self.view addSubview: editGroup];
        
    editGroup.layer.borderColor = [UIColor whiteColor].CGColor;
    editGroup.layer.borderWidth = 1.0f;

    addFriendIntoGroup = [[UIView alloc]initWithFrame:CGRectMake(0, 156, windowSize.size.width, 80)];
    addFriendIntoGroup.backgroundColor = [[UIColor alloc]initWithRed:0.855 green:0.886 blue:0.929 alpha:1.0];
    [self.view addSubview: addFriendIntoGroup];
    
    BasicLabel *memberName = [[BasicLabel alloc]initWithName:GroupNameLabel];
    memberName.text = @"メンバー";
    [memberName sizeToFit];
    memberName.frame = CGRectMake(10, 10, memberName.frame.size.width, memberName.frame.size.height);
    [addFriendIntoGroup addSubview:memberName];
    
    UIImage *addMember = [UIImage imageNamed: @"addInCreateGroup.png"];
    UIImage *addMemberResize = [Image resizeImage:addMember resizeWidth:30 resizeHeight:30];
    UIImageView *addMemberView = [[UIImageView alloc]initWithImage: addMemberResize];
    addMemberView.frame = CGRectMake(windowSize.size.width - 50, 25, 30, 30);
    
    [addFriendIntoGroup addSubview: addMemberView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addFriendTapped:)];
    [addMemberView setUserInteractionEnabled:YES];
    [addMemberView addGestureRecognizer: tapGesture];
}

- (void)tapped:(UITapGestureRecognizer *)sender {
}

- (void)addFriendTapped:(UITapGestureRecognizer *)sender {
    [tv resignFirstResponder];
    //一番上にUIViewを追加する。これだけでok
    selectPeopleView = [[SelectPeopleView alloc]init];
    selectPeopleView.delegate = self;
    [self.view addSubview: selectPeopleView];
    
    RoundedButton *name = [[RoundedButton alloc]initWithName: AddFriendInCreateGroup];
    NSString *nameString = @"村田温美";
    CGSize bounds = CGSizeMake(500, 500);
    UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W3"size:11];
    UILineBreakMode mode = UILineBreakModeWordWrap;
    CGSize size = [nameString sizeWithFont:font forWidth:bounds.width lineBreakMode:mode];

    [name setName:@"村田温美"];
    name.frame = CGRectMake(memberLabelWidth, memberLabelHeight, size.width + 16, 20);
    [addFriendIntoGroup addSubview: name];
    if(memberLabelWidth > 200){
        memberLabelWidth = 10;
        memberLabelHeight += 27;
        if(memberLabelHeight > 40){
            addFriendIntoGroup.frame = CGRectMake(0, 156, windowSize.size.width, 120);
        }
    }else{
        memberLabelWidth += (size.width + 20);
    }
}

@end
