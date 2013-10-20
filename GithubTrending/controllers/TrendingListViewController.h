//
//  TrendingListViewController.h
//  GithubTrending
//
//  Created by Matt Darnall on 10/13/13.
//  Copyright (c) 2013 Matt Darnall. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GithubSearchClient;
@class TrendingRepositories;

@interface TrendingListViewController : UITableViewController


- (id)initWithModel:(TrendingRepositories *)model apiClient:(GithubSearchClient *)apiClient;
@end
