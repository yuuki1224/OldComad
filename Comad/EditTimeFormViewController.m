//
//  EditTimeFormViewController.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/03.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "EditTimeFormViewController.h"
#import "EditTimeFormViewController+View.m"
#import "Header.h"
#import "Image.h"
#import "RoundedButton.h"

@interface EditTimeFormViewController ()

@end

@implementation EditTimeFormViewController
@synthesize selected, beforeEditStartTime, beforeEditEndTime, afterEditStartTime, afterEditEndTime;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        windowSize = [[UIScreen mainScreen] bounds];
        self.view.backgroundColor = [UIColor whiteColor];
        Header *header = [[Header alloc]init];
        [header setTitle:@"時刻設定"];
        
        [self.view addSubview:header];
        [self setBackBtnInHeader];
        
        RoundedButton *button = [RoundedButton buttonWithType:UIButtonTypeRoundedRect];
        [button setText:@"完了"];
        button.frame = CGRectMake(windowSize.size.width - 60, 37, 48, 28);
        [button addTarget:self action:@selector(doneClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        [self configure];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"%d", selected);
    NSLog(@"%@", self.beforeEditEndTime);
    switch (selected) {
        case StartTimeSelected: {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [timeTable selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            break;
        }
        case EndTimeSelected: {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
            [timeTable selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            break;
        }
        default:
            break;
    }
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
    btn.frame = CGRectMake(15, 36, 20, 28);
    [btn setImage:imageResize forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backBtnClicked:)forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:btn];
}

- (void)backBtnClicked:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            selected = StartTimeSelected;
            
            break;
        case 1:
            selected = EndTimeSelected;
            
            break;
        default:
            break;
    }
}

-(void)changeDatePicker:(UIDatePicker*)dp{
    switch (selected) {
        case StartTimeSelected:
            afterEditStartTime = dp.date;
            break;
        case EndTimeSelected:
            afterEditEndTime = dp.date;
            break;
        default:
            break;
    }
    [timeTable reloadData];
    switch (selected) {
        case StartTimeSelected: {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [timeTable selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            break;
        }
        case EndTimeSelected: {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
            [timeTable selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            break;
        }
        default:
            break;
    }
}

-(void)doneClicked:(UIButton *)btn {
    //前の画面のプロパティに渡したい delegate?
    [self.delegate changeTime:self.afterEditStartTime endTime:self.afterEditEndTime];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
