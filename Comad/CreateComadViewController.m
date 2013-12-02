//
//  CreateComadViewController.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/03.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "CreateComadViewController.h"
#import "CreateComadFormCell.h"
#import "EditTimeFormViewController.h"
#import "EditLoacationFormViewController.h"
#import "EditLimitFormViewController.h"
#import "EditGroupOnlyFormViewController.h"
#import "EditLocationStatusFormViewController.h"
#import "Image.h"
#import "Header.h"
#import "BasicLabel.h"
#import "RoundedButton.h"
#import "ComadJsonClient.h"
#import "SVProgressHUD.h"

@interface CreateComadViewController ()

@end

@implementation CreateComadViewController {
    CGRect windowSize;
}
@synthesize fromTime, untilTime, location, detail, wifi, powerSource, limit, group;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        windowSize = [[UIScreen mainScreen] bounds];
        iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        self.view.backgroundColor = [UIColor whiteColor];
        Header *header = [[Header alloc]init];
        [header setTitle:@"コマド作成"];
        
        [self.view addSubview:header];
        [self setBackBtnInHeader];
        /*
        RoundedButton *button = [RoundedButton buttonWithType:UIButtonTypeRoundedRect];
        [button setText:@"作成"];
        button.frame = CGRectMake(windowSize.size.width - 60, 37, 48, 28);
        [button addTarget:self action:@selector(createClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        */
        // table
        createComadForm = [[UITableView alloc]initWithFrame:CGRectMake(0, 77, windowSize.size.width, windowSize.size.height - 77) style:UITableViewStylePlain];
        createComadForm.scrollEnabled = false;
        createComadForm.dataSource = self;
        createComadForm.delegate = self;
        [self.view addSubview: createComadForm];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"detailAppear: %@",self.detail);
    [createComadForm reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setBackBtnInHeader {
    UIImage *image = [UIImage imageNamed:@"back.png"];
    UIImage *imageResize = [Image resizeImage:image resizePer:0.5];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if((int)iOSVersion == 7){
        btn.frame = CGRectMake(15, 36, 20, 28);
    }else if ((int)iOSVersion == 6){
        btn.frame = CGRectMake(15, 11, 20, 28);
    }
    [btn setImage:imageResize forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backBtnClicked:)forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:btn];
}

- (void)backBtnClicked:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"section: %d",section);
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 5;
            break;
        default:
            break;
    }
    return 5;
}

// cellの中身
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CreateComadFormCell *cell = [[CreateComadFormCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"a"];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    CGRect windowSize = [[UIScreen mainScreen] bounds];
    cell.textLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14.0f];
    cell.detailTextLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14.0f];
    
    switch (indexPath.section) {
        case 0:
            if(indexPath.row == 0){
                cell.textLabel.text = @"開始時刻";
                if(self.fromTime){
                    NSDateFormatter *format = [[NSDateFormatter alloc]init];
                    [format setDateFormat:@"MM/dd HH:mm"];
                    cell.detailTextLabel.text = [format stringFromDate:self.fromTime];
                }else {
                    cell.detailTextLabel.text = @"時刻を追加";
                }
            }else if(indexPath.row == 1){
                cell.textLabel.text = @"終了時刻";
                if(self.untilTime){
                    NSDateFormatter *format = [[NSDateFormatter alloc]init];
                    [format setDateFormat:@"MM/dd HH:mm"];
                    cell.detailTextLabel.text = [format stringFromDate:self.untilTime];
                }else {
                    cell.detailTextLabel.text = @"時刻を追加";
                }
            }else if(indexPath.row == 2){
                cell.textLabel.text = @"場所";
                if(self.location){
                    cell.detailTextLabel.text = self.location;
                }else {
                    cell.detailTextLabel.text = @"場所を追加";
                }
            }
            break;
        case 1: {
            if(indexPath.row == 0){
                //textFieldにする
                cell.accessoryType = UITableViewCellAccessoryNone;
                textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, windowSize.size.width, 60)];
                textView.returnKeyType = UIReturnKeyDone;
                textView.delegate = self;
                textView.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12.0f];
                textView.text = self.detail;
    
                [cell addSubview:textView];
            }else if(indexPath.row == 1){
                cell.textLabel.text = @"電源";
                if(self.powerSource == IDontKnow){
                    cell.detailTextLabel.text = @"指定しない";
                }else if (self.powerSource == Exist) {
                    cell.detailTextLabel.text = @"あり";
                }else if(self.powerSource == Nothing) {
                    cell.detailTextLabel.text = @"なし";
                }else {
                    cell.detailTextLabel.text = @"電源の有無を追加";
                }
            }else if(indexPath.row == 2){
                cell.textLabel.text = @"Wi-Fi";
                if(self.wifi == IDontKnow){
                    cell.detailTextLabel.text = @"指定しない";
                }else if (self.wifi == Exist) {
                    cell.detailTextLabel.text = @"あり";
                }else if(self.wifi == Nothing) {
                    cell.detailTextLabel.text = @"なし";
                }else {
                    cell.detailTextLabel.text = @"Wi-Fiの有無を追加";
                }
            }else if(indexPath.row == 3){
                cell.textLabel.text = @"人数制限";
                NSLog(@"人数制限: %d",self.limit);
                if(self.limit){
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d人", self.limit];
                }else {
                    cell.detailTextLabel.text = @"人数制限を追加";
                }
            }else if(indexPath.row == 4){
                cell.textLabel.text = @"グループだけに公開";
                cell.detailTextLabel.text = @"オフ";
            }
            break;
        }
        default:
            break;
    }
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

