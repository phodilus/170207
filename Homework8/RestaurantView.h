//
//  Homework8
//
//  2017 Yu Zhao

#import <UIKit/UIKit.h>

@interface RestaurantView : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *restaurants;
    UITableView *table;
}
@end
