//
//  Homework8
//
//  2017 Yu Zhao

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.vc1 = [[GeographicView alloc] initWithNibName:nil bundle:nil];
    self.vc1.title = @"GPS Data";
    self.vc1.tabBarItem.image = [UIImage imageNamed:@"gps.png"];
    
    self.vc2 = [[RestaurantView alloc] initWithNibName:nil bundle:nil];
    self.vc2.title = @"Restaurants";
    self.vc2.tabBarItem.image = [UIImage imageNamed:@"restaurant.png"];

    self.nav2 = [[UINavigationController alloc] initWithRootViewController:self.vc2];
    self.tab = [[UITabBarController alloc] initWithNibName:nil bundle:nil];
    self.tab.viewControllers = [NSArray arrayWithObjects:
                                self.vc1,
                                self.nav2,
                                nil];
    self.window.rootViewController = self.tab;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
