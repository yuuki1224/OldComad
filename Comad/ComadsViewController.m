//
//  ComadsViewController.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/28.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "ComadsViewController.h"
#import "ComadsViewController+View.m"
#import "Header.h"

@interface ComadsViewController ()

@end

@implementation ComadsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        float iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        windowSize = [[UIScreen mainScreen] bounds];
        // Custom initializatio
        Header *header = [[Header alloc]init];
        [header setTitle:@"コマド"];
        [self.view addSubview: header];
        [self setAddFriendBtnInHeader];
        
        [self.view addSubview: header];
        //タブのデザイン設定
        self.delegate = self;
        
        //Tabの背景色を載せるViewを作成
        //CGSize tabBarSize = [self.tabBar frame].size;
        if(iOSVersion == 7.00){
            self.tabBar.frame = CGRectMake(5, 82, windowSize.size.width - 10, 50);
        }else{
            self.tabBar.frame = CGRectMake(5, 130, windowSize.size.width - 10, 50);
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

- (void)setAddFriendBtnInHeader {
    UIImage *image = [UIImage imageNamed:@"addFriend.png"];
    UIImage *imageResize = [Image resizeImage:image resizePer:0.5];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(270, 42, imageResize.size.width, imageResize.size.height);
    [btn setImage:imageResize forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addFriendBtnClicked:)forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:btn];
}

//Tab背景画像をセットする
- (void)setTabBarImage {
    NSLog(@"setTabBarImage");
    switch (self.selectedIndex) {
        case 0:{
            [newComadTable.tableView reloadData];
            UIImage *tabBackImage = [UIImage imageNamed:@"comadTab1.png"];
            [self.tabBar setBackgroundImage:[Image resizeImage:tabBackImage resizeWidth:(windowSize.size.width - 10) resizeHeight:50]];
            break;
        }
        case 1:{
            [dateComadTable.tableView reloadData];
            UIImage *tabBackImage = [UIImage imageNamed:@"comadTab2.png"];
            [self.tabBar setBackgroundImage:[Image resizeImage:tabBackImage resizeWidth:(windowSize.size.width - 10) resizeHeight:50]];
            break;
        }
        case 2:{
            [popularComadTable.tableView reloadData];
            UIImage *tabBackImage = [UIImage imageNamed:@"comadTab3.png"];
            [self.tabBar setBackgroundImage:[Image resizeImage:tabBackImage resizeWidth:(windowSize.size.width - 10) resizeHeight:50]];
            break;
        }
        case 3:{
            [myComadTable.tableView reloadData];
            UIImage *tabBackImage = [UIImage imageNamed:@"comadTab4.png"];
            [self.tabBar setBackgroundImage:[Image resizeImage:tabBackImage resizeWidth:(windowSize.size.width - 10) resizeHeight:50]];
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

@end