#pragma UITableViewDelegate methods
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 1){
        if(indexPath.row == 0){
            return 60;
        }
    }
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section==0){
        return 35;
    }else if(section==1){
        return 42;
    }
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

//クリックされたら
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    switch (indexPath.section) {
        case 0:
            if(indexPath.row == 0){
                EditTimeFormViewController *ec = [[EditTimeFormViewController alloc]init];
                ec.delegate = self;
                ec.selected = StartTimeSelected;
                ec.afterEditStartTime = self.fromTime;
                ec.afterEditEndTime = self.untilTime;
                [self.navigationController pushViewController:ec animated:YES];
            }else if(indexPath.row == 1){
                EditTimeFormViewController *ec = [[EditTimeFormViewController alloc]init];
                ec.delegate = self;
                ec.selected = EndTimeSelected;
                ec.afterEditStartTime = self.fromTime;
                ec.afterEditEndTime = self.untilTime;
                [self.navigationController pushViewController:ec animated:YES];
            }else if(indexPath.row == 2){
                EditLoacationFormViewController *ec = [[EditLoacationFormViewController alloc]init];
                ec.delegate = self;
                ec.location = self.location;
                [self.navigationController pushViewController:ec animated:YES];
            }
            break;
        case 1:
            if(indexPath.row == 0){
            }else if (indexPath.row == 1){
                //電源
                EditLocationStatusFormViewController *ec = [[EditLocationStatusFormViewController alloc]init];
                ec.delegate = self;
                ec.selected = PowerSourceSelected;
                ec.powerSource = self.powerSource;
                ec.wifi = self.wifi;
                [self.navigationController pushViewController:ec animated:YES];
            }else if(indexPath.row == 2){
                //wifi
                EditLocationStatusFormViewController *ec = [[EditLocationStatusFormViewController alloc]init];
                ec.delegate = self;
                ec.powerSource = self.powerSource;
                ec.wifi = self.wifi;
                ec.selected = WifiSelected;
                [self.navigationController pushViewController:ec animated:YES];
            }else if(indexPath.row == 3){
                //limit
                EditLimitFormViewController *ec = [[EditLimitFormViewController alloc]init];
                ec.delegate = self;
                ec.limit = self.limit;
                [self.navigationController pushViewController:ec animated:YES];
            }else if(indexPath.row == 4){
                //group
                EditGroupOnlyFormViewController *ec = [[EditGroupOnlyFormViewController alloc]init];
                [self.navigationController pushViewController:ec animated:YES];
            }
            break;
        case 2:
            break;
        default:
            break;
    }
     */
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc]init];
    if(section == 0){
        header.frame = CGRectMake(0, 0, windowSize.size.width, 35);
        [header setBackgroundColor:[UIColor colorWithRed:0.855 green:0.886 blue:0.929 alpha:1.0]];
        UIImage *headerImage = [UIImage imageNamed:@"createComadForm1.png"];
        UIImage *headerImageResize = [Image resizeImage:headerImage resizePer:0.5];
        UIImageView *headerImageView = [[UIImageView alloc]initWithImage: headerImageResize];
        headerImageView.frame = CGRectMake(15, 3, headerImageResize.size.width, headerImageResize.size.height);
        [header addSubview: headerImageView];
        BasicLabel *headerLabel = [[BasicLabel alloc]initWithName:HeaderTitle];
        headerLabel.text = @"日程＆場所";
        [headerLabel sizeToFit];
        headerLabel.frame = CGRectMake(52, header.frame.size.height - 23, headerLabel.frame.size.width, headerLabel.frame.size.height);
        [header addSubview:headerLabel];
    }else if(section == 1){
        header.frame = CGRectMake(0, 0, windowSize.size.width, 42);
        [header setBackgroundColor:[UIColor colorWithRed:0.855 green:0.886 blue:0.929 alpha:1.0]];
        UIImage *headerImage = [UIImage imageNamed:@"createComadForm2.png"];
        UIImage *headerImageResize = [Image resizeImage:headerImage resizePer:  0.5];
        UIImageView *headerImageView = [[UIImageView alloc]initWithImage: headerImageResize];
        headerImageView.frame = CGRectMake(15, 10, headerImageResize.size.width, headerImageResize.size.height);
        [header addSubview: headerImageView];
        BasicLabel *headerLabel = [[BasicLabel alloc]initWithName:HeaderTitle];
        headerLabel.text = @"コマド詳細(任意)";
        [headerLabel sizeToFit];
        headerLabel.frame = CGRectMake(52, header.frame.size.height - 23, headerLabel.frame.size.width, headerLabel.frame.size.height);
        [header addSubview:headerLabel];
    }else {
        [header setBackgroundColor:[UIColor colorWithRed:0.855 green:0.886 blue:0.929 alpha:1.0]];
    }
    return header;
}

