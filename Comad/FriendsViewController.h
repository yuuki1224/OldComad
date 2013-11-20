//
//  FriendsViewController.h
//  Comad
//
//  Created by 浅野 友希 on 2013/10/12.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Friends.h"

@protocol FriendViewControllerDelegate;

@interface FriendsViewController : UITabBarController <UITableViewDelegate, UIScrollViewDelegate, UISearchBarDelegate>{
    Friends *friendsView;
    UISearchBar *search;
}
@property (nonatomic, weak) id<FriendViewControllerDelegate> delegate;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicatorView;

@end

@protocol FriendViewControllerDelegate
-(void)showModalView:(NSString *)imageName name:(NSString *)name ;
-(void)showModalView:(NSDictionary *)userInfo;
@end
