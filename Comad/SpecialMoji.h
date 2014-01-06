//
//  SpecialMoji.h
//  Comad
//
//  Created by 浅野 友希 on 2013/11/19.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SpecialMojiDelegate;

@interface SpecialMoji : UIView <UICollectionViewDelegate, UICollectionViewDataSource>{
    CGRect windowSize;
    float iOSVersion;
}

@property (nonatomic, weak) id<SpecialMojiDelegate> delegate;

@end

@protocol SpecialMojiDelegate <NSObject>
- (void)stampClickedDelegate:(int)stampNum;
@end
