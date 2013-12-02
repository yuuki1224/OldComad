//
//  BlackMask.h
//  Comad
//
//  Created by 浅野 友希 on 2013/10/15.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BlackMaskDelegate;

@interface BlackMask : UIView

@property (nonatomic, weak) id<BlackMaskDelegate> delegate;
@end

@protocol BlackMaskDelegate <NSObject>
-(void)blackMaskTapped;
@end
