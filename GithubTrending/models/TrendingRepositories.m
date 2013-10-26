#import "TrendingRepositories.h"

NSString *TrendingRepositoriesItemsChanged = @"TrendingRepositoriesItemsChanged";

@implementation TrendingRepositories

- (void)setItems:(NSArray *)items {
    _items = items;
    [[NSNotificationCenter defaultCenter] postNotificationName:TrendingRepositoriesItemsChanged object:self];
}

@end