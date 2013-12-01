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

@interface AddComadViewController : UIViewController {
    float iOSVersion;
    CGRect windowSize;
    BasicLabel *wordCount;
    UITextView *tv;
}

- (void)configure;
@end
