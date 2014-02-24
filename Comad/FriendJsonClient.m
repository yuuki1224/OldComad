//
//  FriendJsonClient.m
//  Comad
//
//  Created by 浅野 友希 on 2013/10/17.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "FriendJsonClient.h"
#import "Basic.h"

@interface FriendJsonClient()
@end

@implementation FriendJsonClient

static FriendJsonClient* _sharedClient;
+ (FriendJsonClient *) sharedClient
{
    if (!_sharedClient) {
        _sharedClient = [[FriendJsonClient alloc] init];
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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *user = [defaults dictionaryForKey:@"user"];
    NSString *urlString = [NSString stringWithFormat:@"%@/api/friends/get_friends_list?user_id=%@", HOST_URL, [user objectForKey:@"id"]];
    NSURL *url = [NSURL URLWithString: urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success: ^(NSURLRequest *req, NSHTTPURLResponse *response, id JSON) {
        success(req, response, JSON);
    }
        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            NSLog(@"prcessing2");
            int status = 404;
            failure(status, @"error");
    }];
    [operation start];
}

- (void)addFriend:(int)comadId friendId:(int)friendId success:(void (^)(AFHTTPRequestOperation *, NSHTTPURLResponse *, id))success failure:(void (^)(int, NSString *))failure {
    NSString *urlString = [NSString stringWithFormat:@"%@/api/friends/add_friend?user_id=%i&friend_id=%i", HOST_URL, comadId, friendId];
    NSURL *url = [NSURL URLWithString: urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success: ^(NSURLRequest *req, NSHTTPURLResponse *response, id JSON) {
        success(req, response, JSON);
    }
        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            int status = 404;
            failure(status, @"error");
    }];
    [operation start];
}

- (void)blockPerson:(int)comadId personId:(int)personId success:(void (^)(AFHTTPRequestOperation *, NSHTTPURLResponse *, id))success failure:(void (^)(int, NSString *))failure {
    NSString *urlString = [NSString stringWithFormat:@"%@/api/friends/block_person?user_id=%i&friend_id=%i", HOST_URL, comadId, personId];
    NSURL *url = [NSURL URLWithString: urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success: ^(NSURLRequest *req, NSHTTPURLResponse *response, id JSON) {
        success(req, response, JSON);
    }
        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            int status = 404;
            failure(status, @"error");
    }];
    [operation start];
}
@end
