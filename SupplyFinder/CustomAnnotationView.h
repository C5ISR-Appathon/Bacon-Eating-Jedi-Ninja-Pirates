//
//  CustomAnnotationView.h
//  SupplyFinder
//
//  Created by Bobby Schuchert on 11/28/12.
//  Copyright (c) 2012 SPARC. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotationView.h>

@interface CustomAnnotationView : MKAnnotationView

@property (nonatomic, assign) id <MKMapViewDelegate> delegate;
@property (nonatomic, assign) MKAnnotationViewDragState dragState;
@property (nonatomic, assign) MKMapView *mapView;


@end
