//
//  ViewController.h
//  SupplyFinder
//
//  Created by Bobby Schuchert on 11/28/12.
//  Copyright (c) 2012 SPARC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ARLocationDelegate.h"
#import "ARViewController.h"


@interface ViewController : UIViewController <ARLocationDelegate>

@property (strong, nonatomic) ARViewController *cameraViewController;
@property (strong, nonatomic) UIViewController *infoViewController;

@property (nonatomic, weak) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UISwitch *debugSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *hookerSwitch;

@end
