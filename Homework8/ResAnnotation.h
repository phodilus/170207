//
//  Homework8
//
//  2017 Yu Zhao

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface ResAnnotation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end

