//
//  ITZoomTransition.m
//  ITTransitionView-Demo
//
//  Created by Ilija Tovilo on 21/01/14.
//  Copyright (c) 2014 Ilija Tovilo. All rights reserved.
//

#import "ITZoomTransition.h"
#import <QuartzCore/QuartzCore.h>

CGPoint ITRectCenter(CGRect rect) {
    return CGPointMake(rect.origin.x + rect.size.width/2.0f, rect.origin.y + rect.size.height/2.0f);
}

@implementation ITZoomTransition

- (void)prepareForUsage {
    CABasicAnimation * zoomAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D transform = CATransform3DIdentity;
    CGPoint sourceCenter = ITRectCenter(self.sourceRect);
    CGPoint targetCenter = ITRectCenter(self.targetRect);
    transform = CATransform3DTranslate(transform, sourceCenter.x - targetCenter.x, sourceCenter.y - targetCenter.y, 0.0f);
    transform = CATransform3DScale(transform, self.sourceRect.size.width/self.targetRect.size.width, self.sourceRect.size.height/self.targetRect.size.height, 1.0f);
    zoomAnimation.fromValue = [NSValue valueWithCATransform3D:transform];
    zoomAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    zoomAnimation.duration = self.duration;
    
    CABasicAnimation * outAnimation = [CABasicAnimation animationWithKeyPath:@"zPosition"];
    outAnimation.fromValue = @-0.001;
    outAnimation.toValue = @-0.001;
    outAnimation.duration = self.duration;
    
    self.inAnimation = zoomAnimation;
    self.outAnimation = outAnimation;
}

@end
