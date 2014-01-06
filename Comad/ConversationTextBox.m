//
//  ConversationTextBox.m
//  Comad
//
//  Created by 浅野 友希 on 2013/10/25.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "ConversationTextBox.h"
#import "RoundedButton.h"
#import "Image.h"
#import <QuartzCore/QuartzCore.h>

@implementation ConversationTextBox
@synthesize textView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGRect windowSize = [[UIScreen mainScreen] bounds];
        
        iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        if((int)iOSVersion == 7){
            self.frame = CGRectMake(0, windowSize.size.height - 55, windowSize.size.width, 55);
        }else if ((int)iOSVersion == 6){
            self.frame = CGRectMake(0, windowSize.size.height - 75, windowSize.size.width, 55);
        }
        
        UIView *backView = [[UIView alloc]init];
        if((int)iOSVersion == 7){
            backView.backgroundColor = [UIColor colorWithRed:0.067 green:0.067 blue:0.067 alpha:1.0];
        }else if((int)iOSVersion == 6){
            backView.backgroundColor = [UIColor colorWithRed:0.855 green:0.855 blue:0.827 alpha:1.0];
        }
        backView.frame = CGRectMake(0, 0, windowSize.size.width, 55);
        
        if((int)iOSVersion == 7){
            tf = [[UITextField alloc] initWithFrame:CGRectMake(55, 12, 200, 30)];
            tf.borderStyle = UITextBorderStyleRoundedRect;
            tf.delegate = self;
            tf.keyboardType = UIKeyboardTypeDefault;
            [backView addSubview: tf];
            
            UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            sendBtn.backgroundColor = [UIColor colorWithRed:0.067 green:0.067 blue:0.067 alpha:1.0];
            [sendBtn setTintColor:[UIColor whiteColor]];
            [sendBtn setFont:[UIFont fontWithName:@"HiraKakuProN-W3" size:12.0f]];
            [sendBtn setTitleEdgeInsets:UIEdgeInsetsMake(6, 0, 0, 0)];
            [sendBtn setTitle:@"送信" forState:UIControlStateNormal];
            sendBtn.frame = CGRectMake(windowSize.size.width - 63, 14, 40, 27);
            [sendBtn addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:sendBtn];
            
            RoundedButton *plus = [[RoundedButton alloc]initWithName:Plus];
            plus.frame = CGRectMake(12, 12, 31, 31);
            [plus addTarget:self action:@selector(plusTapped:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:plus];
        }else if((int)iOSVersion == 6){
            UIImage *textViewBackImage = [UIImage imageNamed:@"textField.png"];
            UIImageView *textViewBack = [[UIImageView alloc]initWithImage:textViewBackImage];
            textViewBack.frame = CGRectMake(48, 12, 207.5, 32.5);
            textViewBack.userInteractionEnabled = YES;
            textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, textViewBack.frame.size.width, textViewBack.frame.size.height)];
            textView.backgroundColor = [UIColor whiteColor];
            textView.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12.0f];
            textView.delegate = self;
            textView.layer.cornerRadius = 5;
            textView.clipsToBounds = true;
            [textViewBack addSubview: textView];
            
            UIImage *sendImage = [UIImage imageNamed:@"submit.png"];
            UIImageView *sendBtn = [[UIImageView alloc]initWithImage:sendImage];
            sendBtn.frame = CGRectMake(windowSize.size.width - 60, 12, 52.5, 31.5);
            UITapGestureRecognizer *sendTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sendClicked:)];
            [sendBtn addGestureRecognizer: sendTapGesture];
            sendBtn.userInteractionEnabled = YES;
            
            UIImage *addStampImage = [UIImage imageNamed:@"addStampButton.png"];
            UIImageView *addStampBtn = [[UIImageView alloc]initWithImage:addStampImage];
            addStampBtn.frame = CGRectMake(12, 12, 32, 33);
            UITapGestureRecognizer *addStampTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addStampClicked:)];
            [addStampBtn addGestureRecognizer:addStampTapGesture];
            addStampBtn.userInteractionEnabled = YES;
            
            [backView addSubview: textViewBack];
            [backView addSubview: sendBtn];
            [backView addSubview: addStampBtn];
        }
        
        [self addSubview: backView];
    }
    return self;
}

