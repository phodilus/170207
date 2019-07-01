//
//  Homework8
//
//  2017 Yu Zhao

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface RestaurantMap : UIViewController
{
    UITextView *vname;
    UIImageView *vimage;
    UITextView *vlink;
    UITextView *vinfo;
    MKMapView *vmap;
    CLLocationManager *manager;
    CLGeocoder *geocoder;
}

- (void)initControls;

@property() NSString *sname;
@property() double dlat;
@property() double dlon;
@property() NSString *simage;
@property() NSString *slink;
@property() NSString *sinfo;

@end
