#import <OCMock/OCMockObject.h>
#import <OCMock/OCMArg.h>
#import <REMenu/REMenu.h>
#import "TrendingTableViewController.h"
#import "TrendingTableViewDataSource.h"
#import "TrendingRepositories.h"
#import "GithubSearchClient.h"

SpecBegin(TrendingTableViewController)

    describe(@"TrendingTableViewController", ^{

        __block TrendingTableViewController *objectUnderTest;
        __block UINavigationController *navigationController;
        __block TrendingRepositories *model;
        __block id apiClient;


        beforeEach(^{
            model = [[TrendingRepositories alloc] init];
            apiClient = [OCMockObject niceMockForClass:[GithubSearchClient class]];
            objectUnderTest = [[TrendingTableViewController alloc]initWithModel:model apiClient:apiClient];
            navigationController = [[UINavigationController alloc] initWithRootViewController:objectUnderTest];
        });

        describe(@"view", ^{

            __block UIView *view;

            beforeEach(^{
                view = [objectUnderTest view];
            });

            it(@"has a view outlet", ^{
                expect(view).toNot.beNil();
            });

            it(@"has a tableview outlet", ^{
                expect(objectUnderTest.tableView).toNot.beNil();
            });

            it(@"has a menu outlet", ^{
                expect(objectUnderTest.menu).toNot.beNil();
            });

            it(@"has a rightBarButtonItem", ^{
                expect(objectUnderTest.navigationItem.rightBarButtonItem).toNot.beNil();
            });

            it(@"creates an action for the navigation left bar button", ^{
                // get a reference to to the left bar button
                UIBarButtonItem *rightBarButtonItem = objectUnderTest.navigationItem.rightBarButtonItem;
                expect([rightBarButtonItem action]).to.equal(@selector(toggleMenu));
            });

            it(@"toggles the menu open", ^{
                [objectUnderTest toggleMenu];
                expect(objectUnderTest.menu.isOpen).to.beTruthy();
            });

            describe(@"viewDidLoad initialization", ^{

                it(@"initializes a title for the controller", ^{
                    expect(objectUnderTest.title).to.equal(@"Trending Repositories");
                });

                it(@"sets up the table view data source", ^{
                    expect(objectUnderTest.tableView.dataSource).to.beKindOf([TrendingTableViewDataSource class]);
                });

                it(@"sets up the datasource with it's model", ^{
                    TrendingTableViewDataSource *dataSource = (TrendingTableViewDataSource *) objectUnderTest.tableView.dataSource;
                    expect(dataSource.repositories).to.equal(model);
                });
            });

        });

        describe(@"viewWillAppear", ^{

            it(@"should subscribe with the notification center for model updates", ^{

                id aMock = [OCMockObject partialMockForObject:[NSNotificationCenter defaultCenter]];

                [[aMock expect] addObserver:objectUnderTest
                                   selector:[OCMArg anySelector]
                                       name:TrendingRepositoriesItemsChanged
                                     object:model];

                [objectUnderTest viewWillAppear:YES];

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

                [objectUnderTest viewWillAppear:YES];

                expect(model.items).to.haveCountOf(2);

            });

        });

    });


SpecEnd