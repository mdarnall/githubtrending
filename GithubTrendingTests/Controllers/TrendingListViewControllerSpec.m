#import <OCMock/OCMockObject.h>
#import <OCMock/OCMArg.h>
#import "TrendingTableViewController.h"
#import "TrendingTableViewDataSource.h"
#import "TrendingRepositories.h"
#import "GithubSearchClient.h"

SpecBegin(TrendingListViewController)

    describe(@"TrendingTableViewController", ^{

        __block TrendingTableViewController *controller;
        __block UINavigationController *navigationController;
        __block TrendingRepositories *model;
        __block id apiClient;


        beforeEach(^{
            model = [[TrendingRepositories alloc] init];
            apiClient = [OCMockObject niceMockForClass:[GithubSearchClient class]];
            controller = [[TrendingTableViewController alloc]initWithModel:model apiClient:apiClient];
            navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
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

            it(@"has a menu outlet", ^{
                [controller view] ;
                expect(controller.menu).toNot.beNil();
            });

            it(@"has a action for the navigation left bar button", ^{
                [controller view];
                UIBarButtonItem *leftButton = controller.navigationItem.leftBarButtonItem;
                expect([leftButton action]).to.equal(@selector(toggleMenu));               

            });
            
            it(@"has a title", ^{
                [controller view];
                expect(controller.title).to.equal(@"Trending Repositories");
            });

            describe(@"tableView dataSource", ^{
                it(@"sets up the table view data source", ^{
                    [controller view];
                    expect(controller.tableView.dataSource).to.beKindOf([TrendingTableViewDataSource class]);
                });

                it(@"sets up the datasource with it's model", ^{
                    [controller view];
                    TrendingTableViewDataSource *dataSource = (TrendingTableViewDataSource *) controller.tableView.dataSource;
                    expect(dataSource.repositories).to.equal(model);
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