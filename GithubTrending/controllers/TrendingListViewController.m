//
//  TrendingListViewController.m
//  GithubTrending
//
//  Created by Matt Darnall on 10/13/13.
//  Copyright (c) 2013 Matt Darnall. All rights reserved.
//

#import "TrendingListViewController.h"
#import "TrendingTableViewDataSource.h"

@interface TrendingListViewController ()

@property (strong, nonatomic) TrendingTableViewDataSource * dataSource;

@end

@implementation TrendingListViewController

    - (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad] ;


    self.tableView.dataSource = self.dataSource;

}

- (TrendingTableViewDataSource *)dataSource {
    if(_dataSource == nil){
        _dataSource = [[TrendingTableViewDataSource alloc]init];
    }
    return _dataSource;
}


@end
