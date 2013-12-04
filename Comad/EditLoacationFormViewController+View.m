
//
//  EditLoacationFormViewController+View.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/11.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "EditLoacationFormViewController.h"

@implementation EditLoacationFormViewController (View)
- (void)configure {
    //textFieldを設置する。
    tf = [[UITextField alloc]initWithFrame:CGRectMake((windowSize.size.width - 300)/2, 100, 300, 30)];
    [tf setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    tf.borderStyle = UITextBorderStyleRoundedRect;
    tf.placeholder = @"場所は?";
    if(self.location){
        tf.text = self.location;
    }
    tf.clearButtonMode = UITextFieldViewModeAlways;
    tf.delegate = self;
    tf.keyboardType = UIKeyboardTypeDefault;
    [tf becomeFirstResponder];
    
    // 編集終了後フォーカスが外れた時にhogeメソッドを呼び出す
    //[tf addTarget:self action:@selector(hoge:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:tf];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    [tf resignFirstResponder];
    self.location = tf.text;
    return YES;
}
@end
