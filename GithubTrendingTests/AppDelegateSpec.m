    //
//  AppDelegateSpec.m
//  GithubTrending
//
//  Created by Matt Darnall on 10/12/13.
//  Copyright (c) 2013 Matt Darnall. All rights reserved.
//

#import "GithubTrendingAppDelegate.h"
#import "TrendingListViewController.h"

    SpecBegin(AppDelegate)

describe(@"AppDelegate", ^{

    __block GithubTrendingAppDelegate *appDelegate;

    beforeAll(^{
    });
    
    beforeEach(^{
        appDelegate = [[GithubTrendingAppDelegate alloc] init];

    });

    describe(@"application:didFinishLaunchingWithOptions:", ^{

        beforeEach(^{
            [appDelegate application:nil didFinishLaunchingWithOptions:nil];
        });

        it(@"should set the root view controller", ^{
            expect(appDelegate.window.rootViewController).toNot.beNil();
            expect(appDelegate.window.rootViewController).to.beKindOf([TrendingListViewController class]);
        });

        
        
    });
    

});

SpecEnd
