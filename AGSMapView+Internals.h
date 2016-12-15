//
//  AGSMapView+Internals.h
//  TestingZoom
//
//  Created by Abdelrahman Badary on 12/12/16.
//  Copyright © 2016 Abdelrahman Badary. All rights reserved.
//

#import <ArcGIS/ArcGIS.h>
#import <objc/runtime.h>

@interface AGSMapView (Internals)
@property(nonatomic , strong) id maxZoomInScale;
@property(nonatomic , strong) UIPinchGestureRecognizer * internalGestureRecognizers;

-(void)enableMaximumZoomInLevel:(double)MaxInScale;
-(void)enableMaximumZoomOutLevel:(double)MaxOutScale;

@end
