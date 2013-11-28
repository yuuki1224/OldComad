//
//  WorksViewController.m
//  Comad
//
//  Created by 浅野 友希 on 2013/10/12.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "WorksViewController.h"
#import "Works.h"
#import "Header.h"
#import "ComadCell.h"
#import "ShowComadViewController.h"
#import "CreateComadViewController.h"
#import "Image.h"

@interface WorksViewController ()

@end

@implementation WorksViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        Header *header = [[Header alloc]init];
        [header setTitle:@"コマド"];
        
        [self.view addSubview:header];
        [self setCreateComadBtnInHeader];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

}

- (void)viewWillAppear:(BOOL)animated {
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
            return 30.0;
            break;
        case 1:
            return 30.0;
            break;
        case 2:
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
            return 90.0;
            break;
        case 1:
            return 90.0;
            break;
        case 2:
            return 90.0;
            break;
        default:
            return 90.0;
            break;
    }
}

//セルタップ時
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ComadCell *cell = [worksView cellForRowAtIndexPath:indexPath];
    
    ShowComadViewController *sc = [[ShowComadViewController alloc]init];
    sc.comadInfo = cell.comadInfo;
    sc.name = @"楽洛堂";
    sc.imageName = @"picola.png";
    [self.navigationController.tabBarController.tabBar setHidden:YES];
    [self.navigationController pushViewController:sc animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGRect windowSize = [[UIScreen mainScreen] bounds];
    UIView *headerView = [[UIView alloc]init];
    headerView.frame = CGRectMake(0, 0, windowSize.size.width, 60);
    
    UILabel *headerLabel = [[UILabel alloc]init];
    headerLabel.textColor = [UIColor colorWithRed:0.678 green:0.698 blue:0.733 alpha:1.0];
    
    UIFont *headerFont = [UIFont fontWithName:@"HiraKakuProN-W3" size:12.0f];
    
    headerLabel.font = headerFont;
    
    switch (section) {
        case 0:
            headerLabel.text = @"参加予定のコマド";
            break;
        case 1:
            headerLabel.text = @"グループコマド";
            break;
        case 2:
            headerLabel.text = @"コマド";
            break;
        default:
            break;
    }
    
    CGSize headerLabelSize = [headerLabel sizeThatFits:CGSizeZero];
    headerLabel.frame = CGRectMake( 10, 10, headerLabelSize.width, headerLabelSize.height);
    [headerView addSubview: headerLabel];
    headerView.backgroundColor = [UIColor colorWithRed:0.965 green:0.969 blue:0.973 alpha:1.0];
    return headerView;
}

- (void)setCreateComadBtnInHeader {
    UIImage *image = [UIImage imageNamed:@"comadPlus.png"];
    UIImage *imageResize = [Image resizeImage:image resizePer:0.5];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(285, 42, imageResize.size.width, imageResize.size.height);
    [btn setImage:imageResize forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(createComadBtnClicked:)forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:btn];
}

- (void)createComadBtnClicked:(UIButton *)button {
    [self.navigationController.tabBarController.tabBar setHidden:YES];
    CreateComadViewController *cc = [[CreateComadViewController alloc]init];
    [self.navigationController pushViewController:cc animated:YES];
}

@end
