//
//  EditLocationStatusFormViewController.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/03.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "EditLocationStatusFormViewController.h"
#import "EditLocationStatusFormViewController+View.m"
#import "Image.h"
#import "Header.h"
#import "RoundedButton.h"

@interface EditLocationStatusFormViewController ()

@end

@implementation EditLocationStatusFormViewController
@synthesize wifi, powerSource, selected;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor whiteColor];
        [self.view setBackgroundColor:[UIColor colorWithRed:0.855 green:0.886 blue:0.929 alpha:1.0]];
        Header *header = [[Header alloc]init];
        [header setTitle:@"電源・Wifi設定"];
        windowSize = [[UIScreen mainScreen] bounds];
        
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
    switch (selected) {
        case PowerSourceSelected: {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [locationStatusTable selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            break;
        }
        case WifiSelected: {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
            [locationStatusTable selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
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
            selected = PowerSourceSelected;
            break;
        case 1:
            selected = WifiSelected;
            break;
        default:
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (selected) {
        case PowerSourceSelected: {
            switch (row) {
                case 0: {
                    self.powerSource = IDontKnow;
                    break;
                }
                case 1: {
                    self.powerSource = Exist;
                    break;
                }
                case 2: {
                    self.powerSource = Nothing;
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case WifiSelected: {
            switch (row) {
                case 0: {
                    self.wifi = IDontKnow;
                    break;
                }
                case 1: {
                    self.wifi = Exist;
                    break;
                }
                case 2: {
                    self.wifi = Nothing;
                    break;
                }
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
    [locationStatusTable reloadData];
}

- (void)doneClicked:(UIButton *)button {
    [self.delegate changeStatus:self.wifi powerSourceStatus:self.powerSource];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
