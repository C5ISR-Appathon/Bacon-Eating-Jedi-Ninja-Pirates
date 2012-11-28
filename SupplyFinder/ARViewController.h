//
//  ARViewController.h
//  ARKitDemo
//
//  Modified by Niels W Hansen on 12/31/11.
//  Copyright 2011 Agilite Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARLocationDelegate.h"
#import "ARViewProtocol.h"


@class AugmentedRealityController;

@interface ARViewController : UIViewController<ARMarkerDelegate, ARDelegate> {
	AugmentedRealityController	*agController;
	id<ARLocationDelegate> delegate;
    BOOL nvEnabled;
}

@property (nonatomic, retain) AugmentedRealityController *agController;
@property (nonatomic, assign) id<ARLocationDelegate> delegate;
@property (nonatomic, assign) UIView *nightVisionView;
@property (nonatomic, assign) UIButton *nightVisionButton;

-(id)initWithDelegate:(id<ARLocationDelegate>) aDelegate;




@end

