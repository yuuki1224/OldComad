//
//  UserJsonClient.h
//  Comad
//
//  Created by 浅野 友希 on 2013/11/15.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "AFJSONRequestOperation.h"

@interface UserJsonClient : AFJSONRequestOperation
+ (UserJsonClient *) sharedClient;

- (void)getAddFriendInfo:(void (^)(AFHTTPRequestOperation *operation, NSHTTPURLResponse *response, id responseObject))success
                    failure:(void (^)(int statusCode, NSString *errorString))failure;
- (void)updateUserProfile:(NSDictionary *)params :(void (^)(AFHTTPRequestOperation *operation, NSHTTPURLResponse *response, id responseObject))success failure:(void (^)(int statusCode, NSString *errorString))failure;
- (void)findUserWithComadId:(void (^)(AFHTTPRequestOperation *operation, NSHTTPURLResponse *response, id responseObject))success
                    failure:(void (^)(int statusCode, NSString *errorString))failure;
@end