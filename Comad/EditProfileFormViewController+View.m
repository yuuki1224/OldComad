//
//  EditProfileFormViewController+View.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/05.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "EditProfileFormViewController.h"

@implementation EditProfileFormViewController (View)

-(void)configure {
    tv = [[UITextField alloc]init];
    tv.text = self.editText;
    [tv setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    tv.frame = CGRectMake((windowSize.size.width - 250)/2, 100, 250, 40);
    tv.clearButtonMode = UITextFieldViewModeWhileEditing;
    tv.borderStyle = UITextBorderStyleRoundedRect;
    tv.delegate = self;
    tv.keyboardType = UIKeyboardTypeDefault;
    [tv becomeFirstResponder];
    
    [self.view addSubview:tv];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    [tv resignFirstResponder];
    return YES;
}

@end
