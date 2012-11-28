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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segmentChanged:(id)sender {
    
    
    NSInteger selectedIndex = [_categorySegment selectedSegmentIndex];
    
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



@end
