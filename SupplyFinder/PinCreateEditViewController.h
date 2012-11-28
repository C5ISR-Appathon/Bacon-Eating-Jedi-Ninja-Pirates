//
//  PinCreateEditViewController.h
//  SupplyFinder
//
//  Created by Jonathan Spohn on 11/28/12.
//  Copyright (c) 2012 SPARC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pin.h"
#import "AppDelegate.h"

@protocol PinCreateEditDelegate <NSObject>

-(void)addMarker:(Pin *)thePin;

@end

@interface PinCreateEditViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISegmentedControl *categorySegment;
@property (strong, nonatomic) Pin *pin;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) AppDelegate *appDelegate;

@property (strong, nonatomic) id<PinCreateEditDelegate> delegate;

@end
