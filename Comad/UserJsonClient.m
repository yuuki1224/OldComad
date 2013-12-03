//
//  UserJsonClient.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/15.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "UserJsonClient.h"
#import "AFHTTPClient.h"

@implementation UserJsonClient
static UserJsonClient* _sharedClient;
+ (UserJsonClient *) sharedClient
{
    if (!_sharedClient) {
        _sharedClient = [[UserJsonClient alloc] init];
    }
    return _sharedClient;
}

- (void)getAddFriendInfo:(void (^)(AFHTTPRequestOperation *, NSHTTPURLResponse *, id))success failure:(void (^)(int, NSString *))failure {
    NSURL *url = [NSURL URLWithString:@"http://54.199.53.137:3000/api/user/get_add_friends?user_id=1"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        success(request, response, JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        int status = 404;
        failure(status, @"error");
    }];
    [operation start];
}

- (void)updateUserProfile:(NSDictionary *)params :(void (^)(AFHTTPRequestOperation *, NSHTTPURLResponse *, id))success failure:(void (^)(int, NSString *))failure {
    NSLog(@"processing 1");
    NSURL *url = [NSURL URLWithString:@"http://54.199.53.137:3000/api/user/update_profile"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc]initWithBaseURL:url];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"PUT" path:@"/api/user/update_profile" parameters:params];
    NSLog(@"procession 2");
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        success(request, response, JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        int status = 404;
        failure(status, @"error");
    }];
    [operation start];
}

- (void)findUserWithComadId:(NSString *)idString success:(void (^)(AFHTTPRequestOperation *, NSHTTPURLResponse *, id))success failure:(void (^)(int, NSString *))failure {
    NSString *urlString = [NSString stringWithFormat:@"http://54.199.53.137:3000/api/user/find_user?user_id=10&comad_id=%@",idString];
    NSURL *url = [NSURL URLWithString: urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success: ^(NSURLRequest *req, NSHTTPURLResponse *response, id JSON) {
        success(req, response, JSON);
    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"prcessing2");
        int status = 404;
        failure(status, @"error");
    }];
    [operation start];
}

- (void)createGroup:(NSDictionary *)params success:(void (^)(AFHTTPRequestOperation *, NSHTTPURLResponse *, id))success failure:(void (^)(int, NSString *))failure {
    NSURL *url = [NSURL URLWithString:@"http://54.199.53.137:3000/api/group/create_group"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc]initWithBaseURL:url];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"/api/group/create_group" parameters:params];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        success(request, response, JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"prcessing2");
        int status = 404;
        failure(status, @"error");
    }];
    [operation start];
}

@end
