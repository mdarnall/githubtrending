//
// Created by Matt Darnall on 10/13/13.
// Copyright (c) 2013 Matt Darnall. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "TrendingTableViewDataSource.h"

SpecBegin(TrendingTableViewDataSource)

    describe(@"TrendingTableViewDataSource", ^{

        __block TrendingTableViewDataSource *dataSource;

        beforeAll(^{
        });

        beforeEach(^{
            dataSource = [[TrendingTableViewDataSource alloc] init];
        });


        it(@"should conform to the UITableViewDataSource", ^{
            expect([dataSource conformsToProtocol:@protocol(UITableViewDataSource)]).to.beTruthy();
        });

        describe(@"UITableViewDataSource", ^{
            
            beforeEach(^{
                
            });

            it(@"should return the number of sections", ^{
                expect([dataSource numberOfSectionsInTableView:nil]).to.equal(1);
            });

            it(@"should return the number of rows", ^{

                expect([dataSource tableView:nil numberOfRowsInSection:1]).to.equal(3);
            });
        });

    });



SpecEnd