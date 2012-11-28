//
//  EditDeleteViewController.h
//  SupplyFinder
//
//  Created by Jonathan Spohn on 11/28/12.
//  Copyright (c) 2012 SPARC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pin.h"
#import "AppDelegate.h"

@interface EditDeleteViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *titleField;
@property (strong, nonatomic) IBOutlet UISegmentedControl *categorySegment;
@property (strong, nonatomic) IBOutlet UIImageView *catImage;

@property (strong, nonatomic) Pin *pin;

@property (strong, nonatomic) id delegate;

@end
