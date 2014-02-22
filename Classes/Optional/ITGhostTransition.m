//
//  ITGhostTransition.m
//  ITTransitionView-Demo
//
//  Created by Ilija Tovilo on 20/01/14.
//  Copyright (c) 2014 Ilija Tovilo. All rights reserved.
//

#import "ITGhostTransition.h"
#import <QuartzCore/QuartzCore.h>

@implementation ITGhostTransition

- (void)prepareForUsage {
    CABasicAnimation * inFadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    inFadeAnimation.fromValue = @0.0f;
    inFadeAnimation.toValue = @1.0f;
    
    CABasicAnimation * inScaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    inScaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(2.0f, 2.0f, 2.0f)];
    inScaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    CAAnimationGroup * inAnimation = [CAAnimationGroup animation];
    [inAnimation setAnimations:@[inFadeAnimation, inScaleAnimation]];
    inAnimation.duration = self.duration;
    if (self.timingFunction) inAnimation.timingFunction = self.timingFunction;
    
    CABasicAnimation * outFadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    outFadeAnimation.fromValue = @1.0f;
    outFadeAnimation.toValue = @0.0f;
    
    CABasicAnimation * outScaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    outScaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    outScaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 0.01f)];
    
    CAAnimationGroup * outAnimation = [CAAnimationGroup animation];
    [outAnimation setAnimations:@[outFadeAnimation, outScaleAnimation]];
    outAnimation.duration = self.duration;
    if (self.timingFunction) outAnimation.timingFunction = self.timingFunction;
    
    self.inAnimation = inAnimation;
    self.outAnimation = outAnimation;
}

@end
