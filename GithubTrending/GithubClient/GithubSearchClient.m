//
// Created by Matt Darnall on 10/15/13.
// Copyright (c) 2013 Matt Darnall. All rights reserved.
//


#import "GithubSearchClient.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "TrendingRepositories.h"

@interface GithubSearchClient()

@property (strong, nonatomic) NSDateFormatter * createdDateFormatter;

@end

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

- (void)getTrendingRepositories:(TrendingRepositories* )model callBack:(void (^)(NSArray *, NSError *))callBack {


    NSString *query = [NSString stringWithFormat:@"created:>%@",
                    [self.createdDateFormatter stringFromDate:model.createdDateFilter]];

    [self.requestSerializer setValue:@"application/vnd.github.preview" forHTTPHeaderField:@"Accept"];

    [self GET:@"/search/repositories"
     parameters:@{@"q": query, @"sort" : @"stars", @"order" : @"desc"}
        success:^(NSURLSessionDataTask *dataTask, id data) {

            NSArray *items = [data objectForKey:@"items"];
            callBack([items subarrayWithRange:NSMakeRange(0, 20)], nil);

        }
        failure:^(NSURLSessionDataTask *dataTask, NSError *error) {
            callBack(nil, error);
        }];

}

- (NSDateFormatter *)createdDateFormatter {
    if(_createdDateFormatter == nil){
        _createdDateFormatter = [[NSDateFormatter alloc] init];
        [_createdDateFormatter setDateFormat:@"yyyy-MM-dd"];
    }

    return _createdDateFormatter;
}


@end