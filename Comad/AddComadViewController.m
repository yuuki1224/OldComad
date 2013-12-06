//
//  AddComadViewController.m
//  Comad
//
//  Created by 浅野 友希 on 2013/12/01.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "AddComadViewController.h"
#import "AddComadViewController+View.m"
#import "Header.h"
#import "Image.h"
#import "RoundedButton.h"
#import "ComadJsonClient.h"
#import "SVProgressHUD.h"

@interface AddComadViewController ()

@end

@implementation AddComadViewController

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
        [header setBackBtn];
        header.delegate = self;
        
        [self.view addSubview:header];
        
        if((int)iOSVersion == 7){
            RoundedButton *button = [[RoundedButton alloc] initWithName:HeaderDone];
            [button setTitleInButton:@"作成"];
            button.frame = CGRectMake(windowSize.size.width - 60, 37, 48, 28);
            //[button addTarget:self action:@selector(saveClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
        }else if((int)iOSVersion == 6){
            UIImage *buttonImage = [UIImage imageNamed:@"addComadButtonForiOS6.png"];
            UIImageView *createButton = [[UIImageView alloc]initWithImage:buttonImage];
            createButton.frame = CGRectMake(windowSize.size.width - 52.5, 10, 42.5, 28.5);
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(saveClicked:)];
            [createButton addGestureRecognizer: tapGesture];
            createButton.userInteractionEnabled = YES;
            [self.view addSubview: createButton];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [self configure];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) textViewDidChange: (UITextView*) text {
    int wordLength = text.text.length;
    wordCount.text = [NSString stringWithFormat:@"%d/30", 30 - wordLength];
    [wordCount sizeToFit];
    wordCount.frame = CGRectMake(tv.frame.size.width - wordCount.frame.size.width - 15, tv.frame.size.height - wordCount.frame.size.height, wordCount.frame.size.width, wordCount.frame.size.height);
    NSRange searchResult = [text.text rangeOfString:@"\n"];
    if(searchResult.location != NSNotFound){
        text.text = [text.text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        [text resignFirstResponder];
    }
}

- (void)saveClicked:(UITapGestureRecognizer *)sender {
    ComadJsonClient *client = [ComadJsonClient sharedClient];
    [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeBlack];
    
    NSString *text = tv.text;
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    //NSString *startTime = [format stringFromDate:];
    NSString *startTimeParam = datetime.text;
    NSString *locationParam = location.text;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *user = [defaults dictionaryForKey:@"user"];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [user objectForKey:@"id"], @"user_id",
                            startTimeParam, @"start_time",
                            locationParam, @"location",
                            text, @"detail",
                            timeSelect.select, @"timeSelect",nil];
    
    [client createNewComad:(NSDictionary *)params :^(AFHTTPRequestOperation *operation, NSHTTPURLResponse *response, id responseObject) {
        [SVProgressHUD dismiss];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(int statusCode, NSString *errorString) {
        // 生成と同時に各種設定も完了させる例
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"お知らせ" message:@"コマドを作成しました" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [SVProgressHUD dismiss];
        [alert show];
    }];
}

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    BOOL tweet = tweetButton.tweet;
    NSString *title = tv.text;
    
    //tweetがtrueのとき
    if(tweet){
        SLComposeViewController *twitterPostVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        void (^completion) (SLComposeViewControllerResult result) = ^(SLComposeViewControllerResult result) {
                //[composeViewController dismissViewControllerAnimated:YES completion:nil];
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    [self.delegate created];
                    [self dismissViewControllerAnimated:YES completion:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                    break;
                case SLComposeViewControllerResultDone:
                    [self.delegate created];
                    [self dismissViewControllerAnimated:YES completion:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                    break;
                default:
                    break;
                }
        };
        [twitterPostVC setCompletionHandler:completion];
        if([title isEqualToString:@""]){
            title = @"タイトルなし";
        }
        NSString *tweetStatement = [NSString stringWithFormat:@"%@ http://54.199.53.137:3000/comad/%d COMAD（コマド）#Comad", title, 100];
        [twitterPostVC setInitialText:tweetStatement];
        [self presentViewController:twitterPostVC animated:YES completion:nil];
    //tweetがfalseの時
    }else {
        [self.delegate created];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma HeaderDelagete methods
- (void)backBtnClickedDelegate {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma EditTimeFormViewController Delegate
- (void)changeTime:(NSDate *)time {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString* dateString = [outputFormatter stringFromDate:time];
    datetime.text = dateString;
    [datetime sizeToFit];
    datetime.frame = CGRectMake((150-datetime.frame.size.width)/2, 4, datetime.frame.size.width, datetime.frame.size.height);
}

#pragma EditLoacationFormViewController Delegate
- (void)changeLocation:(NSString *)changeLocation {
    location.text = changeLocation;
    [location sizeToFit];
    location.frame = CGRectMake((150-location.frame.size.width)/2, 4, location.frame.size.width, location.frame.size.height);
}
@end
