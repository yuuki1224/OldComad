//
//  IdSearchViewController.h
//  Comad
//
//  Created by 浅野 友希 on 2013/11/17.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface IdSearchViewController : UIViewController<UITextFieldDelegate, UIAlertViewDelegate, HeaderDelegate> {
    float iOSVersion;
    UITextField *tv;
    CGRect windowSize;
    UIView *addFriendView;
}
@property (nonatomic)int addFriendID;

- (void)configure;
@end
