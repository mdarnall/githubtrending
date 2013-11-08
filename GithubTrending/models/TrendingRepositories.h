#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TrendingTimeframe) {
    TrendingDaily,
    TrendingWeekly,
    TrendingMonthly
};

extern NSString* TrendingRepositoriesItemsChanged;

@interface TrendingRepositories : NSObject

@property (strong, nonatomic) NSArray * items;
@property (strong, readonly) NSDate * createdDateFilter;
@property (nonatomic) enum TrendingTimeframe timeframe;

@end