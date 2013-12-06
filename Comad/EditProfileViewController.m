//
//  EditProfileViewController.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/02.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "EditProfileViewController.h"
#import "EditProfileViewController+View.m"
#import "EditProfileFormViewController.h"
#import "Header.h"
#import "Image.h"
#import "RoundedButton.h"
#import "UserJsonClient.h"
#import "SVProgressHUD.h"

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController
@synthesize userName, comadId, occupation, detail, question1, question2, question3, question4;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        windowSize = [[UIScreen mainScreen] bounds];
        iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        Header *header = [[Header alloc]init];
        [header setTitle:@"プロフィール編集"];
        [header setBackBtn];
        header.delegate = self;
        
        [self.view addSubview:header];
        
        if((int)iOSVersion == 7){
            self.view.frame = CGRectMake(0, 77, windowSize.size.width, 800);
        }else if((int)iOSVersion == 6){
            self.view.frame = CGRectMake(0, 0, windowSize.size.width, 800);
        }
        
        if((int)iOSVersion == 7){
            RoundedButton *button = [[RoundedButton alloc] initWithName:HeaderDone];
            [button setTitleInButton:@"作成"];
            button.frame = CGRectMake(windowSize.size.width - 60, 37, 48, 28);
            //[button addTarget:self action:@selector(saveClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
        }else if((int)iOSVersion == 6){
            //UIImageView *button = [[UIImageView alloc]initWithFrame:CGRectMake(windowSize.size.width - 60, 10, 48, 28)];
            UIImage *buttonImage = [UIImage imageNamed:@"done.png"];
            UIImageView *createButton = [[UIImageView alloc]initWithImage:buttonImage];
            createButton.frame = CGRectMake(windowSize.size.width - 52.5, 10, 42.5, 28.5);
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(saveClicked:)];
            [createButton addGestureRecognizer: tapGesture];
            createButton.userInteractionEnabled = YES;
            [self.view addSubview: createButton];
        }
        
        [self configure];
    }
    return self;
}

- (void)viewDidLoad
{
    //NSUserDefaultから取ってきてセット
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userInfo = [userDefaults valueForKey:@"user"];
    self.userName = [userInfo objectForKey:@"name"];
    self.comadId = [userInfo objectForKey:@"comadId"];
    self.occupation = [userInfo objectForKey:@"occupation"];
    self.detail = [userInfo objectForKey:@"detail"];
    self.question1 = [userInfo objectForKey:@"question1"];
    self.question2 = [userInfo objectForKey:@"question2"];
    self.question3 = [userInfo objectForKey:@"question3"];
    self.question4 = [userInfo objectForKey:@"question4"];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    //NSUserDefaultから取ってきてセット
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userDefaults valueForKey:@"user"];

    [editProfileTable reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//セルクリックするとき
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EditProfileFormViewController *ec = [[EditProfileFormViewController alloc]init];
    ec.delegate = self;
    
    if(indexPath.section == 0){
        switch (indexPath.row) {
            case 0:
                ec.editText = self.userName;
                ec.cellType = Name;
                break;
            case 1:
                ec.editText = self.comadId;
                ec.cellType = ComadID;
                break;
            case 2:
                ec.editText = self.occupation;
                ec.cellType = Occupation;
                break;
            default:
                break;
        }
    }else{
        switch (indexPath.section) {
            case 1:
                ec.editText = self.detail;
                ec.cellType = Detail;
                break;
            case 2:
                ec.editText = self.question1;
                ec.cellType = Question1;
                break;
            case 3:
                ec.editText = self.question2;
                ec.cellType = Question2;
                break;
            case 4:
                ec.editText = self.question3;
                ec.cellType = Question3;
                break;
            case 5:
                ec.editText = self.question4;
                ec.cellType = Question4;
                break;
            default:
                break;
        }
    }
    [self.navigationController pushViewController:ec animated:YES];
}

- (void)saveClicked:(UITapGestureRecognizer *)sender {
    //保存する。NSuserdefaultに保存して、サーバーに上げる
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *nowUserInfo = [userDefaults valueForKey:@"user"];
    NSString *userId = [nowUserInfo objectForKey:@"id"];
    NSString *imageName = [nowUserInfo objectForKey:@"imageName"];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                         userId, @"id",
                         self.userName, @"name",
                         imageName, @"imageName",
                         self.comadId, @"comadId",
                         self.occupation, @"occupation",
                         self.detail, @"detail",
                         self.question1, @"question1",
                         self.question2, @"question2",
                         self.question3, @"question3",
                         self.question4, @"question4", nil];
    [userDefaults setValue:userInfo forKey: @"user"];
    [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeBlack];
    [[UserJsonClient sharedClient]updateUserProfile:userInfo :^(AFHTTPRequestOperation *operation, NSHTTPURLResponse *response, id responseObject) {
        [SVProgressHUD dismiss];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(int statusCode, NSString *errorString) {
        [SVProgressHUD dismiss];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)doneClicked:(EditProfileCell)type text:(NSString *)text {
    switch (type) {
        case Name:
            self.userName = text;
            break;
        case ComadID:
            self.comadId = text;
            break;
        case Occupation:
            self.occupation = text;
            break;
        case Detail:
            self.detail = text;
            break;
        case Question1:
            self.question1 = text;
            break;
        case Question2:
            self.question2 = text;
            break;
        case Question3:
            self.question3 = text;
            break;
        case Question4:
            self.question4 = text;
            break;
        default:
            break;
    }
}

#pragma HeaderDelagete methods

- (void)backBtnClickedDelegate {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
