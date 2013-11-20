//
//  EditLocationStatusFormViewController.h
//  Comad
//
//  Created by 浅野 友希 on 2013/11/03.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Basic.h"

@protocol EditLocationStatusFormDelegate;

@interface EditLocationStatusFormViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate> {
    CGRect windowSize;
    UIPickerView *picker;
    UITableView *locationStatusTable;
}

@property (nonatomic, weak) id<EditLocationStatusFormDelegate> delegate;
@property (nonatomic) StatusSelected selected;
@property (nonatomic) Whether wifi;
@property (nonatomic) Whether powerSource;
- (void)configure;
@end

@protocol EditLocationStatusFormDelegate <NSObject>
- (void)changeStatus:(Whether)wifiStatus powerSourceStatus:(Whether)powerSourceStatus;
@end
