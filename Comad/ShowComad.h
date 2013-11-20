//
//  ShowComad.h
//  Comad
//
//  Created by 浅野 友希 on 2013/10/24.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Participation.h"

@interface ShowComad : UIView {
    Participation *participationView;
}

@property (nonatomic, retain) NSDictionary *comadInfo;

- (void)setLabel;
@end
