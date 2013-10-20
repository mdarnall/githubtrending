//
// Created by Matt Darnall on 10/15/13.
// Copyright (c) 2013 Matt Darnall. All rights reserved.
//


#import "GithubSearchClient.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"


@implementation GithubSearchClient

+ (GithubSearchClient *)sharedClient {
    static GithubSearchClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[GithubSearchClient alloc] initWithBaseURL:
                [NSURL URLWithString:@"https://api.github.com"]];
    });

    return _sharedClient;
}

- (void)getTrendingRepositories:(void (^)(NSArray *, NSError *))completedBlock {


    [self.requestSerializer setValue:@"application/vnd.github.preview" forHTTPHeaderField:@"Accept"];

    [self
            GET:@"/search/repositories"
     parameters:@{@"q" : @"created:>2013-10-12", @"sort" : @"stars", @"order" : @"desc"}
        success:^(NSURLSessionDataTask *dataTask, id data) {

            NSArray *items = [data objectForKey:@"items"];
            completedBlock([items subarrayWithRange:NSMakeRange(0, 10)], nil);

        }
        failure:^(NSURLSessionDataTask *dataTask, NSError *error) {
            completedBlock(nil, error);
        }];

}

@end