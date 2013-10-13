//
// Created by Matt Darnall on 10/13/13.
// Copyright (c) 2013 Matt Darnall. All rights reserved.
//


#import "TrendingListViewController.h"

SpecBegin(TrendingListViewController)

    describe(@"TrendingListViewController", ^{


        __block TrendingListViewController *controller;

        beforeAll(^{
        });

        beforeEach(^{
            controller = [[TrendingListViewController alloc] init];
        });

        describe(@"viewDidLoad", ^{

            it(@"has a view outlet", ^{
                expect(controller.view).toNot.beNil();
            });

            it(@"sets the table view delegate", ^{
                expect(controller.tableView.delegate).to.beKindOf([TrendingTableViewDataSource class]);
            });



        });


    });



SpecEnd