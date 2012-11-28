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
#import <AVFoundation/AVFoundation.h>


@class AugmentedRealityController;

@interface ARViewController : UIViewController<ARMarkerDelegate, ARDelegate, AVAudioPlayerDelegate> {
	AugmentedRealityController	*agController;
	id<ARLocationDelegate> delegate;
    BOOL nvEnabled;
}

@property (nonatomic, retain) AugmentedRealityController *agController;
@property (nonatomic, assign) id<ARLocationDelegate> delegate;
@property (nonatomic, assign) UIView *nightVisionView;

-(id)initWithDelegate:(id<ARLocationDelegate>) aDelegate;




@end

