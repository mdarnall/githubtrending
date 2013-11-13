//
//  TrendingTableViewController.h
//  GithubTrending
//
//  Created by Matt Darnall on 10/13/13.
//  Copyright (c) 2013 Matt Darnall. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GithubSearchClient;
@class TrendingRepositories;
@class REMenu;

@interface TrendingTableViewController : UITableViewController

@property(strong, nonatomic) REMenu * menu;
@property(strong, nonatomic) TrendingRepositories *model;

- (void)toggleMenu;

- (id)initWithApiClient:(GithubSearchClient *)apiClient;

- (void)onTimeframeChanged;
@end
