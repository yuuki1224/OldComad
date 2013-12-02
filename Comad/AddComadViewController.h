//
//  AddComadViewController.h
//  Comad
//
//  Created by 浅野 友希 on 2013/12/01.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicLabel.h"
#import "URBSegmentedControl.h"
#import "EditTimeFormViewController.h"
#import "EditLoacationFormViewController.h"

@interface AddComadViewController : UIViewController <EditTimeFormDelegate, EditLocationFormDelegate> {
    float iOSVersion;
    CGRect windowSize;
    BasicLabel *wordCount;
    UITextView *tv;
    BasicLabel *datetime;
    BasicLabel *location;
}

- (void)configure;
@end
