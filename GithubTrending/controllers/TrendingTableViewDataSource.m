#import "TrendingTableViewDataSource.h"
#import "TrendingRepositories.h"

@interface TrendingTableViewDataSource ()

@property (strong, nonatomic) TrendingRepositories * repositories;

@end

@implementation TrendingTableViewDataSource

-(TrendingTableViewDataSource *) initWithRepositories:(TrendingRepositories *) repositories{
    self = [super init];
    if(self){
        _repositories = repositories;
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.repositories.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}




@end
