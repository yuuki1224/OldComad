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
#import "Configuration.h"
#import "Toast+UIView.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.frame = CGRectMake(0, 0, SCREEN_BOUNDS.size.width, SCREEN_BOUNDS.size.height);
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    UIWebView *wv = [[UIWebView alloc] init];
    wv.frame = CGRectMake(0, 0, SCREEN_BOUNDS.size.width, SCREEN_BOUNDS.size.height);
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
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"サーバーにアクセスできません。" message:@"ネットワークに繋がっていないため現在コマドは利用できません。" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
        NSDictionary *saveUser = @{
                                   @"name": [userInfo objectForKey:@"name"],
                                   @"id": [userInfo objectForKey:@"id"],
                                   @"comad_id": [userInfo objectForKey:@"comad_id"],
                                   @"image_name": [userInfo objectForKey:@"image_name"],
                                   @"email":[userInfo objectForKey:@"email"],
                                   @"occupation": [userInfo objectForKey:@"occupation"],
                                   @"organization": [userInfo objectForKey:@"organization"],
                                   @"description":[userInfo objectForKey:@"description"]
                                   };
        [Configuration setUser: saveUser];
        BOOL successful = [Configuration synchronize];
        // 成功したら次の画面
        if (successful) {
            if(isOffline){
                [self.view makeToast:@"ネットワークにつながっていないため、現在コマドは利用できません。"];
            }else{
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
}

// あとで消す
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
}

@end