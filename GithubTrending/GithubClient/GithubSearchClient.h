//
// Created by Matt Darnall on 10/15/13.
// Copyright (c) 2013 Matt Darnall. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"

@class TrendingRepositories;


@interface GithubSearchClient : AFHTTPSessionManager

+ (GithubSearchClient *) sharedClient;

- (void)getTrendingRepositories:(TrendingRepositories *)model callBack:(void (^)(NSArray *, NSError *))callBack;


@end