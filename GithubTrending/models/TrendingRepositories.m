#import "TrendingRepositories.h"

NSString *TrendingRepositoriesItemsChanged = @"TrendingRepositoriesItemsChanged";

@implementation TrendingRepositories

- (void)setItems:(NSArray *)items {
    _items = items;
    [[NSNotificationCenter defaultCenter] postNotificationName:TrendingRepositoriesItemsChanged object:self];
}

- (NSDate *)createdDateFilter {
    NSDate *today = [NSDate new];

    switch(self.timeframe){
        case TrendingDaily:
            return today;
        case TrendingMonthly:
            return [today dateByAddingTimeInterval:-2.63e+6];
        case TrendingWeekly:
            return [today dateByAddingTimeInterval:-604800];
    }

    return today;

}


- (void)setTimeframe:(enum TrendingTimeframe)timeframe {
    _timeframe = timeframe;

    [[NSNotificationCenter defaultCenter] postNotificationName:@"foo" object:self];
}


@end