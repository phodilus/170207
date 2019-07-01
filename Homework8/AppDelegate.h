//
//  Homework8
//
//  2017 Yu Zhao

#import <UIKit/UIKit.h>
#import "GeographicView.h"
#import "RestaurantView.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property() UITabBarController *tab;
@property() GeographicView *vc1;
@property() RestaurantView *vc2;
@property() UINavigationController *nav2;

@end
