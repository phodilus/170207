//
//  Homework8
//
//  2017 Yu Zhao

#import "RestaurantMap.h"
#import "ResAnnotation.h"

@implementation RestaurantMap

- (void)viewDidLoad
{
    [super viewDidLoad];
}
//show current location and the restaurant annotation on the map.
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    //CLLocation *location = locations[[locations count] - 1];
    CLLocation *location = [locations firstObject];
    CLLocationSpeed speed = location.speed;
    CLLocationDirection dir = location.course;
    CLLocationDegrees lat = location.coordinate.latitude;
    CLLocationDegrees lon = location.coordinate.longitude;
    CLLocationDistance alt = location.altitude;
    
    [vmap setCenterCoordinate:location.coordinate animated:YES];
    MKCoordinateSpan span = MKCoordinateSpanMake(10, 10);
    MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, span);
    [vmap setRegion:region animated:YES];
    
    ResAnnotation *annotation = [[ResAnnotation alloc] init];
    annotation.coordinate = CLLocationCoordinate2DMake(self.dlat, self.dlon);
    annotation.title = @"hehe";
    [vmap addAnnotation:annotation];
}
//update current location on the map. (not used)
- (void)vmap:(MKMapView*)themap didUpdateUserLocation:(MKUserLocation*)userLocation
{
    //set current location to the centre.
    //CLLocationCoordinate2D center = userLocation.location.coordinate;
    [vmap setCenterCoordinate:userLocation.location.coordinate animated:YES];
    MKCoordinateSpan span = MKCoordinateSpanMake(10, 10);
    MKCoordinateRegion region = MKCoordinateRegionMake(userLocation.location.coordinate, span);
    [vmap setRegion:region animated:YES];
    
    [geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray *marks, NSError *error)
    {
        CLPlacemark *pm = [marks lastObject];
        userLocation.title = pm.name;
        userLocation.subtitle = pm.locality;
    }];
}
//show annotation on the map. (not used)
- (MKAnnotationView*)vmap:(MKMapView*)themap viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKPinAnnotationView *aview = (MKPinAnnotationView*)[vmap dequeueReusableAnnotationViewWithIdentifier:@"PIN_ANNOTATION"];
    if (aview == nil)
    {
        aview = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"PIN_ANNOTATION"];
    }
    aview.canShowCallout = YES;
    aview.pinTintColor = [UIColor redColor];
    aview.animatesDrop = YES;
    return aview;
}
//add an annotation where was touched. (not used)
- (void)addAnnotation:(UITapGestureRecognizer*)top
{
    CGPoint touchpt = [top locationInView:top.view];
    CLLocationCoordinate2D loc = [vmap convertPoint:touchpt toCoordinateFromView:vmap];
    ResAnnotation *annotation = [[ResAnnotation alloc] init];
    annotation.coordinate = loc;
    annotation.title = @"here";
    [vmap addAnnotation:annotation];
}
//initialize the map and other controls to display restaurant information.
- (void)initControls
{
    int posx = 10;
    int posy = 65;
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.simage]];
    vimage = [[UIImageView alloc] initWithImage:[UIImage imageWithData:data]];
    vimage.frame = CGRectMake(posx, posy + 10, 50, 50);
    posx = vimage.frame.origin.x + vimage.frame.size.width + 5;
    [self.view addSubview:vimage];
    vname = [[UITextView alloc] init];
    vlink = [[UITextView alloc] init];
    vinfo = [[UITextView alloc] init];
    vname.frame = CGRectMake(posx, posy, self.view.frame.size.width - posx - 5, 22);
    posy = vname.frame.origin.y + vname.frame.size.height;
    vlink.frame = CGRectMake(posx, posy, self.view.frame.size.width - posx - 5, 22);
    posy = vlink.frame.origin.y + vlink.frame.size.height;
    vinfo.frame = CGRectMake(posx, posy, self.view.frame.size.width - posx - 5, 55);
    posy = vinfo.frame.origin.y + vinfo.frame.size.height;

    vname.textColor = [UIColor blackColor];
    vlink.textColor = [UIColor blackColor];
    vinfo.textColor = [UIColor blackColor];
    vname.text = [NSString stringWithFormat:@"Name: %@", self.sname];
    vlink.text = [NSString stringWithFormat:@"Link: %@", self.slink];
    vinfo.text = [NSString stringWithFormat:@"Contact: %@", self.sinfo];
    [self.view addSubview:vname];
    [self.view addSubview:vlink];
    [self.view addSubview:vinfo];
    
    vmap = [[MKMapView alloc] initWithFrame:CGRectMake(10, posy, self.view.frame.size.width - 20, self.view.frame.size.height - posy - 60)];
    vmap.delegate = self;
    vmap.showsUserLocation = YES;
    vmap.scrollEnabled = YES;
    vmap.showsScale = YES;
    vmap.showsCompass = YES;
    vmap.zoomEnabled = YES;
    vmap.userTrackingMode = MKUserTrackingModeFollow;
    vmap.mapType = MKMapTypeStandard;
    [self.view addSubview:vmap];
    
    manager = [[CLLocationManager alloc] init];
    //manager.delegate = self;
    [manager setDelegate:self];
    [manager requestAlwaysAuthorization];
    [manager requestWhenInUseAuthorization];
    //[manager requestLocation];
    [manager startUpdatingLocation];
    geocoder = [[CLGeocoder alloc] init];
}

@end
