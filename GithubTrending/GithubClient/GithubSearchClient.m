//
// Created by Matt Darnall on 10/15/13.
// Copyright (c) 2013 Matt Darnall. All rights reserved.
//


#import "GithubSearchClient.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"

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

- (void)getTrendingRepositories:(void (^)(NSArray *, NSError *))completedBlock {

    NSDate * createdDate = [[NSDate alloc] init];
    NSString *query = [NSString stringWithFormat:@"created:>%@", [self.createdDateFormatter stringFromDate:createdDate]];

    [self.requestSerializer setValue:@"application/vnd.github.preview" forHTTPHeaderField:@"Accept"];

    [self GET:@"/search/repositories"
     parameters:@{@"q": query, @"sort" : @"stars", @"order" : @"desc"}
        success:^(NSURLSessionDataTask *dataTask, id data) {

            NSArray *items = [data objectForKey:@"items"];
            completedBlock([items subarrayWithRange:NSMakeRange(0, 10)], nil);

        }
        failure:^(NSURLSessionDataTask *dataTask, NSError *error) {
            completedBlock(nil, error);
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