//
//  Configuration.h
//  Comad
//
//  Created by 浅野 友希 on 2013/12/22.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Configuration : NSObject
+ (NSDictionary *)user;
+ (void)setUser:(NSDictionary *)value;
+ (void)removeUser;
+ (NSArray *)friends;
+ (void)setFriends:(NSArray *)value;
+ (BOOL)synchronize;
@end
