//
//  FriendsViewController.m
//  Comad
//
//  Created by 浅野 友希 on 2013/10/12.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "FriendsViewController.h"
#import "FriendsViewController+View.m"
#import "Header.h"
#import "UserModal.h"
#import "AddFriendViewController.h"
#import "CreateGroupViewController.h"
#import "Image.h"
#import "AddFriendViewController.h"
#import "ShowUserViewController.h"
#import "FriendCell.h"
#import "BasicLabel.h"

@interface FriendsViewController () {
}

@end

@implementation FriendsViewController
@synthesize delegate, me, activityIndicatorView, state;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        windowSize = [[UIScreen mainScreen] bounds];
        iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        
        Header *header = [[Header alloc]init];
        [header setTitle:@"コマとも"];
        
        if((int)iOSVersion == 6){
            float statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
            header.frame = CGRectMake(0, statusBarHeight, windowSize.size.width, 48);
        }
        
        [self.view addSubview: header];
        [self setAddFriendBtnInHeader];
        
        //通信しているデータとってくる
        [self setInfo];
        //テーブルをセットする
        [self configure];
    }
    return self;
}

- (void)viewDidLoad
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"user: %@", [defaults dictionaryForKey:@"user"]);
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    //friendsTable.contentInset = UIEdgeInsetsMake(-60.0, 0, 0, 0);
    [self.navigationController.tabBarController.tabBar setHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)CreateGroupBtnClicked {
    CreateGroupViewController *cc = [[CreateGroupViewController alloc]init];
    [self.navigationController presentViewController:cc animated:YES completion:nil];
}

- (void)AddFriendBtnClicked {
    AddFriendViewController *ac = [[AddFriendViewController alloc]init];
    [self.navigationController pushViewController:ac animated:NO];
}

- (void)setAddFriendBtnInHeader {
    UIImage *image = [UIImage imageNamed:@"addFriend.png"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(270, 36, 25.5, 20);
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addFriendBtnClicked:)forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:btn];
}

- (void)addFriendBtnClicked:(UIButton *)button {
    AddFriendViewController *ac = [[AddFriendViewController alloc]init];
    ac.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ac animated:YES];
}

//スクロールしてる時に実行される
/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.state == HeaderViewStateStopping) {
        return;
    }
    
    if(0 >= scrollView.contentOffset.y){
        friendsTable.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
}
*/

//stateを確認して変える
- (void)setState:(HeaderViewState)state
{
    /*
    switch (state) {
        case HeaderViewStateHidden:
            [self.activityIndicatorView stopAnimating];
            break;
            
        case HeaderViewStatePullingDown:
            [self.activityIndicatorView stopAnimating];
            if (state != HeaderViewStatePullingDown) {
                [self _animateImageForHeadingUp:NO];
            }
            break;
            
        case HeaderViewStateOveredThreshold:
            [self.activityIndicatorView stopAnimating];
            self.imageView.hidden = NO;
            self.textLabel.text = @"指をはなすと更新";
            if (state_ == HeaderViewStatePullingDown) {
                [self _animateImageForHeadingUp:YES];
            }
            break;
            
        case HeaderViewStateStopping:
            [self.activityIndicatorView startAnimating];
            self.textLabel.text = @"更新中...";
            self.imageView.hidden = YES;
            break;
    }
    
    state = state;
     */
}
/*
- (void)_setHeaderViewHidden:(BOOL)hidden animated:(BOOL)animated
{
    CGFloat topOffset = 0.0;
    if (hidden) {
        topOffset = -friendsTable.frame.size.height;
    }
    if (animated) {
        [UIView animateWithDuration:0.2
                         animations:^{
                             friendsTable.contentInset = UIEdgeInsetsMake(topOffset, 0, 0, 0);
                         }];
    } else {
        friendsTable.contentInset = UIEdgeInsetsMake(topOffset, 0, 0, 0);
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [search resignFirstResponder];
    //searchする。
}
 */

@end
