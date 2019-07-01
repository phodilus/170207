//
//  Homework8
//
//  2017 Yu Zhao

#import "RestaurantView.h"
#import "RestaurantMap.h"

@implementation RestaurantView

- (void)awakeFromNib
{
    //code here if storyboard/nib is used....
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self downloadJsonRestaurants];
    [self setupTableView];
}

//download restaurant information from a remote server.
- (void)downloadJsonRestaurants
{
    NSURL *url = [NSURL URLWithString:@"http://phodilus.com/images/restaurants.json"];
    NSData *jsondata = [NSData dataWithContentsOfURL:url];
    restaurants = [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingAllowFragments error:nil];
}
//initialize the list of restaurant names.
- (void)setupTableView
{
    table = [[UITableView alloc] initWithFrame:CGRectInset(self.view.bounds, 30.0, 30.0) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
}
//required by the table.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [restaurants count];
}
//return specific list item to show the restaurant names.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    NSDictionary *item = [restaurants objectAtIndex:indexPath.row];
    cell.textLabel.text = [item objectForKey:@"Name"];
    return cell;
}
//open detail view to show a map for the selected restaurant.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RestaurantMap *detail = [[RestaurantMap alloc] initWithNibName:nil bundle:nil];
    //Restaurant *item = [restaurants objectAtIndex:indexPath.row];
    NSDictionary *item = [restaurants objectAtIndex:indexPath.row];
    detail.sname = [item objectForKey:@"Name"];
    detail.simage = [item objectForKey:@"Image"];
    detail.slink = [item objectForKey:@"Link"];
    detail.sinfo = [item objectForKey:@"Info"];
    detail.dlat = [[item objectForKey:@"Latitude"] doubleValue];
    detail.dlon = [[item objectForKey:@"Longitude"] doubleValue];
    detail.view.backgroundColor = [UIColor whiteColor];

    [detail initControls];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
