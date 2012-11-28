//
//  Pin.h
//  SupplyFinder
//
//  Created by Jonathan Spohn on 11/28/12.
//  Copyright (c) 2012 SPARC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface Pin : NSManagedObject <MKAnnotation>


@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * category;

@end
