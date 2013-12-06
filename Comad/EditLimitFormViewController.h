//
//  EditLimitFormViewController.h
//  Comad
//
//  Created by 浅野 友希 on 2013/11/03.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditLimitFormDelegate;

@interface EditLimitFormViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource> {
    CGRect windowSize;
    UIPickerView *picker;
    UITableView *limitTable;
}
@property(nonatomic) int limit;
@property (nonatomic, weak) id<EditLimitFormDelegate> delegate;

- (void)configure;
@end

@protocol EditLimitFormDelegate <NSObject>
- (void)changeLimit:(int)limitNum;
@end