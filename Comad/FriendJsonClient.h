//
//  FriendJsonClient.h
//  Comad
//
//  Created by 浅野 友希 on 2013/10/17.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "AFJSONRequestOperation.h"

@interface FriendJsonClient : AFJSONRequestOperation
+ (FriendJsonClient *) sharedClient;
// Friendの一覧を取得する
- (void)getIndexWhenSuccess:(void (^)(AFHTTPRequestOperation *operation, NSHTTPURLResponse *response, id responseObject))success
                    failure:(void (^)(int statusCode, NSString *errorString))failure;
- (void)addFriend:(int)comadId friendId:(int)friendId success:(void (^)(AFHTTPRequestOperation *operation, NSHTTPURLResponse *response, id responseObject))success
          failure:(void (^)(int statusCode, NSString *errorString))failure;
@end
