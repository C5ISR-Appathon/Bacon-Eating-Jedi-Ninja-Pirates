//
//  PinCreateEditViewController.m
//  SupplyFinder
//
//  Created by Jonathan Spohn on 11/28/12.
//  Copyright (c) 2012 SPARC. All rights reserved.
//

#import "PinCreateEditViewController.h"

@interface PinCreateEditViewController ()

@end

@implementation PinCreateEditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _appDelegate = [[UIApplication sharedApplication] delegate];
    _managedObjectContext = [_appDelegate managedObjectContext];
    

    _pin = [NSEntityDescription insertNewObjectForEntityForName:@"Pin" inManagedObjectContext:_managedObjectContext];
    
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segmentChanged:(id)sender {
    
    
    NSInteger selectedIndex = [_categorySegment selectedSegmentIndex];
    
    [_pin setCategory:[NSNumber numberWithInteger:selectedIndex]];
    
    if(selectedIndex == 0){
        //food
        [_categoryImage setImage:[UIImage imageNamed:@"food.png"]];
    }else if(selectedIndex == 1){
        //weapons
        [_categoryImage setImage:[UIImage imageNamed:@"gun icon.png"]];
    }else if(selectedIndex == 2){
        //fuel
        [_categoryImage setImage:[UIImage imageNamed:@"oil icon.png"]];
    }else if(selectedIndex == 3){
        //zombies
        [_categoryImage setImage:[UIImage imageNamed:@"zombie.png"]];
    }
}

-(void)addMarkerToUserLocation
{

    
    if(![[_titleField text] isEqualToString:@""]){
        [_pin setTitle:[_titleField text]];
    }else{
        _pin.title = @"N/A";
    }
    
    //CLLocationCoordinate2D userLocation = [[[[(ViewController *)_delegate mapView] userLocation] location] coordinate];
    
    MKMapView *mapView = [(ViewController *)_delegate mapView];
    
    _pin.coordinate = mapView.centerCoordinate;

    
}


- (IBAction)donePressed:(id)sender {
    
    [self addMarkerToUserLocation];
    
    NSError *error = nil;
    if (![_managedObjectContext save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        [_delegate addMarker:_pin];
    }];
}

-(BOOL) textFieldShouldReturn: (UITextField *) textField
{
    [textField resignFirstResponder];
    
    
    // You can access textField.text and do what you need to do with the text here
    
    return YES; // We'll let the textField handle the rest!
}

@end
