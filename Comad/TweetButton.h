//
//  TweetButton.h
//  Comad
//
//  Created by 浅野 友希 on 2013/12/02.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetButton : UIView {
    UIImage *onBackResize;
    UIImage *offBackResize;
    UIImage *onCoverResize;
    UIImage *offCoverResize;
    UIImageView *backView;
    UIImageView *coverView;
}

@property (nonatomic)BOOL tweet;
@end
