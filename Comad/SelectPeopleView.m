//
//  SelectPeopleView.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/21.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "SelectPeopleView.h"
#import "SelectPeopleTable.h"
#import "BasicLabel.h"
#import "RoundedButton.h"

@implementation SelectPeopleView
@synthesize table;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        windowSize = [[UIScreen mainScreen] bounds];
        self.frame = CGRectMake(0, 0, windowSize.size.width, windowSize.size.height);
        [self setHeader];
        [self setSearchBar];
        [self setTable];
        [self setFooter];
    }
    return self;
}

- (void)setHeader {
    //ヘッダー
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, windowSize.size.width, 77)];
    header.backgroundColor = [UIColor colorWithRed:0.176 green:0.220 blue:0.286 alpha:1.0];
    BasicLabel *headerLabel = [[BasicLabel alloc]initWithName: SelectPeopleHeader];
    [headerLabel setText:@"メンバーを招待"];
    [headerLabel sizeToFit];
    headerLabel.frame = CGRectMake((windowSize.size.width - headerLabel.frame.size.width)/2, 35, headerLabel.frame.size.width, headerLabel.frame.size.height);
    [header addSubview: headerLabel];

    [self addSubview: header];
}

- (void)setSearchBar {
    //検索バー
    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 77, windowSize.size.width, 50)];
    searchView.backgroundColor = [UIColor blackColor];
    UISearchBar *search = [[UISearchBar alloc]init];
    search.delegate = self;
    search.placeholder = @"Search";
    search.tintColor = [UIColor colorWithRed:0.796 green:0.816 blue:0.839 alpha:1.0];
    search.frame = CGRectMake(0, 0, windowSize.size.width, 50);
    search.showsCancelButton = NO;
    [searchView addSubview:search];
    
    [self addSubview: searchView];
}

- (void)setTable {
    //真ん中のテーブル
    table = [[SelectPeopleTable alloc]initWithFrame:CGRectMake(0, 127, windowSize.size.width, windowSize.size.height - 177)];
    
    [self addSubview: table];
}

- (void)setFooter {
    //一番下のフッター
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, windowSize.size.height - 50, windowSize.size.width, 50)];
    footer.backgroundColor = [UIColor colorWithRed:0.176 green:0.220 blue:0.286 alpha:1.0];
    RoundedButton *inviteButton = [[RoundedButton alloc]initWithName:AddFriendInvite];
    inviteButton.frame = CGRectMake((windowSize.size.width/2 - 10 - 150), (footer.frame.size.height - 30)/2, 150, 30);
    [inviteButton setTitleInButton:@"招待する"];
    [inviteButton addTarget:self action:@selector(inviteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    RoundedButton *cancelButton = [[RoundedButton alloc]initWithName:AddFriendInvite];
    cancelButton.frame = CGRectMake((windowSize.size.width/2 + 10), (footer.frame.size.height - 30)/2, 150, 30);
    [cancelButton setTitleInButton:@"キャンセル"];
    [cancelButton addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [footer addSubview: inviteButton];
    [footer addSubview: cancelButton];
    [self addSubview: footer];
}

- (void)inviteButtonClicked:(UIButton *)button {
    [self.delegate inviteButtonDelegate];
}

- (void)cancelButtonClicked:(UIButton *)button {
    [self.delegate cancelButtonDelegate];
}

@end
