//
//  CreateComadFormCell.h
//  Comad
//
//  Created by 浅野 友希 on 2013/11/03.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSInteger{
    FromTime = 0,
    EndTime,
    Location,
    PowerSource,
    WiFi,
    Limit,
    Group
}CreateComadForm;
@interface CreateComadFormCell : UITableViewCell

@end
