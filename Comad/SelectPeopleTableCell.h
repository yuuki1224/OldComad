//
//  SelectPeopleTableCell.h
//  Comad
//
//  Created by 浅野 友希 on 2013/11/21.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectPeopleTableCell : UITableViewCell {
    CGRect windowSize;
}
//@property (nonatomic)BOOL selected;
@property (nonatomic, retain)NSDictionary *userInfo;

- (void)setImageAndName;
@end
