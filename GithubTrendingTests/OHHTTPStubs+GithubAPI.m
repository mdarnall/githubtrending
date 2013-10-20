//
// Created by Matt Darnall on 10/16/13.
// Copyright (c) 2013 Matt Darnall. All rights reserved.
//


#import "OHHTTPStubs+GithubAPI.h"

@implementation OHHTTPStubs (GithubAPIStubs)


+(void) stubResponseWithStatusCode:(NSString *)path:(NSString*) responseFilename:(int)statusCode {
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.path isEqualToString: path];

    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {

        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(responseFilename,nil)
                                                statusCode:statusCode headers:@{@"Content-Type":@"application/json"}];
    }];
}

+(void) stubResponse:(NSString *)path:(NSString *)responseFilename {
    [OHHTTPStubs stubResponseWithStatusCode:path:responseFilename:200];

}


@end