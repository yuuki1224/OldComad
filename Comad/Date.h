//
//  Date.h
//  Comad
//
//  Created by 浅野 友希 on 2013/11/15.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Date : NSObject
+(NSDate *) modifyDateString:(NSString *)dateString;
+(NSString *) timeRangeStringFromDate:(NSDate *)start_time end_time:(NSDate *)end_time;
@end
