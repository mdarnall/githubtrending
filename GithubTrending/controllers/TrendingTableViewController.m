#import <REMenu/REMenu.h>
#import "TrendingTableViewController.h"
#import "TrendingTableViewDataSource.h"
#import "GithubSearchClient.h"
#import "TrendingRepositories.h"
#import "REMenu.h"

@interface TrendingTableViewController ()

@property(strong, nonatomic) TrendingTableViewDataSource *dataSource;
@property(strong, nonatomic) GithubSearchClient *apiClient;
@property(strong, nonatomic) TrendingRepositories *model;

@end

@implementation TrendingTableViewController

- (id)init {
    TrendingRepositories *model = [[TrendingRepositories alloc] init];
    GithubSearchClient *apiClient = [GithubSearchClient sharedClient];

    return [self initWithModel:model apiClient:apiClient];
}

// di initializer for testing
- (id)initWithModel:(TrendingRepositories *)model apiClient:(GithubSearchClient *)apiClient {

    self = [super init];
    if (self) {
        _model = model;
        _apiClient = apiClient;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createMenu];

    self.title = @"Trending Repositories";

    self.tableView.dataSource = self.dataSource;

}

- (void)createMenu {

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu"
                                                                             style:UIBarButtonItemStyleBordered
                                                                            target:self
                                                                            action:@selector(toggleMenu)];

    REMenuItem *todayItem = [[REMenuItem alloc] initWithTitle:@"Today"
                                                    subtitle:nil
                                                       image:nil
                                            highlightedImage:nil
                                                      action:^(REMenuItem *item) {
                                                          NSLog(@"Item: %@", item);
                                                      }];

    REMenuItem *thisWeek = [[REMenuItem alloc] initWithTitle:@"This Week"
                                                     subtitle:nil
                                                        image:nil
                                             highlightedImage:nil
                                                       action:^(REMenuItem *item) {
                                                           NSLog(@"Item: %@", item);
                                                       }];

    REMenuItem *thisMonth = [[REMenuItem alloc] initWithTitle:@"This Month"
                                                     subtitle:nil
                                                        image:nil
                                             highlightedImage:nil
                                                       action:^(REMenuItem *item) {
                                                           NSLog(@"Item: %@", item);
                                                       }];


    self.menu = [[REMenu alloc] initWithItems:@[todayItem, thisWeek, thisMonth]];

}

- (void)toggleMenu {
    if (self.menu.isOpen)
        return [self.menu close];

    [self.menu showFromNavigationController:self.navigationController];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // listen to the model to say it got new items and update the tableview
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onTrendingRepositoriesChanged)
                                                 name:TrendingRepositoriesItemsChanged
                                               object:self.model];


    [self fetchTrendingRepositories];

}

- (void)fetchTrendingRepositories {

    [self.apiClient getTrendingRepositories:self.model callBack:^(NSArray *repositories, NSError *error) {

        if (error) {
            NSLog(@"failed to load trending repositories %@", [error localizedDescription]);
        }

        self.model.items = repositories;
    }];


}

- (void)onTrendingRepositoriesChanged {

    NSLog(@"Model state: %@", self.model.items);
    [self.tableView reloadData];

}

- (TrendingTableViewDataSource *)dataSource {
    if(_dataSource == nil){
        _dataSource = [[TrendingTableViewDataSource alloc]init];
        _dataSource.repositories = self.model;
    }
    return _dataSource;
}

@end