- (void) textViewDidChange: (UITextView*) text {
    NSLog(@"%@",text.text);
    NSRange searchResult = [text.text rangeOfString:@"\n"];
    if(searchResult.location != NSNotFound){
        text.text = [text.text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        self.detail = text.text;
        [text resignFirstResponder];
        NSLog(@"detail: %@",self.detail);
    }
}

- (void) textViewDidEndEditing:(UITextView *)textView {
    NSLog(@"%@",textView.text);
}

- (void)createClicked:(UIButton *)btn {
    //送信する処理
    ComadJsonClient *client = [ComadJsonClient sharedClient];
    [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeBlack];
    
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *startTime = [format stringFromDate:self.fromTime];
    NSString *endTime = [format stringFromDate:self.untilTime];
    NSString *wifiString = [NSString stringWithFormat:@"%d", self.wifi];
    NSString *powerString = [NSString stringWithFormat:@"%d", self.powerSource];
    NSString *limitString = [NSString stringWithFormat:@"%d", self.limit];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"1", @"user_id",
                         startTime, @"start_time",
                         endTime, @"end_time",
                         self.location, @"location",
                         self.detail, @"detail",
                         wifiString, @"wifi",
                         powerString, @"power_source",
                         limitString, @"limit", nil];
    
    [client createNewComad:(NSDictionary *)params :^(AFHTTPRequestOperation *operation, NSHTTPURLResponse *response, id responseObject) {
        NSLog(@"%@", response);
        [SVProgressHUD dismiss];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(int statusCode, NSString *errorString) {
        NSLog(@"%@", errorString);
        [SVProgressHUD dismiss];
    }];
}

# pragma EditTimeFormDelegate
- (void)changeTime:(NSDate *)startTime endTime:(NSDate *)endTime {
    self.fromTime = startTime;
    self.untilTime = endTime;
}

# pragma EditLocationFormDelegate
- (void)changeLocation:(NSString *)changeLocation {
    self.location = changeLocation;
}

#pragma EditLocationStatusFormDelegate
- (void)changeStatus:(Whether)wifiStatus powerSourceStatus:(Whether)powerSourceStatus {
    self.wifi = wifiStatus;
    self.powerSource = powerSourceStatus;
}

#pragma EditLimitFormDelegate
- (void)changeLimit:(int)limitNum {
    self.limit = limitNum;
}

@end
