#import "TrendingTableViewDataSource.h"
#import "TrendingRepositories.h"

static NSString *const CellIdentifier = @"TrendingTableViewCell";


@implementation TrendingTableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.repositories.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];


    
    if(cell == nil){
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                                       reuseIdentifier:CellIdentifier];
    }

    NSDictionary * repository = [self.repositories.items objectAtIndex:(NSUInteger) indexPath.row];
    cell.textLabel.text = [repository objectForKey:@"full_name"];
    cell.detailTextLabel.text = [repository objectForKey:@"description"];


    return cell;

}


@end
