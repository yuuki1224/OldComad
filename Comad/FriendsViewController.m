//
//  FriendsViewController.m
//  Comad
//
//  Created by 浅野 友希 on 2013/10/12.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "FriendsViewController.h"
#import "Header.h"
#import "Friends.h"
#import "UserModal.h"
#import "AddFriendViewController.h"
#import "CreateGroupViewController.h"
#import "ShowGroupViewController.h"
#import "Image.h"
#import "AddFriendViewController.h"
#import "ShowUserViewController.h"
#import "FriendCell.h"
#import "BasicLabel.h"

@interface FriendsViewController () {
}

@end

@implementation FriendsViewController
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        CGRect windowSize = [[UIScreen mainScreen] bounds];
        
        friendsView = [[Friends alloc]init];
        friendsView.delegate = self;
        
        friendsView.tableHeaderView = [[UIView alloc]init];
        friendsView.tableHeaderView.frame = CGRectMake(0, 0, windowSize.size.width, 60);
        friendsView.tableHeaderView.backgroundColor = [UIColor blueColor];
        friendsView.contentInset = UIEdgeInsetsMake(-60.0, 0, 0, 0);
    
        Header *header = [[Header alloc]init];
        [header setTitle:@"コマとも(20人)"];
        
        [self.view addSubview: header];
        [self.view addSubview: friendsView];
        
        [self setAddFriendBtnInHeader];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    friendsView.contentInset = UIEdgeInsetsMake(-60.0, 0, 0, 0);
    [self.navigationController.tabBarController.tabBar setHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//For UITableViewDelegate
//ヘッダーの高さ
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 60.0;
            break;
        case 1:
            return 30.0;
            break;
        case 2:
            return 30.0;
            break;
        case 3:
            return 30.0;
            break;
        default:
            return 30.0;
            break;
    }
}

//セルの高さ
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 64.0;
            break;
        case 1:
            return 64.0;
            break;
        case 2:
            return 64.0;
            break;
        case 3:
            return 64.0;
            break;
        default:
            return 64.0;
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"touch! %d", indexPath.row);
    //indexPathよりCellの情報取りたい
    FriendCell *cell = [tableView cellForRowAtIndexPath: indexPath];
        
    NSDictionary *userInfo= cell.userInfo;
    if(indexPath.section == 1){
        //マイページ
        ShowUserViewController *sc =[[ShowUserViewController alloc]init];
        [sc setMe: YES];
        sc.userInfo = userInfo;
        [self.navigationController pushViewController:sc animated:YES];
    }else if (indexPath.section == 2){
        [self.delegate showModalView: userInfo];
    }else if (indexPath.section == 3){
        //グループ表示
        ShowGroupViewController *sc =[[ShowGroupViewController alloc]init];
        [self.navigationController pushViewController:sc animated:YES];
    }else if (indexPath.section == 4){
        [self.delegate showModalView: userInfo];
    }
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
    UIImage *imageResize = [Image resizeImage:image resizePer:0.5];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(270, 42, imageResize.size.width, imageResize.size.height);
    [btn setImage:imageResize forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addFriendBtnClicked:)forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:btn];
}

- (void)addFriendBtnClicked:(UIButton *)button {
    AddFriendViewController *ac = [[AddFriendViewController alloc]init];
    [self.navigationController pushViewController:ac animated:YES];
}

//スクロールしてる時に実行される
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (friendsView.state == HeaderViewStateStopping) {
        return;
    }
    
    if(0 >= scrollView.contentOffset.y){
        friendsView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGRect windowSize = [[UIScreen mainScreen] bounds];
    UIView *headerView = [[UIView alloc]init];
    headerView.frame = CGRectMake(0, 0, windowSize.size.width, 60);
    
    if(section == 0){
        search = [[UISearchBar alloc]init];
        search.delegate = self;
        search.placeholder = @"Search";
        search.tintColor = [UIColor colorWithRed:0.796 green:0.816 blue:0.839 alpha:1.0];
        search.frame = CGRectMake(0, 0, windowSize.size.width, 60);
        search.showsCancelButton = NO;
        [headerView addSubview:search];
        headerView.backgroundColor = [UIColor colorWithRed:0.796 green:0.816 blue:0.839 alpha:1.0];
    }else{
        BasicLabel *headerLabel = [[BasicLabel alloc]initWithName: TableHeader];
        switch (section) {
            case 1:
                headerLabel.text = @"プロフィール";
                break;
            case 2:
                headerLabel.text = @"新しいコマとも";
                break;
            case 3:
                headerLabel.text = @"グループ";
                break;
            case 4:
                headerLabel.text = @"コマとも";
                break;
            default:
                break;
        }
        
        CGSize headerLabelSize = [headerLabel sizeThatFits:CGSizeZero];
        headerLabel.frame = CGRectMake( 10, 10, headerLabelSize.width, headerLabelSize.height);
        [headerView addSubview: headerLabel];
        headerView.backgroundColor = [UIColor colorWithRed:0.965 green:0.969 blue:0.973 alpha:1.0];
    }
    return headerView;
}


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

- (void)_setHeaderViewHidden:(BOOL)hidden animated:(BOOL)animated
{
    CGFloat topOffset = 0.0;
    if (hidden) {
        topOffset = -friendsView.frame.size.height;
    }
    if (animated) {
        [UIView animateWithDuration:0.2
                         animations:^{
                             friendsView.contentInset = UIEdgeInsetsMake(topOffset, 0, 0, 0);
                         }];
    } else {
        friendsView.contentInset = UIEdgeInsetsMake(topOffset, 0, 0, 0);
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [search resignFirstResponder];
    //searchする。
}

@end
