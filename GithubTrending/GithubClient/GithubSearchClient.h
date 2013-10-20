//
// Created by Matt Darnall on 10/15/13.
// Copyright (c) 2013 Matt Darnall. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"


@interface GithubSearchClient : AFHTTPSessionManager

+ (GithubSearchClient *) sharedClient;

- (void)getTrendingRepositories:(void (^)(NSArray *, NSError *))completedBlock;


@end