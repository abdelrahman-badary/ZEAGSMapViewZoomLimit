//
//  AGSMapView+Internals.m
//  TestingZoom
//
//  Created by Abdelrahman Badary on 12/12/16.
//  Copyright © 2016 Abdelrahman Badary. All rights reserved.
//

#import "AGSMapView+Internals.h"

@interface AGSMapView (_Internals)

@property (nonatomic , strong) id maxZoomInScale;
@property (nonatomic , strong) id maxZoomOutScale;
@property(nonatomic , strong) UIPinchGestureRecognizer * internalGestureRecognizers;

-(void)pinchGesture;
@end

@implementation AGSMapView (Internals)

@dynamic maxZoomInScale , internalGestureRecognizers;

-(void)enableMaximumZoomInLevel:(double)MaxInScale
{
    self.maxZoomInScale = @(MaxInScale);
    
    UIPinchGestureRecognizer * mapPinchGestureRecognizer = [self getPinchGestureRecognizer];
    if(mapPinchGestureRecognizer)
    {
        self.internalGestureRecognizers = mapPinchGestureRecognizer;
    }
}
-(void)enableMaximumZoomOutLevel:(double)MaxOutScale
{
    self.maxZoomOutScale = @(MaxOutScale);
    
    UIPinchGestureRecognizer * mapPinchGestureRecognizer = [self getPinchGestureRecognizer];
    if(mapPinchGestureRecognizer)
    {
        self.internalGestureRecognizers = mapPinchGestureRecognizer;
    }
}

-(UIPinchGestureRecognizer *)getPinchGestureRecognizer
{
    NSArray * gestureRecognizers = [self gestureRecognizers];
    NSUInteger gestureRecognizersCount = [gestureRecognizers count];
    UIPinchGestureRecognizer * pinchRecognizer;
    for(int index = 0 ; index < gestureRecognizersCount ; index++)
    {
        UIGestureRecognizer * reco = [gestureRecognizers objectAtIndex:index];
        if([reco class] == [UIPinchGestureRecognizer class])
        {
            pinchRecognizer = (UIPinchGestureRecognizer *)reco ;
            break ;
        }
    }
    return pinchRecognizer;
}
-(void)overrideGestureRecognizer
{
    [[self internalGestureRecognizers] addTarget:self action:@selector(mapDidZoom:)];
    [[self internalGestureRecognizers] removeTarget:self action:@selector(pinchGesture)];
}

-(void)mapDidZoom:(UIGestureRecognizer *)recognizer
{
    UIPinchGestureRecognizer * r = (UIPinchGestureRecognizer *)recognizer;
    
    if(r.scale >1)
    {
        if([self shouldZoomIn])
            [self pinchGesture];
    }
    else if(r.scale < 1)
    {
        [self pinchGesture];
    }
}
-(BOOL)shouldZoomIn
{
    double currentMapScale = [self mapScale];
    double maxScale = [[self maxZoomInScale] doubleValue];
    if(currentMapScale <= maxScale)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

-(BOOL)shouldZoomOut
{
    double currentMapScale = [self mapScale];
    double maxScale = [[self maxZoomOutScale] doubleValue];
    if(currentMapScale >= maxScale)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

#pragma mark - setters and getters

-(void)setMaxZoomInScale:(id)maxZoomInScale
{
    objc_setAssociatedObject(self, @selector(maxZoomInScale), maxZoomInScale, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
-(id)maxZoomInScale
{
    return objc_getAssociatedObject(self, @selector(maxZoomInScale));
}

-(void)setInternalGestureRecognizers:(UIPinchGestureRecognizer *)internalGestureRecognizers
{
  objc_setAssociatedObject(self, @selector(internalGestureRecognizers), internalGestureRecognizers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIPinchGestureRecognizer *)internalGestureRecognizers
{
    return objc_getAssociatedObject(self, @selector(internalGestureRecognizers));
}


@end
