//
//  ViewController.m
//  SupplyFinder
//
//  Created by Bobby Schuchert on 11/28/12.
//  Copyright (c) 2012 SPARC. All rights reserved.
//

#import "ViewController.h"
#import "Pin.h"


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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
