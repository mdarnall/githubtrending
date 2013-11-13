#import <UIKit/UIKit.h>
#import "TrendingTableViewDataSource.h"
#import "TrendingRepositories.h"

SpecBegin(TrendingTableViewDataSource)

    describe(@"TrendingTableViewDataSource", ^{

        __block TrendingTableViewDataSource *objectUnderTest;

        describe(@"UITableViewDataSource protocol", ^{
            
            beforeEach(^{
                // create the model
                TrendingRepositories *repositories = [[TrendingRepositories alloc] init];
                // seed it with some known data
                repositories.items = @[@{
                        @"full_name" : @"vhf/free-programming-books",
                        @"description" : @"foo"

                }, @{
                        @"full_name" : @"opserver/Opserver",
                        @"description" : @"Stack Exchange's Monitoring System"
                }];

                objectUnderTest = [[TrendingTableViewDataSource alloc] init];
                objectUnderTest.repositories = repositories;
            });

            it(@"should conform to the UITableViewDataSource", ^{
                expect([objectUnderTest conformsToProtocol:@protocol(UITableViewDataSource)]).to.beTruthy();
            });

            describe(@"tableView:numberOfRowsInSection", ^{

                it(@"should return the number of rows based on the item count in the model", ^{
                    expect([objectUnderTest tableView:nil numberOfRowsInSection:0]).to.equal(2);
                });

            });

            describe(@"tableView:cellForRowAtIndexPath", ^{

                __block UITableViewCell *cell;
                beforeEach(^{
                    NSIndexPath * path = [NSIndexPath indexPathForRow:0 inSection:0];
                    cell = [objectUnderTest tableView:nil cellForRowAtIndexPath:path];
                });

                it(@"should return a cell", ^{
                    expect(cell).toNot.beNil();
                });

                it(@"should return a cell with the full name as the text label", ^{
                    NSString *expectedFullName = [objectUnderTest.repositories.items.firstObject objectForKey:@"full_name"];
                    expect(cell.textLabel.text).to.equal(expectedFullName);
                });

                it(@"should return a cell with the description as the detail text label", ^{
                    NSString *expectedDescription = [objectUnderTest.repositories.items.firstObject objectForKey:@"description"];
                    expect(cell.detailTextLabel.text).to.equal(expectedDescription);

                });
            });

        });

    });


SpecEnd