//
//  ComadsViewController.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/28.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "ComadsViewController.h"
#import "ComadsViewController+View.m"
#import "AddComadViewController.h"
#import "Header.h"

@interface ComadsViewController ()

@end

@implementation ComadsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        windowSize = [[UIScreen mainScreen] bounds];
        iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        
        // Custom initializatio
        header = [[Header alloc]init];
        if((int)iOSVersion == 7){
            [header setTitle:@"コマド"];
        }else if((int)iOSVersion == 6){
            [header setComadTitle];
            float statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
            header.frame = CGRectMake(0, statusBarHeight, windowSize.size.width, 48);
        }
        [self.view addSubview: header];
        [self setAddComadBtnInHeader];
        
        //タブのデザイン設定
        self.delegate = self;
        
        //Tabの背景色を載せるViewを作成
        if((int)iOSVersion == 7){
            //self.tabBar.frame = CGRectMake(3, 82, windowSize.size.width - 6, 48);
            self.tabBar.frame = CGRectMake(3, 82, 315, 48);
        }else if((int)iOSVersion == 6){
            self.tabBar.frame = CGRectMake(3, 124, 315.5, 48);
        }
        
        UIImage *tabBackImage = [UIImage imageNamed:@"comadTab1.png"];
        [self.tabBar setBackgroundImage:tabBackImage];
        
        self.selectedIndex = 0;
        //Tab背景画像のセット
        [self setTabBarImage];
    }
    return self;
}

- (void)viewDidLoad
{
    iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if((int)iOSVersion == 6){
        UIView * contentView = [[[self.tabBar superview] subviews] objectAtIndex:0];
        contentView.frame = CGRectMake(0, 0, 320, 480);
    }
    [self setInfo];
    [self configure];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    //[self setInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setAddComadBtnInHeader {
    iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    UIImage *image = [UIImage imageNamed:@"plusForiOS6.png"];
    UIImage *imageResize = [Image resizeImage:image resizePer:0.5];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if((int)iOSVersion == 7){
        btn.frame = CGRectMake(windowSize.size.width - 35, 40, imageResize.size.width, imageResize.size.height);
    }else if((int)iOSVersion == 6){
        btn.frame = CGRectMake(windowSize.size.width - 35, 37, imageResize.size.width, imageResize.size.height);
    }
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addComadBtnClicked:)forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview: btn];
}

//Tab背景画像をセットする
- (void)setTabBarImage {
    switch (self.selectedIndex) {
        case 0:{
            [newComadTable.tableView reloadData];
            UIImage *tabBackImage = [UIImage imageNamed:@"comadTab1.png"];
            [self.tabBar setBackgroundImage: tabBackImage];
            [self.tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"newSelected.png"]];
            break;
        }
        case 1:{
            [dateComadTable.tableView reloadData];
            UIImage *tabBackImage = [UIImage imageNamed:@"comadTab2.png"];
            [self.tabBar setBackgroundImage:tabBackImage];
            [self.tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"dateSelected.png"]];
            break;
        }
        case 2:{
            [popularComadTable.tableView reloadData];
            UIImage *tabBackImage = [UIImage imageNamed:@"comadTab3.png"];
            [self.tabBar setBackgroundImage: tabBackImage];
            [self.tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"popularSelected.png"]];
            break;
        }
        case 3:{
            [myComadTable.tableView reloadData];
            UIImage *tabBackImage = [UIImage imageNamed:@"comadTab4.png"];
            [self.tabBar setBackgroundImage: tabBackImage];
            [self.tabBar setSelectionIndicatorImage: [UIImage imageNamed:@"mycomadSelected.png"]];
            break;
        }
        default:
            break;
    }
}

//UITabBarControllerが遷移した際に呼ばれるデリゲードメソッド
- (void)tabBarController:(UITabBarController *)theTabBarController didSelectViewController:(UIViewController *)viewController
{
    [self setTabBarImage];
}

- (void)addComadBtnClicked:(UIButton *)button {
    AddComadViewController *ac = [[AddComadViewController alloc]init];
    ac.delegate = self;
    ac.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ac animated:YES];
}

- (void)created {
    [self setInfo];
}

@end
