//
//  SelectPeopleView.h
//  Comad
//
//  Created by 浅野 友希 on 2013/11/21.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectPeopleTable.h"

@protocol SelectPeopleViewDelegate;

@interface SelectPeopleView : UIView {
    CGRect windowSize;
}
@property (nonatomic, retain)SelectPeopleTable *table;
@property (nonatomic, weak) id<SelectPeopleViewDelegate> delegate;

- (void)setHeader;
- (void)setSearchBar;
- (void)setTable;
- (void)setFooter;
@end

@protocol SelectPeopleViewDelegate <NSObject>
- (void)inviteButtonDelegate;
- (void)cancelButtonDelegate;
@end
