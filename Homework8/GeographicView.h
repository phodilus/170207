//
//  Homework8
//
//  2017 Yu Zhao

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface GeographicView : UIViewController
{
    CLLocationManager *manager;
    UIImageView *vcompass;
    UITextView *vlat;
    UITextView *vlon;
    UITextView *vdir;
    UITextView *valt;
    UITextView *vspeed;
}
@end
