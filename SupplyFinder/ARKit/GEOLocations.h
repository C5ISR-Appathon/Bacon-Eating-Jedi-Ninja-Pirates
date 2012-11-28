//
//  GEOLocations.h
//  AR Kit
//
//  Created by Niels W Hansen on 12/19/09.
//  Copyright 2011 Agilite Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARLocationDelegate.h"
 
@class ARCoordinate;

@interface GEOLocations : NSObject {
	

	id<ARLocationDelegate> _theDelegate;
}

@property(nonatomic, strong) id<ARLocationDelegate> theDelegate;

- (id)initWithDelegate:(id<ARLocationDelegate>) aDelegate;
-(NSMutableArray*) returnLocations;




@end
