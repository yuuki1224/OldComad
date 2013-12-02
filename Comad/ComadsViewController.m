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
        
        [self.view addSubview: header];
        //タブのデザイン設定
        self.delegate = self;
        
        //Tabの背景色を載せるViewを作成
        //CGSize tabBarSize = [self.tabBar frame].size;
        if((int)iOSVersion == 7.00){
            self.tabBar.frame = CGRectMake(5, 82, windowSize.size.width - 10, 50);
        }else if((int)iOSVersion == 6){
            self.tabBar.frame = CGRectMake(5, 120, windowSize.size.width - 10, 50);
        }
        
        UIImage *tabBackImage = [UIImage imageNamed:@"comadTab1.png"];
        [self.tabBar setBackgroundImage:[Image resizeImage:tabBackImage resizeWidth:windowSize.size.width resizeHeight:50]];
        
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
        btn.frame = CGRectMake(windowSize.size.width - 35, 17, imageResize.size.width, imageResize.size.height);
    }
    [btn setImage:imageResize forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addComadBtnClicked:)forControlEvents:UIControlEventTouchDown];
    
    [header addSubview: btn];
}

//Tab背景画像をセットする
- (void)setTabBarImage {
    NSLog(@"setTabBarImage");
    switch (self.selectedIndex) {
        case 0:{
            [newComadTable.tableView reloadData];
            UIImage *tabBackImage = [UIImage imageNamed:@"comadTab1.png"];
            [self.tabBar setBackgroundImage:[Image resizeImage:tabBackImage resizeWidth:(windowSize.size.width - 10) resizeHeight:50]];
            [self.tabBar setSelectionIndicatorImage:[Image resizeImage:[UIImage imageNamed:@"newSelected.png"] resizePer:0.5]];
            break;
        }
        case 1:{
            [dateComadTable.tableView reloadData];
            UIImage *tabBackImage = [UIImage imageNamed:@"comadTab2.png"];
            [self.tabBar setBackgroundImage:[Image resizeImage:tabBackImage resizeWidth:(windowSize.size.width - 10) resizeHeight:50]];
            [self.tabBar setSelectionIndicatorImage:[Image resizeImage:[UIImage imageNamed:@"dateSelected.png"] resizePer:0.5]];
            break;
        }
        case 2:{
            [popularComadTable.tableView reloadData];
            UIImage *tabBackImage = [UIImage imageNamed:@"comadTab3.png"];
            [self.tabBar setBackgroundImage:[Image resizeImage:tabBackImage resizeWidth:(windowSize.size.width - 10) resizeHeight:50]];
            [self.tabBar setSelectionIndicatorImage:[Image resizeImage:[UIImage imageNamed:@"popularSelected.png"] resizePer:0.5]];
            break;
        }
        case 3:{
            [myComadTable.tableView reloadData];
            UIImage *tabBackImage = [UIImage imageNamed:@"comadTab4.png"];
            [self.tabBar setBackgroundImage:[Image resizeImage:tabBackImage resizeWidth:(windowSize.size.width - 10) resizeHeight:50]];
            [self.tabBar setSelectionIndicatorImage:[Image resizeImage:[UIImage imageNamed:@"mycomadSelected.png"] resizePer:0.5]];
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
    ac.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ac animated:YES];
}

@end
