#import <Foundation/Foundation.h>

@class TrendingRepositories;



@interface TrendingTableViewDataSource : NSObject <UITableViewDataSource>

@property (strong, nonatomic) TrendingRepositories * repositories;

@end
