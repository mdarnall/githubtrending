//
//  TrendingTableViewDataSource.h
//  GithubTrending
//
//  Created by Matt Darnall on 10/13/13.
//  Copyright (c) 2013 Matt Darnall. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GithubSearchClient;
@class TrendingRepositories;

@interface TrendingTableViewDataSource : NSObject <UITableViewDataSource>

@property (weak, nonatomic) UITableView *tableView;

- (TrendingTableViewDataSource *)initWithRepositories:(TrendingRepositories *)repositories;
@end
