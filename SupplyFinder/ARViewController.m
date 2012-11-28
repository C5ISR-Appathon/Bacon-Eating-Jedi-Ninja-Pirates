//
//  ARViewController.m
//  ARKitDemo
//
//  Modified by Niels W Hansen on 12/31/11.
//  Copyright 2011 Agilite Software. All rights reserved.
//

#import "ARViewController.h"
#import "AugmentedRealityController.h"
#import "GEOLocations.h"
#import "MarkerView.h"
#import "ContentManager.h"

@implementation ARViewController

@synthesize agController;
@synthesize delegate;

-(id)initWithDelegate:(id<ARLocationDelegate>) aDelegate {
	
	[self setDelegate:aDelegate];
	
	if (!(self = [super init]))
		return nil;
	
	[self setWantsFullScreenLayout: YES];
    
 	return self;
}

- (void)loadView {
    
	AugmentedRealityController*  arc = [[AugmentedRealityController alloc] initWithViewController:self withDelgate:self];
	
	[arc setDebugMode:[[ContentManager sharedContentManager] debugMode]];
	[arc setScaleViewsBasedOnDistance:[[ContentManager sharedContentManager] scaleOnDistance]];
	[arc setMinimumScaleFactor:0.5];
	[arc setRotateViewsBasedOnPerspective:YES];
    [arc updateDebugMode:![arc debugMode]];
    
    
    //add Nightvision view
    
    _nightVisionView = [[UIView alloc] initWithFrame:self.view.frame];
    _nightVisionView.backgroundColor = [UIColor clearColor];
    [[self view] addSubview:_nightVisionView];
    
    [_nightVisionView release];
    
    
    
    
    
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 60, 30)];
    [closeBtn setTitle:@"Close" forState:UIControlStateNormal];
    [closeBtn setBackgroundColor:[UIColor redColor]];
    [closeBtn addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:closeBtn];
    [closeBtn release];
    
    
    UIButton *nvBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-120), 20, 120, 30)];
    [nvBtn setTitle:@"NV Mode" forState:UIControlStateNormal];
    [nvBtn setBackgroundColor:[UIColor greenColor]];
    [nvBtn addTarget:self action:@selector(enableNightVision:) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:nvBtn];
    
    nvEnabled = NO;
    
    [nvBtn release];
    
    
    
	GEOLocations* locations = [[GEOLocations alloc] initWithDelegate:delegate];
	
	if ([[locations returnLocations] count] > 0) {
		for (ARGeoCoordinate *coordinate in [locations returnLocations]) {
			MarkerView *cv = [[MarkerView alloc] initForCoordinate:coordinate withDelgate:self withCategory:coordinate.category] ;
            [coordinate setDisplayView:cv];
            
			[arc addCoordinate:coordinate];
			[cv release];
		}
	}
    
    [self setAgController:arc];
    [arc release];
	[locations release];
}

- (IBAction)closeButtonClicked:(id)sender {
    [self setAgController:nil];
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

-(void) didTapMarker:(ARGeoCoordinate *) coordinate {
    NSLog(@"delegate worked click on %@", [coordinate title]);
    [delegate locationClicked:coordinate];
    
}

-(void) didUpdateHeading:(CLHeading *)newHeading {
    NSLog(@"Heading Updated");

}
-(void) didUpdateLocation:(CLLocation *)newLocation {
    NSLog(@"Location Updated");

}
-(void) didUpdateOrientation:(UIDeviceOrientation) orientation {
    NSLog(@"Orientation Updated");
    
    if (orientation == UIDeviceOrientationPortrait)
        NSLog(@"Protrait");

}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [agController release];
	agController = nil;
}

- (void)dealloc {
    [super dealloc];
}


-(IBAction) enableNightVision:(UIButton*)sender {
    
    if (!nvEnabled) {
        sender.backgroundColor = [UIColor blueColor];
        _nightVisionView.backgroundColor = [UIColor colorWithRed:0 green:255 blue:0 alpha:0.30];
        nvEnabled = YES;
    } else {
        sender.backgroundColor = [UIColor greenColor];
        _nightVisionView.backgroundColor = [UIColor clearColor];
        nvEnabled = NO;
        
    }

    

}


@end
