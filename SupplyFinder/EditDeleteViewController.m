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
    
    [_titleField setText:[_pin title]];
    
    [_categorySegment setSelectedSegmentIndex:[[_pin category] integerValue]];
    
    if([[_pin category] integerValue] == 0){
        //food
        [_catImage setImage:[UIImage imageNamed:@"food.png"]];
    }else if([[_pin category] integerValue] == 1){
        //weapons
        [_catImage setImage:[UIImage imageNamed:@"gun icon.png"]];
    }else if([[_pin category] integerValue] == 2){
        //fuel
        [_catImage setImage:[UIImage imageNamed:@"oil icon.png"]];
    }else if([[_pin category] integerValue] == 3){
        //zombies
        [_catImage setImage:[UIImage imageNamed:@"zombie.png"]];
    }else if([[_pin category] integerValue] == 4){
        //zombies
        [_catImage setImage:[UIImage imageNamed:@"companionship.png"]];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
