//
//  Stamp.h
//  Comad
//
//  Created by 浅野 友希 on 2013/11/22.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicLabel.h"
#import "Basic.h"

@interface Stamp : UIView {
    CGRect windowSize;
    BasicLabel *nameLabel;
    BasicLabel *timeLabel;
}
@property (nonatomic, retain)NSString *userName;
@property (nonatomic)Side side;

- (id)initWithName:(Side)name;
- (void)setStamp:(NSString *)stampName conversationHeight:(int)conversationHeight;
@end
