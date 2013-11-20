//
//  Bubble.h
//  Comad
//
//  Created by 浅野 友希 on 2013/11/10.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicLabel.h"

typedef enum : NSInteger{
    Left = 0,
    Right
}BubbleSide;

@interface Bubble : UIView {
    CGRect windowSize;
    BasicLabel *nameLabel;
    BasicLabel *timeLabel;
}
@property (nonatomic, retain)NSString *userName;
@property (nonatomic, retain)NSString *mail;
@property (nonatomic)BubbleSide side;

- (id)initWithName:(BubbleSide)name;
@end
