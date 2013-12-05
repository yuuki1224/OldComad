//
//  LoginViewController.m
//  Comad
//
//  Created by 浅野 友希 on 2013/10/28.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "LoginViewController.h"
#import "BasicLabel.h"
#import "Image.h"
#import "SVProgressHUD.h"
#import "TabBarController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        windowSize = [[UIScreen mainScreen] bounds];
        self.view.frame = CGRectMake(0, 0, windowSize.size.width, windowSize.size.height);
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    UIWebView *wv = [[UIWebView alloc] init];
    wv.frame = CGRectMake(0, 0, windowSize.size.width, windowSize.size.height);
    wv.backgroundColor = [UIColor whiteColor];
    wv.scrollView.scrollEnabled = NO;
    wv.delegate = self;
    
    [self.view addSubview:wv];

    NSURL *url = [NSURL URLWithString:@"http://54.199.53.137:3000"];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [wv loadRequest:req];
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(void)webViewDidStartLoad:(UIWebView*)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeBlack];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [SVProgressHUD dismiss];
 
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    //[webView stringByEvaluatingJavaScriptFromString:@"alert(1);"];
    //NSString *json = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('user').getAttribute('data-user');"];
    NSString *status = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('status').getAttribute('data-status');"];
    NSString *location = [webView stringByEvaluatingJavaScriptFromString:@"document.location.origin"];
    if(![location isEqualToString:@"http://54.199.53.137:3000"] || [status isEqualToString:@"200"]){
        /*
        NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] forKey:@"user"];
        NSDictionary *userInfo = [dict objectForKey:@"user"];

        //userDefaultに保存するように
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:userInfo forKey:@"user"];
        BOOL successful = [defaults synchronize];
         */
        if (true) {
            [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeBlack];
            TabBarController *tc = [[TabBarController alloc]init];
            UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
            rootViewController.modalPresentationStyle = UIModalPresentationFormSheet;
            rootViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            [self presentViewController:tc animated:YES completion:nil];
        }
    }
}

@end