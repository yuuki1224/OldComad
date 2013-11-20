//
//  Header.h
//  Comad
//
//  Created by 浅野 友希 on 2013/10/16.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeaderDelegate;

@interface Header : UIView {
}

@property (nonatomic, weak) id<HeaderDelegate> delegate;

- (void)setTitle:(NSString *)titleString;
- (void)setButton:(NSString *)btnImageName;
- (void)setBackBtn;
@end

@protocol HeaderDelegate <NSObject>
- (void)backBtnClickedDelegate;
@end
