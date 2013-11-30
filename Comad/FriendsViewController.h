//
//  FriendsViewController.h
//  Comad
//
//  Created by 浅野 友希 on 2013/10/12.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HeaderViewStateHidden = 0,          // ヘッダが隠れた状態
    HeaderViewStatePullingDown,         // プルダウン状態１（ただし閾値は超えていない）
    HeaderViewStateOveredThreshold,     // プルダウン状態２（閾値を越えている）
    HeaderViewStateStopping             // プルダウン停止状態（処理中）
} HeaderViewState;

@protocol FriendViewControllerDelegate;

@interface FriendsViewController : UITabBarController <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UISearchBarDelegate>{
    UISearchBar *search;
    CGRect windowSize;
    float iOSVersion;
    
    NSMutableArray *_newFriends;
    NSMutableArray *_friends;
    NSMutableArray *_groups;
    UITableView *friendsTable;
}

@property (nonatomic, weak) id<FriendViewControllerDelegate> delegate;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) NSDictionary *me;
//@property (strong, nonatomic) NSMutableArray *hoge;
@property (nonatomic, assign) HeaderViewState state;

-(void)setInfo;
-(void)configure;
@end

@protocol FriendViewControllerDelegate
-(void)showModalView:(NSString *)imageName name:(NSString *)name ;
-(void)showModalView:(NSDictionary *)userInfo;
@end
