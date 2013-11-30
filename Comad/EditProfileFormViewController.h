//
//  EditProfileFormViewController.h
//  Comad
//
//  Created by 浅野 友希 on 2013/11/04.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Basic.h"

@protocol EditProfileFormDelegate;

@interface EditProfileFormViewController : UIViewController<UITextFieldDelegate> {
    CGRect windowSize;
    float iOSVersion;
    UITextField *tv;
}
@property (nonatomic, weak) id<EditProfileFormDelegate> delegate;
@property (nonatomic)EditProfileCell cellType;
@property (nonatomic, retain)NSString *editText;

- (void)configure;
@end

@protocol EditProfileFormDelegate <NSObject>
- (void)doneClicked:(EditProfileCell)type text:(NSString *)text;
@end