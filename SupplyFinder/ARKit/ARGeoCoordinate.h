//
//  ARGeoCoordinate.h
//  AR Kit
//
//  Created by Haseman on 8/1/09.
//  Copyright 2009 Zac White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "ARCoordinate.h"

@interface ARGeoCoordinate : ARCoordinate {
	CLLocation *geoLocation;
    double distanceFromOrigin;
    UIView *displayView;
    NSNumber *category;
    
}

@property (nonatomic, retain) CLLocation *geoLocation;
@property (nonatomic, retain) UIView *displayView;
@property (nonatomic, retain) NSNumber *category;
@property (nonatomic) double distanceFromOrigin;


- (float)angleFromCoordinate:(CLLocationCoordinate2D)first toCoordinate:(CLLocationCoordinate2D)second;

+ (ARGeoCoordinate *)coordinateWithLocation:(CLLocation *)location locationTitle:(NSString*) titleOfLocation ofCategory:(NSNumber *)category;
+ (ARGeoCoordinate *)coordinateWithLocation:(CLLocation *)location fromOrigin:(CLLocation *)origin ofCategory:(NSNumber *)category;

- (void)calibrateUsingOrigin:(CLLocation *)origin;

@end
