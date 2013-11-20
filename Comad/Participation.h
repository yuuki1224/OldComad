//
//  Participation.h
//  Comad
//
//  Created by 浅野 友希 on 2013/10/25.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Participation : UIView {
    UIView *content;
}

@property (nonatomic, retain) NSDictionary *comadInfo;
@property (nonatomic, assign) int attendPersonNum;

- (void)setTitle:(NSString *)title;
- (void)setContent:(NSString *)content;
@end
