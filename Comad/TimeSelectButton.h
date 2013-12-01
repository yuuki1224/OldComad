//
//  TimeSelectButton.h
//  Comad
//
//  Created by 浅野 友希 on 2013/12/02.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeSelectButton : UIView {
    UIImage *onNowImage;
    UIImage *offNowImage;
    UIImage *onTodayImage;
    UIImage *offTodayImage;
    UIImage *onTommorowImage;
    UIImage *offTommorowImage;
    UIImage *onFutureImage;
    UIImage *offFutureImage;
    UIImage *onAnytimeImage;
    UIImage *offAnytimeImage;
    
    UIImageView *nowImageView;
    UIImageView *todayImageView;
    UIImageView *tommorowImageView;
    UIImageView *futureImageView;
    UIImageView *anytimeImageView;
}

@end
