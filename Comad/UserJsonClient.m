//
//  UserJsonClient.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/15.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "UserJsonClient.h"
#import "AFHTTPClient.h"
#import "Basic.h"

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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *user = [defaults dictionaryForKey:@"user"];
    NSString *urlString = [NSString stringWithFormat:@"%@/api/user/get_add_friends?user_id=%@",HOST_URL, [user objectForKey:@"id"]];
    NSURL *url = [NSURL URLWithString: urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL: url];

    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        success(request, response, JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        int status = 404;
        failure(status, @"error");
    }];
    [operation start];
}

- (void)updateUserProfile:(NSDictionary *)params :(void (^)(AFHTTPRequestOperation *, NSHTTPURLResponse *, id))success failure:(void (^)(int, NSString *))failure {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/user/update_profile", HOST_URL]];
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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *user = [defaults dictionaryForKey:@"user"];
    NSString *urlString = [NSString stringWithFormat:@"%@/api/user/find_user?user_id=%@&comad_id=%@", HOST_URL,[user objectForKey:@"id"],idString];
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

@end
