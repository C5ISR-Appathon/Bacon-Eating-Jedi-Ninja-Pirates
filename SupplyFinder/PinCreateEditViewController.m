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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segmentChanged:(id)sender {
    
    
    NSInteger selectedIndex = [_categorySegment selectedSegmentIndex];
    
    [_selectedPin setCategory:[NSNumber numberWithInteger:selectedIndex]];
    
    if(selectedIndex == 0){
        //food
        
        
    }else if(selectedIndex == 1){
        //weapons
        
    }else if(selectedIndex == 2){
        //fuel
        
    }else if(selectedIndex == 3){
        //zombies
        
    }
}

- (IBAction)donePressed:(id)sender {
    
    [_managedObjectContext save:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
