#import "TrendingRepositories.h"
#import "OCMockObject.h"
#import "OCMArg.h"

SpecBegin(TrendingRepositories)


    describe(@"TrendingRepositories", ^{

        __block TrendingRepositories * model;

        beforeEach(^{
            model = [[TrendingRepositories alloc] init];

        });

        describe(@"setItems", ^{

            it(@"should post a notificaiton", ^{

                id mock = [OCMockObject partialMockForObject:[NSNotificationCenter defaultCenter]];
                [[mock expect] postNotificationName:TrendingRepositoriesItemsChanged object:model];

                model.items = @[];

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
