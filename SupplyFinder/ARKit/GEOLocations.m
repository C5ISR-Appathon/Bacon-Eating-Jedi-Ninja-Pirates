//
//  GEOLocations.m
//  AR Kit
//
//  Modified by Niels W Hansen on 12/19/09.
//  Copyright 2009 Zac White. All rights reserved.
//

#import "GEOLocations.h"
#import "ARGeoCoordinate.h"
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>

@implementation GEOLocations

- (id)initWithDelegate:(id<ARLocationDelegate>) aDelegate{
	self.theDelegate = aDelegate;

	return self;
}

-(NSMutableArray*) returnLocations 
{
	return [self.theDelegate geoLocations];
}


@end
