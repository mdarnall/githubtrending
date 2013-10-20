//
//  GithubTrending
//
//  Created by Matt Darnall on 10/12/13.
//  Copyright (c) 2013 Matt Darnall. All rights reserved.
//


#import "GithubSearchClient.h"
#import "OHHTTPStubs.h"
#import "OHHTTPStubs+GithubAPI.h"

SpecBegin(GithubSearchClient)

    describe(@"GithubSearchClient", ^{

        __block GithubSearchClient *client;

        beforeAll(^{
        });

        beforeEach(^{
            client = [GithubSearchClient sharedClient];

        });

        describe(@"getTrendingRepositories", ^{

//            it(@"should make a request and return an array of results", ^AsyncBlock{

//                [OHHTTPStubs stubResponse:@"/search/repositories": @"search_response.json"];

//                [client getTrendingRepositories:^(NSArray *repositories, NSError * error){
//                    expect(repositories).to.haveCountOf(5);
//                    done();
//                }];

//            });

        });




    });

SpecEnd
