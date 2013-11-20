//
//  Date.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/15.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "Date.h"

@implementation Date

+(NSDate *)modifyDateString:(NSString *)dateString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'.000Z'"];
    NSDate *date = [formatter dateFromString:dateString];
    return date;
}

+(NSString *)timeRangeStringFromDate:(NSDate *)start_time end_time:(NSDate *)end_time {
    NSString *timeRange = [[NSString alloc]init];
    NSDateFormatter *startTimeFormatter = [[NSDateFormatter alloc] init];
    NSDateFormatter *endTimeFormatter = [[NSDateFormatter alloc]init];
    
    [startTimeFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    [endTimeFormatter setDateFormat:@"HH:mm"];
    
    NSString *startTime = [startTimeFormatter stringFromDate: start_time];
    NSString *endTime = [endTimeFormatter stringFromDate: end_time];
    
    //文字列連結
    timeRange = [NSString stringWithFormat:@"%@〜%@", startTime, endTime];
    return timeRange;
}
@end
