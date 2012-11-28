//
//  ViewController.m
//  SupplyFinder
//
//  Created by Bobby Schuchert on 11/28/12.
//  Copyright (c) 2012 SPARC. All rights reserved.
//

#import "ViewController.h"
#import "Pin.h"
#import "ContentManager.h"
#import "ARKit.h"
#import "AppDelegate.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //get managed object context from the app delegate
    _appDelegate = [[UIApplication sharedApplication] delegate];
    _managedObjectContext = [_appDelegate managedObjectContext];
    
    //get pins and assign them to the array
    NSManagedObjectContext *moc = _managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Pin" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    // Set example predicate and sort orderings...
    //    NSNumber *minimumSalary = ...;
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:
    //                              @"(lastName LIKE[c] 'Worsley') AND (salary > %@)", minimumSalary];
    //    [request setPredicate:predicate];
    //
    //    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
    //                                        initWithKey:@"firstName" ascending:YES];
    //    [request setSortDescriptors:@[sortDescriptor]];
    
    NSError *error;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    if (array == nil)
    {
        // Deal with error...
    }else{
        _pins = [[NSMutableArray alloc] initWithArray:array copyItems:YES];;
        
    }
    
    [self.debugSwitch setOn:NO animated:YES];
    [self.scalingSwitch setOn:YES animated:YES];
    [[ContentManager sharedContentManager] setDebugMode:[self.debugSwitch isOn]];
    [[ContentManager sharedContentManager] setScaleOnDistance:[self.scalingSwitch isOn]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    if(self.cameraViewController != nil) {
        self.cameraViewController = nil;
    }
    if(self.infoViewController != nil) {
        self.infoViewController = nil;
    }
}
- (IBAction)debugSwitchChanged:(id)sender
{
    [[ContentManager sharedContentManager] setDebugMode:[self.debugSwitch isOn]];
}

- (IBAction)scalingTurnedOn:(id)sender
{
    [[ContentManager sharedContentManager] setScaleOnDistance:[self.scalingSwitch isOn]];
}

- (IBAction)startAugmentedReality:(id)sender
{
    if([ARKit deviceSupportsAR]) {
        self.cameraViewController = [[ARViewController alloc] initWithDelegate:self];
        [self.cameraViewController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [self presentViewController:self.cameraViewController animated:YES completion:NULL];
        
    } else {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.infoViewController = [[UIViewController alloc] init];
        
        UILabel *errorLabel = [[UILabel alloc] init];
        [errorLabel setNumberOfLines:0];
        [errorLabel setText:@"Augmented Reality is not supported on this device"];
        [errorLabel setFrame:[[self.infoViewController view] bounds]];
        [errorLabel setTextAlignment:NSTextAlignmentCenter];
        [[self.infoViewController view] addSubview:errorLabel];
        
        UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        [closeButton setTitle:@"Close" forState:UIControlStateNormal];
        
        [closeButton setBackgroundColor:[UIColor blueColor]];
        [closeButton addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [[self.infoViewController view] addSubview:closeButton];
        [[appDelegate window] addSubview:[self.infoViewController view]];
        
    }
}

- (IBAction)closeButtonClicked:(id)sender
{
    [[[self infoViewController] view] removeFromSuperview];
    self.infoViewController = nil;
}

- (IBAction)closeARButtonClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    [[self.infoViewController view] removeFromSuperview];
    self.infoViewController = nil;
}

- (void)locationClicked:(ARGeoCoordinate *)coordinate
{
    if(coordinate != nil) {
        NSLog(@"Main View Controller received the click Event for: %@", [coordinate title]);
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        UIViewController *infovc = [[UIViewController alloc] init];
        
        UILabel *errorLabel = [[UILabel alloc] init];
        [errorLabel setNumberOfLines:0];
        [errorLabel setText: [NSString stringWithFormat:@"You clicked on %@ and distance is %.2f km",[coordinate title], [coordinate distanceFromOrigin]/1000.0f]];
        [errorLabel setFrame: [[infovc view] bounds]];
        [errorLabel setTextAlignment:NSTextAlignmentCenter];
        [[infovc view] addSubview:errorLabel];
        
        UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 90, 30)];
        [closeButton setTitle:@"Close" forState:UIControlStateNormal];
        
        [closeButton setBackgroundColor:[UIColor blueColor]];
        [closeButton addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [[infovc view] addSubview:closeButton];
        
        UIButton *closeARButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 120, 30)];
        [closeARButton setTitle:@"Close AR View" forState:UIControlStateNormal];
        
        [closeARButton setBackgroundColor:[UIColor blackColor]];
        [closeARButton addTarget:self action:@selector(closeARButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [[infovc view] addSubview:closeARButton];
        
        [[appDelegate window] addSubview:[infovc view]];
        
        [self setInfoViewController:infovc];
    }
}

- (NSMutableArray *)geoLocations
{
    NSMutableArray *locationArray = [[NSMutableArray alloc] init];
    ARGeoCoordinate *tempCoordinate;
    CLLocation        *tempLocation;
    
    tempLocation = [[CLLocation alloc] initWithLatitude:39.550051 longitude:-105.782067];
    tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation locationTitle:@"Denver"];
    [locationArray addObject:tempCoordinate];
    
    tempLocation = [[CLLocation alloc] initWithLatitude:45.523875 longitude:-122.670399];
    tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation locationTitle:@"Portland"];
    [locationArray addObject:tempCoordinate];
    
    tempLocation = [[CLLocation alloc] initWithLatitude:41.879535 longitude:-87.624333];
    tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation locationTitle:@"Chicago"];
    [locationArray addObject:tempCoordinate];
    
    tempLocation = [[CLLocation alloc] initWithLatitude:30.268735 longitude:-97.745209];
    tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation locationTitle:@"Austin"];
    [locationArray addObject:tempCoordinate];

    tempLocation = [[CLLocation alloc] initWithLatitude:51.500152 longitude:-0.126236];
    tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation locationTitle:@"London"];
    [locationArray addObject:tempCoordinate];
    
    tempLocation = [[CLLocation alloc] initWithLatitude:48.856667 longitude:2.350987];
    tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation locationTitle:@"Paris"];
    [locationArray addObject:tempCoordinate];
    
    tempLocation = [[CLLocation alloc] initWithLatitude:55.676294 longitude:12.568116];
    tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation locationTitle:@"Copenhagen"];
    [locationArray addObject:tempCoordinate];

    tempLocation = [[CLLocation alloc] initWithLatitude:52.373801 longitude:4.890935];
    tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation locationTitle:@"Amsterdam"];
    [locationArray addObject:tempCoordinate];

    tempLocation = [[CLLocation alloc] initWithLatitude:19.611544 longitude:-155.665283];
    tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation locationTitle:@"Hawaii"];
    tempCoordinate.inclination = M_PI/30;
    [locationArray addObject:tempCoordinate];
    
    return locationArray;
    
}

@end
