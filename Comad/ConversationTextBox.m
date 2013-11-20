//
//  ConversationTextBox.m
//  Comad
//
//  Created by 浅野 友希 on 2013/10/25.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "ConversationTextBox.h"
#import "RoundedButton.h"

@implementation ConversationTextBox

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGRect windowSize = [[UIScreen mainScreen] bounds];
        self.frame = CGRectMake(0, windowSize.size.height - 55, windowSize.size.width, 55);
        UIView *backView = [[UIView alloc]init];
        backView.backgroundColor = [UIColor colorWithRed:0.067 green:0.067 blue:0.067 alpha:1.0];
        backView.frame = CGRectMake(0, 0, windowSize.size.width, 55);
        tf = [[UITextField alloc] initWithFrame:CGRectMake(55, 12, 200, 30)];
        tf.borderStyle = UITextBorderStyleRoundedRect;
        tf.delegate = self;
        [backView addSubview: tf];
        
        UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        sendBtn.backgroundColor = [UIColor colorWithRed:0.067 green:0.067 blue:0.067 alpha:1.0];
        [sendBtn setTintColor:[UIColor whiteColor]];
        [sendBtn setFont:[UIFont fontWithName:@"HiraKakuProN-W3" size:12.0f]];
        [sendBtn setTitle:@"送信" forState:UIControlStateNormal];
        sendBtn.frame = CGRectMake(windowSize.size.width - 63, 14, 40, 27);
        [sendBtn addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
        
        RoundedButton *plus = [[RoundedButton alloc]initWithName:Plus];
        plus.frame = CGRectMake(12, 12, 31, 31);
        [plus addTarget:self action:@selector(plusTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        [backView addSubview:sendBtn];
        [backView addSubview:plus];
        [self addSubview: backView];
    }
    return self;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField*)textField {
    CGRect windowSize = [[UIScreen mainScreen] bounds];
    [UIView animateWithDuration:0.35f
                     animations:^{
                         self.frame = CGRectMake(0, windowSize.size.height - 271, self.frame.size.width, self.frame.size.height);
                     
                     }];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    CGRect windowSize = [[UIScreen mainScreen] bounds];
    [UIView animateWithDuration:0.0f
                     animations:^{
                         self.frame = CGRectMake(0, windowSize.size.height - 55, self.frame.size.width, self.frame.size.height);
                     }];
    [tf resignFirstResponder];
    return YES;
}

-(void)send:(UIButton *)btn {
    [self.delegate sendClicked: tf.text];
    tf.text = @"";
}

-(void)plusTapped:(UIButton *)button {
    [self.delegate plusClicked];
}

@end
