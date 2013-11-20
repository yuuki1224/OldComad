//
//  CreateComadViewController.h
//  Comad
//
//  Created by 浅野 友希 on 2013/11/03.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditTimeFormViewController.h"
#import "EditLoacationFormViewController.h"
#import "EditLocationStatusFormViewController.h"
#import "EditLimitFormViewController.h"

@interface CreateComadViewController : UIViewController <UITextViewDelegate, UITableViewDataSource, UITableViewDelegate, EditTimeFormDelegate, EditLocationFormDelegate, EditLocationStatusFormDelegate, EditLimitFormDelegate> {
    UITextView *textView;
    UITableView *createComadForm;
}

@property (nonatomic, retain) NSDate *fromTime;
@property (nonatomic, retain) NSDate *untilTime;
@property (nonatomic, retain) NSString *location;
@property (nonatomic, retain) NSString *detail;
@property (nonatomic) Whether *wifi;
@property (nonatomic) Whether *powerSource;
@property (nonatomic) NSInteger *limit;
@property (nonatomic) NSInteger *group;
@end
