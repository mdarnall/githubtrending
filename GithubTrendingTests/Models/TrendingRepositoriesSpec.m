#import "TrendingRepositories.h"
#import "OCMockObject.h"
#import "OCMArg.h"

SpecBegin(TrendingRepositories)


    describe(@"TrendingRepositories", ^{

        __block TrendingRepositories * model;

        beforeEach(^{
            model = [[TrendingRepositories alloc] init];
        });

        describe(@"TrendingTimeframe", ^{

            __block NSDate *today;
            beforeAll(^{
                today = [NSDate new];
            });

            context(@"Trending Daily", ^{

                it(@"should return the right date", ^{
                    model.timeframe = TrendingDaily;
                    expect([model.createdDateFilter timeIntervalSinceDate:today]).to.beLessThan(1);
                });
            });

            context(@"Trending Weekly", ^{

                it(@"should return a date a week ago as the createdDateFilter", ^{
                    model.timeframe = TrendingWeekly;
                    NSDate *aWeekAgo = [today dateByAddingTimeInterval:-604800];

                    expect([model.createdDateFilter timeIntervalSinceDate:aWeekAgo]).to.beLessThan(1);
                });

            });

            context(@"Trending Monthly", ^{

                it(@"should return last month as the createdDateFilter", ^{
                    model.timeframe = TrendingMonthly;
                    NSDate * lastMonth = [today dateByAddingTimeInterval:-2.63e+6];

                    expect([model.createdDateFilter timeIntervalSinceDate:lastMonth]).to.beLessThan(1);
                });

            });

        });

        describe(@"setItems", ^{

            it(@"should post a notificaiton", ^{

                id mock = [OCMockObject partialMockForObject:[NSNotificationCenter defaultCenter]];
                [[mock expect] postNotificationName:TrendingRepositoriesItemsChanged object:model];

                model.items = @[@""];

                [mock verify];

            });

            it(@"should update the value before posting the notification", ^{

                model.items = @[@""];

                id mock = [OCMockObject partialMockForObject:[NSNotificationCenter defaultCenter]];
                [[mock expect] postNotificationName:TrendingRepositoriesItemsChanged object:[OCMArg checkWithBlock:^BOOL(id arg){
                    TrendingRepositories * updatedModel = arg;

                    return updatedModel.items.count == 0;
                }]];

                model.items = @[];
                [mock verify];

            });
        });

    });

SpecEnd
