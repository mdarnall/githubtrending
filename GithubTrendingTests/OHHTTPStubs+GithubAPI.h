//
// Created by Matt Darnall on 10/16/13.
// Copyright (c) 2013 Matt Darnall. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "OHHTTPStubs.h"

@interface OHHTTPStubs (GithubAPIStubs)

+(void) stubResponseWithStatusCode:(NSString *) path :(NSString*) responseFilename : (int) statusCode;
+(void) stubResponse:(NSString *)path:(NSString *)responseFilename;

@end