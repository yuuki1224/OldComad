//
//  LoginViewController.m
//  Comad
//
//  Created by 浅野 友希 on 2013/10/28.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "LoginViewController.h"
#import "AFImageRequestOperation.h"
#import "BasicLabel.h"
#import "Basic.h"
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
    
    NSURL *url = [NSURL URLWithString: HOST_URL];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [wv loadRequest:req];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// 読み込みが開始された時
-(void)webViewDidStartLoad:(UIWebView*)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeBlack];
}

// 読み込みに失敗した時
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [SVProgressHUD dismiss];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"サーバーにアクセスできません。" message:@"ネットワークに繋がっていないか、サーバーが止まってます。" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

// 読み込みに成功した時
-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [SVProgressHUD dismiss];
 
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    NSString *json = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('user').getAttribute('data-user');"];
    NSString *status = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('status').getAttribute('data-status');"];
    
    if([status isEqualToString:@"200"]){
        NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] forKey:@"user"];
        NSDictionary *userInfo = [dict objectForKey:@"user"];

        //userDefaultに保存するように
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:userInfo forKey:@"user"];
        BOOL successful = [defaults synchronize];
        
        // 成功したら次の画面
        if (true) {
            [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeBlack];
            //画像のデータをこっちに持ってくる
            NSString *imageUrl = [NSString stringWithFormat:@"%@/images/profile/%@",HOST_URL,[userInfo objectForKey:@"image_name"]];
            NSURL *url = [NSURL URLWithString: imageUrl];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            TabBarController *tc = [[TabBarController alloc]init];
            UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
            rootViewController.modalPresentationStyle = UIModalPresentationFormSheet;
            rootViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            [self presentViewController:tc animated:YES completion:nil];
        }
    }
}

// あとで消す
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeBlack];
    TabBarController *tc = [[TabBarController alloc]init];
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    rootViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    rootViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:tc animated:YES completion:nil];
}

@end