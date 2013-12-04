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
        
        [self.view addSubview:header];
        [self setBackBtnInHeader];
        
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

- (void)setBackBtnInHeader {
    NSString *backImageName = @"";
    if((int)iOSVersion == 7){
        backImageName = @"back.png";
    }else if((int)iOSVersion == 6){
        backImageName = @"backForiOS6.png";
    }
    UIImage *image = [UIImage imageNamed:backImageName];
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

- (void) textViewDidChange: (UITextView*) text {
    NSLog(@"%d",text.text.length);
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
    NSString *selectTime = @"1";
    BOOL tweet = tweetButton.tweet;
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    //NSString *startTime = [format stringFromDate:];
    NSString *startTimeParam = datetime.text;
    NSString *locationParam = @"烏丸のスタバ";
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *user = [defaults dictionaryForKey:@"user"];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [user objectForKey:@"id"], @"user_id",
                            startTimeParam, @"start_time",
                            locationParam, @"location",
                            text, @"detail",
                            timeSelect.select, @"timeSelect",
                            tweet, @"tweetBool",nil];
    NSLog(@"params: %@", params);
    [client createNewComad:(NSDictionary *)params :^(AFHTTPRequestOperation *operation, NSHTTPURLResponse *response, id responseObject) {
        NSLog(@"%@", response);
        [SVProgressHUD dismiss];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(int statusCode, NSString *errorString) {
        NSLog(@"%@", errorString);
        
        // 生成と同時に各種設定も完了させる例
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"お知らせ" message:@"コマドを作成しました" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [SVProgressHUD dismiss];
        [alert show];
    }];
}

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.delegate created];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
