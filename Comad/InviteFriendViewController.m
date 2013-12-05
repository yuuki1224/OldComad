//
//  InviteFriendViewController.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/17.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "InviteFriendViewController.h"
#import "Image.h"
#import "Header.h"

@interface InviteFriendViewController ()

@end

@implementation InviteFriendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        windowSize = [[UIScreen mainScreen] bounds];
        // Custom initialization
        self.view.backgroundColor = [UIColor whiteColor];
        Header *header = [[Header alloc]init];
        [header setTitle:@"友達招待"];
        
        [self.view addSubview:header];
        [self setBackBtnInHeader];

    }
    return self;
}

- (void)viewDidLoad
{
    UIWebView *wv = [[UIWebView alloc] init];
    wv.frame = CGRectMake(0, 77, windowSize.size.width, windowSize.size.height - 77);
    wv.backgroundColor = [UIColor whiteColor];
    wv.scrollView.scrollEnabled = NO;
    //wv.delegate = self;
    
    [self.view addSubview:wv];
    
    //NSURL *url = [NSURL URLWithString:@"http://localhost:3000/index/invite_friend"];
    //NSURLRequest *req = [NSURLRequest requestWithURL:url];
    //[wv loadRequest:req];
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"invite_friend" ofType:@"html"];
    //NSString *htmlStr = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"invite_friend" ofType:@"html"]];
    //[wv loadHTMLString:htmlStr baseURL: nil];
    
    [super viewDidLoad];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
    btn.frame = CGRectMake(15, 33, 20, 28);
    [btn setImage:imageResize forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backBtnClicked:)forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:btn];
}

- (void)backBtnClicked:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
