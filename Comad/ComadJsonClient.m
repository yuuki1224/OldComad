//
//  ComadJsonClient.m
//  Comad
//
//  Created by 浅野 友希 on 2013/10/19.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "ComadJsonClient.h"
#import "AFHTTPClient.h"

@implementation ComadJsonClient

static ComadJsonClient* _sharedClient;
+ (ComadJsonClient *) sharedClient
{
    if (!_sharedClient) {
        _sharedClient = [[ComadJsonClient alloc] init];
    }
    return _sharedClient;
}

#pragma mark - Instance methods

- (id) init
{
    
    if (self = [super init]) {
        // initialize code
    }
    return self;
}

- (void)getIndexWhenSuccess:(void (^)(AFHTTPRequestOperation *, NSHTTPURLResponse *, id))success failure:(void (^)(int, NSString *))failure {
    NSURL *url = [NSURL URLWithString:@"http://54.199.53.137:3000/api/comads/get_comads_list?user_id=1"];
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

- (void)createNewComad:(NSDictionary *)params :(void (^)(AFHTTPRequestOperation *, NSHTTPURLResponse *, id))success failure:(void (^)(int, NSString *))failure {
    NSURL *url = [NSURL URLWithString:@"http://54.199.53.137:3000/api/comads/create_comad"];
    //NSURL *url = [NSURL URLWithString:@"http://localhost:3000/api/comads/create_comad"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc]initWithBaseURL:url];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"/api/comads/create_comad" parameters:params];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        success(request, response, JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"prcessing2");
        int status = 404;
        failure(status, @"error");
    }];
    [operation start];
}

- (void)attendComad:(NSString *)userId :(NSString *)comadId :(void (^)(AFHTTPRequestOperation *, NSHTTPURLResponse *, id))success failure:(void (^)(int, NSString *))failure {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://54.199.53.137:3000/api/comads/attend_comad?user_id=%@&comad_id=%@", userId ,comadId]];
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
