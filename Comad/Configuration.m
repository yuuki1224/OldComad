//
//  Configuration.m
//  Comad
//
//  Created by 浅野 友希 on 2013/12/22.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "Configuration.h"

@implementation Configuration
static NSString *CONFIGURATION_NAME = @"user";
static NSString *CONFIGURATION_FRIENDS = @"friends";
+ (NSDictionary *)user {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //[userDefaults registerDefaults:@{CONFIGURATION_NAME : @"No User"}];
    return [userDefaults objectForKey:CONFIGURATION_NAME];
}
+ (void)setUser:(NSDictionary *)value {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:CONFIGURATION_NAME];
}
+ (void)removeUser {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:CONFIGURATION_NAME];
}
+ (NSArray *)friends {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults registerDefaults:@{CONFIGURATION_FRIENDS : @"No Friends"}];
    return [userDefaults objectForKey:CONFIGURATION_FRIENDS];
}
+ (void)setFriends:(NSArray *)value {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:CONFIGURATION_FRIENDS];
}
+ (BOOL)synchronize {
    return [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
