#import <OCMock/OCMockObject.h>
#import <OCMock/OCMArg.h>
#import "TrendingListViewController.h"
#import "TrendingTableViewDataSource.h"
#import "TrendingRepositories.h"
#import "GithubSearchClient.h"

SpecBegin(TrendingListViewController)

    describe(@"TrendingListViewController", ^{

        __block TrendingListViewController *controller;
        __block TrendingRepositories *model;
        __block id apiClient;


        beforeEach(^{
            model = [[TrendingRepositories alloc] init];
            apiClient = [OCMockObject niceMockForClass:[GithubSearchClient class]];
            controller = [[TrendingListViewController alloc]initWithModel:model apiClient:apiClient];

        });

        describe(@"view", ^{

            it(@"has a view outlet", ^{
                UIView * view = [controller view];
                expect(view).toNot.beNil();
            });

            it(@"has a tableview outlet", ^{
                [controller view];
                expect(controller.tableView).toNot.beNil();
            });

            describe(@"tableView dataSource", ^{
                it(@"sets up the table view data source", ^{
                    [controller view];
                    expect(controller.tableView.dataSource).to.beKindOf([TrendingTableViewDataSource class]);
                });

                it(@"sets up the datasource with it's model", ^{
                    [controller view];
                    TrendingTableViewDataSource *dataSource = (TrendingTableViewDataSource *) controller.tableView.dataSource;
                    expect(dataSource.repositories).toNot.beNil();
                });
            });

        });

        describe(@"viewWillAppear", ^{

            it(@"should subscribe with the notification center for model updates", ^{

                id aMock = [OCMockObject partialMockForObject:[NSNotificationCenter defaultCenter]];

                [[aMock expect] addObserver:controller
                                   selector:[OCMArg anySelector]
                                       name:TrendingRepositoriesItemsChanged
                                     object:model];

                [controller viewWillAppear:YES];

                [aMock verify];
                [aMock stopMocking];

            });

            it(@"should load and set the initial model data", ^{

                model.items = @[];

                // stub the call to getTrendingRepositories in the APIClient
                [[apiClient stub] getTrendingRepositories:[OCMArg checkWithBlock:^BOOL(id param){
                    void (^passedBlock)(NSArray *, NSError *) = param;
                    passedBlock(@[@"", @""], nil);
                    return YES;
                }]];

                [controller viewWillAppear:YES];

                expect(model.items).to.haveCountOf(2);

            });

        });

    });


SpecEnd