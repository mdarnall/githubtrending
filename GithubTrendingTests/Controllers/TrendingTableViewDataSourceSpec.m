//
// Created by Matt Darnall on 10/13/13.
// Copyright (c) 2013 Matt Darnall. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "TrendingTableViewDataSource.h"
#import "TrendingRepositories.h"

SpecBegin(TrendingTableViewDataSource)

    describe(@"TrendingTableViewDataSource", ^{

        __block TrendingTableViewDataSource *dataSource;

        describe(@"UITableViewDataSource", ^{
            
            beforeEach(^{
                TrendingRepositories *repositories = [[TrendingRepositories alloc] init];
                repositories.items = @[@"", @"", @""];
                dataSource = [[TrendingTableViewDataSource alloc] init];
                dataSource.repositories = repositories;
            });

            it(@"should conform to the UITableViewDataSource", ^{
                expect([dataSource conformsToProtocol:@protocol(UITableViewDataSource)]).to.beTruthy();
            });

            it(@"should return one table section", ^{
                expect([dataSource numberOfSectionsInTableView:nil]).to.equal(1);
            });

            it(@"should return the number of rows based on the item count in the model", ^{
                expect([dataSource tableView:nil numberOfRowsInSection:0]).to.equal(3);
            });
        });

    });



SpecEnd