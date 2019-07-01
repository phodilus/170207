//
//  Homework8
//
//  2017 Yu Zhao

#import "GeographicView.h"

@implementation GeographicView

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initControls];
}
//show raw gps data obtained from gps receiver.
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = locations[[locations count] - 1];
    CLLocationSpeed speed = location.speed;
    CLLocationDirection dir = location.course;
    CLLocationDegrees lat = location.coordinate.latitude;
    CLLocationDegrees lon = location.coordinate.longitude;
    CLLocationDistance alt = location.altitude;

    vspeed.text = [NSString stringWithFormat:@"Speed: %f", speed];
    vdir.text = [NSString stringWithFormat:@"Direction: %f", dir];
    vlat.text = [NSString stringWithFormat:@"Latitude: %f", lat];
    vlon.text = [NSString stringWithFormat:@"Longitude: %f", lon];
    valt.text = [NSString stringWithFormat:@"Altitude: %f", alt];
}
//rotate compass picture according to the data of magnetic sensor.
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(nonnull CLHeading *)newHeading
{
    if (newHeading.headingAccuracy < 0)
        return;
    CLLocationDirection heading = ((newHeading.trueHeading > 0) ? newHeading.trueHeading : newHeading.magneticHeading);
    [UIView animateWithDuration:0.25 animations:^{
        vcompass.transform = CGAffineTransformMakeRotation(-1 * heading * M_PI / 180);
    }];
}
//initialize compass picture and other controls.
- (void)initControls
{
    self.view.backgroundColor = [UIColor whiteColor];
    int size = self.view.frame.size.width - 60;
    vcompass = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"compass.png"]];
    vcompass.frame = CGRectMake(30, 30, size, size);
    [self.view addSubview:vcompass];

    vspeed = [[UITextView alloc] init];
    vdir = [[UITextView alloc] init];
    vlat = [[UITextView alloc] init];
    vlon = [[UITextView alloc] init];
    valt = [[UITextView alloc] init];
    vspeed.textColor = [UIColor blackColor];
    vdir.textColor = [UIColor blackColor];
    vlat.textColor = [UIColor blackColor];
    vlon.textColor = [UIColor blackColor];
    valt.textColor = [UIColor blackColor];

    size += 30 + 10;
    vspeed.frame = CGRectMake(30, size, self.view.frame.size.width - 30, 20);
    size += 20;
    vdir.frame = CGRectMake(30, size, self.view.frame.size.width - 30, 20);
    size += 20;
    vlat.frame = CGRectMake(30, size, self.view.frame.size.width - 30, 20);
    size += 20;
    vlon.frame = CGRectMake(30, size, self.view.frame.size.width - 30, 20);
    size += 20;
    valt.frame = CGRectMake(30, size, self.view.frame.size.width - 30, 20);
    size += 20;
    
    [self.view addSubview:vspeed];
    [self.view addSubview:vdir];
    [self.view addSubview:vlat];
    [self.view addSubview:vlon];
    [self.view addSubview:valt];
    
    manager = [[CLLocationManager alloc] init];
    manager.delegate = self;
    manager.headingFilter = 5;
    [manager requestAlwaysAuthorization];
    [manager startUpdatingHeading];
    [manager startUpdatingLocation];
}

@end
