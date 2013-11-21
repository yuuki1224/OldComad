//
//  CreateGroupViewController.h
//  Comad
//
//  Created by 浅野 友希 on 2013/10/14.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectPeopleView.h"

@interface CreateGroupViewController : UIViewController<UITextFieldDelegate, SelectPeopleViewDelegate> {
    CGRect windowSize;
    UITextField *tv;
    UIView *addFriendIntoGroup;
    SelectPeopleView *selectPeopleView;
    int memberLabelWidth;
    int memberLabelHeight;
}

- (void)configure;
- (void)addFriendTapped:(UITapGestureRecognizer *)sender;
@end
