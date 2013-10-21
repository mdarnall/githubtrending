#import <UIKit/UIKit.h>
#import "TrendingTableViewDataSource.h"
#import "TrendingRepositories.h"

SpecBegin(TrendingTableViewDataSource)

    describe(@"TrendingTableViewDataSource", ^{

        __block TrendingTableViewDataSource *dataSource;

        describe(@"UITableViewDataSource", ^{
            
            beforeEach(^{
                TrendingRepositories *repositories = [[TrendingRepositories alloc] init];
                repositories.items = @[@{
                        @"full_name" : @"vhf/free-programming-books",
                        @"description" : @"foo"

                }, @{
                        @"full_name" : @"opserver/Opserver",
                        @"description" : @"Stack Exchange's Monitoring System"
                }];

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
                expect([dataSource tableView:nil numberOfRowsInSection:0]).to.equal(2);
            });

            describe(@"cellForRowAtIndexPath", ^{

                __block UITableViewCell *cell;
                beforeEach(^{
                    NSIndexPath * path = [NSIndexPath indexPathForRow:0 inSection:0];
                    cell = [dataSource tableView:nil cellForRowAtIndexPath: path];
                });

                it(@"should return a cell", ^{
                    expect(cell).toNot.beNil();
                });

                it(@"should set the full name as the text label", ^{
                    NSString *fullName = [dataSource.repositories.items.firstObject objectForKey:@"full_name"];
                    expect(cell.textLabel.text).to.equal(fullName);
                });

                it(@"should set the description as the detail text label", ^{
                    NSString *description = [dataSource.repositories.items.firstObject objectForKey:@"description"];
                    expect(cell.detailTextLabel.text).to.equal(description);

                });
            });

        });

    });



SpecEnd