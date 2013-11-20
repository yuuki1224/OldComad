//
//  ComadJsonClient.h
//  Comad
//
//  Created by 浅野 友希 on 2013/10/19.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "AFJSONRequestOperation.h"

@interface ComadJsonClient : AFJSONRequestOperation
+ (ComadJsonClient *) sharedClient;
// Friendの一覧を取得する
- (void)getIndexWhenSuccess:(void (^)(AFHTTPRequestOperation *operation, NSHTTPURLResponse *response, id responseObject))success
                    failure:(void (^)(int statusCode, NSString *errorString))failure;
- (void)createNewComad:(NSDictionary *)params :(void (^)(AFHTTPRequestOperation *operation, NSHTTPURLResponse *response, id responseObject))success failure:(void(^)(int statusCode, NSString *errorString))failure;
- (void)attendComad:(NSString *)userId :(NSString *)comadId :(void (^)(AFHTTPRequestOperation *, NSHTTPURLResponse *, id))success failure:(void (^)(int statusCode, NSString *errorString))failure;
@end