- (void)removeKeyBoard {
    CGRect windowSize = [[UIScreen mainScreen] bounds];
    [UIView animateWithDuration:0.0f
                     animations:^{
                         if((int)iOSVersion == 7){
                             self.frame = CGRectMake(0, windowSize.size.height - 55, windowSize.size.width, 55);
                         }else if ((int)iOSVersion == 6){
                             self.frame = CGRectMake(0, 405, windowSize.size.width, 55);
                         }
                     }];
    [self endEditing: YES];
}
/*
-(BOOL)textFieldShouldBeginEditing:(UITextField*)textField {
    CGRect windowSize = [[UIScreen mainScreen] bounds];
    [UIView animateWithDuration:0.35f
                     animations:^{
                         if((int)iOSVersion == 7){
                             self.frame = CGRectMake(0, windowSize.size.height - 271, self.frame.size.width, self.frame.size.height);
                         }else if((int)iOSVersion == 6){
                             self.frame = CGRectMake(0, windowSize.size.height - 290, self.frame.size.width, self.frame.size.height);
                         }
                     }];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    CGRect windowSize = [[UIScreen mainScreen] bounds];
    [UIView animateWithDuration:0.0f
                     animations:^{
                         if((int)iOSVersion == 7){
                             self.frame = CGRectMake(0, windowSize.size.height - 55, windowSize.size.width, 55);
                         }else if ((int)iOSVersion == 6){
                             self.frame = CGRectMake(0, windowSize.size.height - 75, windowSize.size.width, 55);
                         }
                     }];
    [tf resignFirstResponder];
    return YES;
}
*/
#pragma TextView Delegate
-(BOOL)textViewShouldBeginEditing:(UITextView*)textView {
    return YES;
}
-(BOOL)textViewShouldEndEditing:(UITextView*)textView {
    CGRect windowSize = [[UIScreen mainScreen] bounds];
    [UIView animateWithDuration:0.0f
                     animations:^{
                         if((int)iOSVersion == 7){
                             self.frame = CGRectMake(0, windowSize.size.height - 55, windowSize.size.width, 55);
                         }else if ((int)iOSVersion == 6){
                             self.frame = CGRectMake(0, 405, windowSize.size.width, 55);
                         }
                     }];
    [tf resignFirstResponder];
    return YES;
}

- (void) textViewDidChange: (UITextView*) text {
    NSRange searchResult = [text.text rangeOfString:@"\n"];
    if(searchResult.location != NSNotFound){
        text.text = [text.text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        [text resignFirstResponder];
    }
}

//keyboardの大きさ取得
-(void)keyboardWillShow:(NSNotification*)note {
    CGRect keyboardFrameEnd = [[note.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGRect windowSize = [[UIScreen mainScreen] bounds];
    [UIView animateWithDuration:0.35f
                     animations:^{
                         if((int)iOSVersion == 7){
                             self.frame = CGRectMake(0, windowSize.size.height - keyboardFrameEnd.size.height, self.frame.size.width, self.frame.size.height);
                         }else if((int)iOSVersion == 6){
                             self.frame = CGRectMake(0, windowSize.size.height - keyboardFrameEnd.size.height - 75, self.frame.size.width, self.frame.size.height);
                         }
                     }];
}

-(void)send:(UIButton *)btn {
    [self.delegate sendClicked: tf.text];
    tf.text = @"";
}

-(void)plusTapped:(UIButton *)button {
    [self.delegate plusClicked];
}

-(void)sendClicked:(UITapGestureRecognizer *)sender {
    [self.delegate sendClicked:textView.text];
    textView.text = @"";
}

-(void)addStampClicked:(UITapGestureRecognizer *)sender {
    [self.delegate plusClicked];
}

@end
