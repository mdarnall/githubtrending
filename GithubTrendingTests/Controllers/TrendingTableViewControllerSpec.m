#import <OCMock/OCMockObject.h>
#import <OCMock/OCMArg.h>
#import "TrendingTableViewController.h"
#import "TrendingTableViewDataSource.h"
#import "TrendingRepositories.h"
#import "GithubSearchClient.h"

SpecBegin(TrendingTableViewController)

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

            __block UIView *view;

            beforeEach(^{
                view = [controller view];
            });

            it(@"has a view outlet", ^{
                expect(view).toNot.beNil();
            });

            it(@"has a tableview outlet", ^{
                expect(controller.tableView).toNot.beNil();
            });

            it(@"has a menu outlet", ^{
                expect(controller.menu).toNot.beNil();
            });

            it(@"creates an action for the navigation left bar button", ^{
                // get a reference to to the left bar button
                UIBarButtonItem *leftButton = controller.navigationItem.leftBarButtonItem;
                expect([leftButton action]).to.equal(@selector(toggleMenu));
            });

            describe(@"viewDidLoad initialization", ^{

                it(@"initializes a title for the controller", ^{
                    expect(controller.title).to.equal(@"Trending Repositories");
                });

                it(@"sets up the table view data source", ^{
                    expect(controller.tableView.dataSource).to.beKindOf([TrendingTableViewDataSource class]);
                });

                it(@"sets up the datasource with it's model", ^{
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

            it(@"should set the initial model data", ^{

                // set our initial state
                model.items = @[];

                // stub the call to getTrendingRepositories in the APIClient
                [[apiClient stub] getTrendingRepositories:[OCMArg any] callBack:[OCMArg checkWithBlock:^BOOL(id param) {
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