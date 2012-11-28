//
//  Pin.m
//  SupplyFinder
//
//  Created by Bobby Schuchert on 11/28/12.
//  Copyright (c) 2012 SPARC. All rights reserved.
//

#import "Pin.h"


@implementation Pin

@dynamic latitude;
@dynamic longitude;
@dynamic title;


- (CLLocationCoordinate2D)coordinate {
    CLLocationCoordinate2D cor = CLLocationCoordinate2DMake([self.latitude doubleValue],[self.longitude doubleValue]);
    return cor;
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    self.latitude =[NSNumber numberWithDouble:newCoordinate.latitude];
    self.longitude = [NSNumber numberWithDouble:newCoordinate.longitude];
}


@end
