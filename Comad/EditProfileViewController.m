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
#import "Basic.h"
#import "AFHTTPClient.h"

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController
@synthesize userName, comadId, occupation, detail, question1;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        windowSize = [[UIScreen mainScreen] bounds];
        iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        Header *header = [[Header alloc]init];
        [header setTitle:@"プロフィール編集"];
        if((int)iOSVersion == 6){
            [header setBackBtn];
            header.delegate = self;
            [self.view addSubview:header];
        }else if((int)iOSVersion == 7){
            NSString *backImageName = @"back.png";
            UIImage *buttonImage = [UIImage imageNamed:backImageName];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(15, 40, 10, 17.5);
            [btn setImage:buttonImage forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(backBtnClicked:)forControlEvents:UIControlEventTouchDown];
            [self.view addSubview:header];
            [self.view addSubview:btn];
        }
        
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
    self.comadId = [userInfo objectForKey:@"comad_id"];
    self.occupation = [userInfo objectForKey:@"occupation"];
    self.detail = [userInfo objectForKey:@"description"];
    self.question1 = [userInfo objectForKey:@"organization"];
    
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
    NSString *imageName = [nowUserInfo objectForKey:@"image_name"];
    NSDictionary *newUserInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                         userId, @"id",
                         self.userName, @"name",
                         imageName, @"image_name",
                         self.comadId, @"comad_id",
                         self.occupation, @"occupation",
                         self.detail, @"description",
                         self.question1, @"organization",nil];
    [userDefaults setValue:newUserInfo forKey: @"user"];
    [userDefaults synchronize];
    [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeBlack];
    [[UserJsonClient sharedClient]updateUserProfile:newUserInfo :^(AFHTTPRequestOperation *operation, NSHTTPURLResponse *response, id responseObject) {
        //成功したら
        if(profileImage){
            // 引き続き写真アップロード
            NSURL *baseUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/user/update_image", HOST_URL]];
            NSData *receiveData = [[NSData alloc]initWithData: UIImageJPEGRepresentation(profileImage, 1.0)];
            NSDictionary *params = @{@"user_id": [nowUserInfo objectForKey:@"id"]};
            
            AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL: baseUrl];
            
            NSMutableURLRequest *request = [client multipartFormRequestWithMethod:@"POST" path:@"/api/user/update_image" parameters: params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                [formData appendPartWithFileData:receiveData name:@"profileImage" fileName:@"profile.jpg" mimeType:@"image/jpeg"];
            }];
            AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest: request];
            [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
                if(totalBytesExpectedToWrite == totalBytesWritten){
                    [SVProgressHUD dismiss];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
            NSOperationQueue *queue = [[NSOperationQueue alloc]init];
            [queue addOperation:operation];
        }else{
            [SVProgressHUD dismiss];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(int statusCode, NSString *errorString) {
        //失敗したら
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
        default:
            break;
    }
}

#pragma HeaderDelagete methods
- (void)backBtnClickedDelegate {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)backBtnClicked:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
