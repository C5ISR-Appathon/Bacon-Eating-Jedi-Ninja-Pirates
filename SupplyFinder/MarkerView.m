//
//  CoordinateView.m
//  ARKitDemo
//
//  Modified by Niels W Hansen on 12/31/11.
//  Copyright 2011 Agilite Software. All rights reserved.
//

#import "ARViewProtocol.h"
#import "ARGeoCoordinate.h"
#import "MarkerView.h"
#import <QuartzCore/QuartzCore.h>



#define BOX_WIDTH 300
#define BOX_HEIGHT 50
#define BOX_GAP 10
#define BOX_ALPHA 0.5
#define LABEL_HEIGHT 20.0


@implementation MarkerView


@synthesize coordinateInfo;
@synthesize delegate;
@synthesize lblDistance;

- (id)initForCoordinate:(ARGeoCoordinate *)coordinate withDelgate:(id<ARMarkerDelegate>) aDelegate withCategory:(NSNumber *)category {
    
	[self setCoordinateInfo:coordinate];
    [self setDelegate:aDelegate];
	CGRect theFrame = CGRectMake(0, 0, BOX_WIDTH, BOX_HEIGHT);
	
	if ((self = [super initWithFrame:theFrame])) {
        
        [self setUserInteractionEnabled:YES]; // Allow for touches
        
        //  Rounded corners
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        
		UILabel *titleLabel	= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, BOX_WIDTH, 20.0)];

		[titleLabel setBackgroundColor: [UIColor clearColor]];
		[titleLabel setTextColor:		[UIColor whiteColor]];
		[titleLabel setTextAlignment:	NSTextAlignmentCenter];
		[titleLabel setText:			[coordinate title]];
		[titleLabel sizeToFit];
        
		[titleLabel setFrame: CGRectMake(BOX_WIDTH / 2.0 - [titleLabel bounds].size.width / 2.0 - 4.0, 0, 
                                         [titleLabel bounds].size.width + 8.0, [titleLabel bounds].size.height + 8.0)];
        
        UILabel *distLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, BOX_WIDTH, LABEL_HEIGHT)];
		
		[distLbl setBackgroundColor: [UIColor clearColor]];
		[distLbl setTextColor:		[UIColor whiteColor]];
		[distLbl setTextAlignment:	NSTextAlignmentCenter];
		[distLbl setText:			[NSString stringWithFormat:@"%g", [coordinate distanceFromOrigin]]];
		[distLbl sizeToFit];
        
        
		[distLbl setFrame: CGRectMake(BOX_WIDTH / 2.0 - [titleLabel bounds].size.width / 2.0 - 4.0, 
                                      [distLbl bounds].size.height, 
                                      [titleLabel bounds].size.width + 8.0, 
                                      [distLbl bounds].size.height + 8.0)];
        
        UIImageView *pointView	= [[UIImageView alloc] initWithFrame:CGRectZero];
        switch ([category intValue]) {
            case 0:
                [pointView setImage:[UIImage imageNamed:@"food.png"]];
                break;
            case 1:
                [pointView setImage:[UIImage imageNamed:@"gun icon.png"]];
                break;
            case 2:
                [pointView setImage:[UIImage imageNamed:@"oil icon.png"]];
                break;
            case 3:
                [pointView setImage:[UIImage imageNamed:@"zombie.png"]];
                break;
                
            default:
                break;
        }
        
		[pointView setFrame:	CGRectMake((int)(titleLabel.frame.origin.x - [pointView image].size.width),
                                           (int)(titleLabel.frame.origin.y + [pointView image].size.height / 2.0),
                                           [pointView image].size.width, 
                                           [pointView image].size.height)];
        
        [pointView setBackgroundColor:[UIColor clearColor]];
        
		[self addSubview:titleLabel];
        [self addSubview:distLbl];
        
        [self setLblDistance:distLbl];

		[self addSubview:pointView];
		[self setBackgroundColor:[UIColor colorWithWhite:0 alpha:BOX_ALPHA]];
        self.frame = CGRectMake(0, 0, titleLabel.frame.size.width, titleLabel.frame.size.height);
        
		[titleLabel release];
        [distLbl release];
		[pointView release];
        
	}
	
    return self;
}

-(void) drawRect:(CGRect)rect {
    [super drawRect:rect];
    [[self lblDistance] setText:[NSString stringWithFormat:@"%.2f km", [[self coordinateInfo] distanceFromOrigin]/1000.0f]];
    
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@ was touched!",[[self coordinateInfo] title]);
    [delegate didTapMarker:[self coordinateInfo]];

}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    CGRect theFrame = CGRectMake(0, 0, BOX_WIDTH, BOX_HEIGHT);
    
    if(CGRectContainsPoint(theFrame, point))
        return YES; // touched the view;
    
    return NO;
}



- (void)dealloc {
    [super dealloc];
}



@end
