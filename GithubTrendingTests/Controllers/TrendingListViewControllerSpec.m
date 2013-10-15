//
// Created by Matt Darnall on 10/13/13.
// Copyright (c) 2013 Matt Darnall. All rights reserved.
//


#import "TrendingListViewController.h"
#import "TrendingTableViewDataSource.h"

SpecBegin(TrendingListViewController)

    describe(@"TrendingListViewController", ^{


        __block TrendingListViewController *controller;

        beforeAll(^{
        });

        beforeEach(^{
            controller = [[TrendingListViewController alloc] init];
        });

        describe(@"viewDidLoad", ^{

            beforeEach(^{
                [controller viewDidLoad];
            });

            it(@"has a view outlet", ^{
                expect(controller.view).toNot.beNil();
            });

            it(@"sets up the table view data source", ^{
                expect(controller.tableView.dataSource).to.beKindOf([TrendingTableViewDataSource class]);
            });



        });


    });



SpecEnd