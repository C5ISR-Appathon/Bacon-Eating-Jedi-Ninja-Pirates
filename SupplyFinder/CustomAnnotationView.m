//
//  CustomAnnotationView.m
//  SupplyFinder
//
//  Created by Bobby Schuchert on 11/28/12.
//  Copyright (c) 2012 SPARC. All rights reserved.
//

#import "CustomAnnotationView.h"

@implementation CustomAnnotationView
@synthesize delegate = _delegate;
@synthesize dragState = _dragState;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (void)setDragState:(MKAnnotationViewDragState)newDragState animated:(BOOL)animated
{
    [_delegate mapView:_mapView annotationView:self didChangeDragState:newDragState fromOldState:_dragState];
    
    if (newDragState == MKAnnotationViewDragStateStarting) {
        
        // lift the pin and set the state to dragging
        CGPoint endPoint = CGPointMake(self.center.x,self.center.y-20);
        [UIView animateWithDuration:0.2
                         animations:^{ self.center = endPoint; }
                         completion:^(BOOL finished) {
                             _dragState = MKAnnotationViewDragStateDragging;
        }];
    } else if (newDragState == MKAnnotationViewDragStateEnding) {
        
        // drop the pin, and set state to none
        CGPoint endPoint = CGPointMake(self.center.x,self.center.y+20);
        [UIView animateWithDuration:0.2
                         animations:^{ self.center = endPoint; }
                         completion:^(BOOL finished) {
                             _dragState = MKAnnotationViewDragStateNone;
        }];
    } else if (newDragState == MKAnnotationViewDragStateCanceling) {
        
        // drop the pin and set the state to none
        CGPoint endPoint = CGPointMake(self.center.x,self.center.y+20);
        [UIView animateWithDuration:0.2
                         animations:^{ self.center = endPoint; }
                         completion:^(BOOL finished) {
                            _dragState = MKAnnotationViewDragStateNone;
        }];
    }
}


@end
