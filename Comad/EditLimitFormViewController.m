//
//  EditLimitFormViewController.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/03.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "EditLimitFormViewController.h"
#import "EditLimitFormViewController+View.m"
#import "Header.h"
#import "Image.h"
#import "RoundedButton.h"

@interface EditLimitFormViewController ()

@end

@implementation EditLimitFormViewController
@synthesize limit;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        windowSize = [[UIScreen mainScreen] bounds];
        [self.view setBackgroundColor:[UIColor colorWithRed:0.855 green:0.886 blue:0.929 alpha:1.0]];
        Header *header = [[Header alloc]init];
        [header setTitle:@"人数制限"];
        
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
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [limitTable selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
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

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.limit = row;
    [limitTable reloadData];
}

- (void)doneClicked:(UIButton *)button {
    [self.delegate changeLimit: self.limit];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
