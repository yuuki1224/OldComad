//
//  ComadCell.h
//  Comad
//
//  Created by 浅野 友希 on 2013/10/17.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComadCell : UITableViewCell {
    CGRect windowSize;
}

@property (nonatomic, retain)NSDictionary *comadInfo;
- (void)setComadCell;
@end
