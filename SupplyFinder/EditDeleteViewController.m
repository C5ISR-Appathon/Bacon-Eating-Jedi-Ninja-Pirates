//
//  EditDeleteViewController.m
//  SupplyFinder
//
//  Created by Jonathan Spohn on 11/28/12.
//  Copyright (c) 2012 SPARC. All rights reserved.
//

#import "EditDeleteViewController.h"

@interface EditDeleteViewController ()

@end

@implementation EditDeleteViewController

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
    //get managed object context from the app delegate
    _appDelegate = [[UIApplication sharedApplication] delegate];
    _managedObjectContext = [_appDelegate managedObjectContext];
    
    [_titleField setText:[_pin title]];
    
    [_categorySegment setSelectedSegmentIndex:[[_pin category] integerValue]];
    
    if([[_pin category] integerValue] == 0){
        //food
        [_catImage setImage:[UIImage imageNamed:@"food@2x.png"]];
    }else if([[_pin category] integerValue] == 1){
        //weapons
        [_catImage setImage:[UIImage imageNamed:@"gun icon@2x.png"]];
    }else if([[_pin category] integerValue] == 2){
        //fuel
        [_catImage setImage:[UIImage imageNamed:@"oil icon@2x.png"]];
    }else if([[_pin category] integerValue] == 3){
        //zombies
        [_catImage setImage:[UIImage imageNamed:@"zombie@2x.png"]];
    }else if([[_pin category] integerValue] == 4){
        //zombies
        [_catImage setImage:[UIImage imageNamed:@"companionship@2x.png"]];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backPressed:(id)sender {
    
    [_pin setTitle:[_titleField text]];
    
    [_managedObjectContext save:nil];
    
    NSArray *ants = [[(ViewController *)_delegate mapView] annotations];
    
    [[(ViewController *)_delegate mapView] removeAnnotations:ants];
    
    [[(ViewController *)_delegate mapView] addAnnotations:ants];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)segmentChanged:(id)sender {
    
    NSInteger selectedIndex = [_categorySegment selectedSegmentIndex];
    
    [_pin setCategory:[NSNumber numberWithInteger:selectedIndex]];
    
    if(selectedIndex == 0){
        //food
        [_catImage setImage:[UIImage imageNamed:@"food@2x.png"]];
    }else if(selectedIndex == 1){
        //weapons
        [_catImage setImage:[UIImage imageNamed:@"gun icon@2x.png"]];
    }else if(selectedIndex == 2){
        //fuel
        [_catImage setImage:[UIImage imageNamed:@"oil icon@2x.png"]];
    }else if(selectedIndex == 3){
        //zombies
        [_catImage setImage:[UIImage imageNamed:@"zombie@2x.png"]];
    }else if(selectedIndex == 4){
        //zombies
        [_catImage setImage:[UIImage imageNamed:@"companionship@2x.png"]];
    }
    
}

- (IBAction)deletePressed:(id)sender {
    
    [_managedObjectContext deleteObject:_pin];
    
    [_managedObjectContext save:nil];
    
    NSArray *ants = [[(ViewController *)_delegate mapView] annotations];
    
    [[(ViewController *)_delegate mapView] removeAnnotations:ants];
    
    [[(ViewController *)_delegate mapView] addAnnotations:ants];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
}

-(BOOL)shouldAutorotate
{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
