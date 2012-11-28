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
#import "CustomAnnotationView.h"


@interface ViewController ()

@property (strong, nonatomic) Pin *addedPin;

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
        _pins = [[NSMutableArray alloc] initWithArray:array];;
        
    }
    
    [self.debugSwitch setOn:NO animated:YES];
    [self.scalingSwitch setOn:YES animated:YES];
    [[ContentManager sharedContentManager] setDebugMode:[self.debugSwitch isOn]];
    [[ContentManager sharedContentManager] setScaleOnDistance:[self.scalingSwitch isOn]];

    
}

-(void)viewDidAppear:(BOOL)animated {
    //Restore saved pins
    for (Pin *savedPin in self.pins) {
        [self.mapView addAnnotation:savedPin];
    }
    
    self.mapView.showsUserLocation = YES;
    
    
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if( [[segue identifier] isEqualToString:@"addPin"] ){
        //[(PinCreateEditViewController *)[segue destinationViewController] setSelectedPin:_addedPin];
        
        [[segue destinationViewController] setDelegate:self];
    }
}

- (IBAction)addPointButtonClicked {
    
    
    //[self addMarkerForAddress:@"Charleston, SC"];
    
    [self performSegueWithIdentifier:@"addPin" sender:self];
}

-(void)addMarker:(Pin *)thePin
{
    //Add the marker
    [self.mapView addAnnotation:thePin];
    
    
    if (!_pins) {
        _pins = [NSMutableArray arrayWithCapacity:5];
    }
    
    [_pins addObject:thePin];
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
        
        UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 90, 30)];
        [closeButton setTitle:@"Close" forState:UIControlStateNormal];
        
        [closeButton setBackgroundColor:[UIColor blueColor]];
        [closeButton addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [[infovc view] addSubview:closeButton];
        
        UIButton *closeARButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 70, 120, 30)];
        [closeARButton setTitle:@"Close AR View" forState:UIControlStateNormal];
        
        [closeARButton setBackgroundColor:[UIColor blackColor]];
        [closeARButton addTarget:self action:@selector(closeARButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [[infovc view] addSubview:closeARButton];
        
        UIImageView *testImage	= [[UIImageView alloc] initWithFrame:CGRectZero];
		[testImage setImage:[UIImage imageNamed:@"zombie.png"]];
        
		[testImage setFrame:CGRectMake(50, 70, 120, 30)];
        
        [[infovc view] addSubview:testImage];
        
        
        [[appDelegate window] addSubview:[infovc view]];
        
        [self setInfoViewController:infovc];
    }
}

- (NSMutableArray *)geoLocations
{
    NSMutableArray *locationArray = [[NSMutableArray alloc] init];
    ARGeoCoordinate *tempCoordinate;
    CLLocation        *tempLocation;
    
    for(Pin *pin in self.pins) {
        tempLocation = [[CLLocation alloc] initWithLatitude:pin.coordinate.latitude longitude:pin.coordinate.longitude];
        tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation locationTitle:pin.title];
        [locationArray addObject:tempCoordinate];
        
    }

    
    return locationArray;
    
}

#pragma mark - MKMapViewDelegate


- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // if it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // handle our two custom annotations
    //
    if ([annotation isKindOfClass:[Pin class]])
    {
        // try to dequeue an existing pin view first
        static NSString* PinAnnotationIdentifier = @"pinAnnotationIdentifier";
        
        
        // if an existing pin view was not available, create one
        //MKPinAnnotationView* customPinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:PinAnnotationIdentifier];
        //MKAnnotationView *customPinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:PinAnnotationIdentifier];
        CustomAnnotationView *customPinView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:PinAnnotationIdentifier];
        //customPinView.pinColor = MKPinAnnotationColorRed;
        //customPinView.animatesDrop = YES;
        customPinView.canShowCallout = YES;
        customPinView.draggable = YES;
        
        
        
        if( [[(Pin *)annotation category] intValue] == 0 ){
            
            customPinView.image = [UIImage imageNamed:@"food.png"];

        }else if( [[(Pin *)annotation category] intValue] == 1 ){
            
            customPinView.image = [UIImage imageNamed:@"gun icon.png"];
            
        }else if( [[(Pin *)annotation category] intValue] == 2 ){
            
            customPinView.image = [UIImage imageNamed:@"oil icon.png"];
            
        }else if( [[(Pin *)annotation category] intValue] == 3 ){
            
            customPinView.image = [UIImage imageNamed:@"zombie.png"];
            
        }
        
        
        // add a detail disclosure button to the callout which will open a new view controller page
        //
        // note: you can assign a specific call out accessory view, or as MKMapViewDelegate you can implement:
        //  - (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control;
        //
        
        /*UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
         [rightButton addTarget:self
         action:@selector(showDetails:)
         forControlEvents:UIControlEventTouchUpInside];
         customPinView.rightCalloutAccessoryView = rightButton;
         */
        
        return customPinView;
        
        
    }
    return nil;
}


- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    MKAnnotationView *aV;
    for (aV in views) {
        CGRect endFrame = aV.frame;
        
        aV.frame = CGRectMake(aV.frame.origin.x, aV.frame.origin.y - 230.0, aV.frame.size.width, aV.frame.size.height);
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.45];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [aV setFrame:endFrame];
        [UIView commitAnimations];
        
    }
}



- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annotationView didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState {
    
    
    NSLog(@"State changed");
    
    if(newState == MKAnnotationViewDragStateEnding) {
        //Pin dropped, update it's title with current location data
        Pin *pin = (Pin *)annotationView.annotation;
        CLLocation *location = [[CLLocation alloc] initWithLatitude:pin.coordinate.latitude longitude:pin.coordinate.longitude];
        [self geocodeLocation:location forAnnotationView:annotationView];
        
    }
}



- (void)geocodeLocation:(CLLocation*)location forAnnotationView:(MKAnnotationView*)annotationView
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:location completionHandler: ^(NSArray* placemarks, NSError* error){
        
        if ([placemarks count] > 0)
        {
            CLPlacemark *topResult = [placemarks objectAtIndex:0];
            Pin *pin = (Pin *)annotationView.annotation;
            pin.title = [NSString stringWithFormat:@"%@, %@", topResult.locality, topResult.administrativeArea]; //city,state
            
        }
    }];
    
    NSManagedObjectContext *context = self.managedObjectContext;
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
}


//- (void)mapView:(MKMapView *)aMapView didUpdateUserLocation:(MKUserLocation *)aUserLocation {
//    MKCoordinateRegion region;
//    MKCoordinateSpan span;
//    span.latitudeDelta = 0.095;
//    span.longitudeDelta = 0.095;
//    CLLocationCoordinate2D location;
//    location.latitude = aUserLocation.coordinate.latitude;
//    location.longitude = aUserLocation.coordinate.longitude;
//    region.span = span;
//    region.center = location;
//    [aMapView setRegion:region animated:YES];
//}








@end
