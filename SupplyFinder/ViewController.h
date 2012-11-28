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
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "ARLocationDelegate.h"
#import "ARViewController.h"


@interface ViewController : UIViewController <ARLocationDelegate, MKMapViewDelegate, NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) AppDelegate *appDelegate;
@property (strong, nonatomic) ARViewController *cameraViewController;
@property (strong, nonatomic) UIViewController *infoViewController;

@property (weak, nonatomic) IBOutlet UISwitch *debugSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *scalingSwitch;

@property (strong, nonatomic) NSMutableArray *pins;

@end
