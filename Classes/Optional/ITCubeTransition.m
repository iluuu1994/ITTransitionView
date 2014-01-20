//
//  ITCubeTransition.m
//  ITTransitionView-Demo
//
//  Created by Ilija Tovilo on 20/01/14.
//  Copyright (c) 2014 Ilija Tovilo. All rights reserved.
//

#import "ITCubeTransition.h"
#import <QuartzCore/QuartzCore.h>

@implementation ITCubeTransition

- (void)prepareForUsage {
    CAAnimation * animation = nil;
    CGFloat viewWidth = self.sourceRect.size.width;
    CGFloat viewHeight = self.sourceRect.size.height;
    CABasicAnimation * cubeRotation = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D rotation = CATransform3DIdentity;
    if (self.orientation == ITTransitionOrientationRightToLeft) {        
        rotation = CATransform3DTranslate(rotation, viewWidth * 0.5f, 0.0f, - viewWidth * 0.5f);
        rotation = CATransform3DRotate(rotation, M_PI * 0.5f, 0.0f, 1.0f, 0.0f);
        self.outTransform = CATransform3DRotate(self.outTransform, -M_PI * 0.5f, 0.0f, 1.0f, 0.0f);
        self.outTransform = CATransform3DTranslate(self.outTransform, - viewWidth * 0.5f, 0.0f, viewWidth * 0.5f);
    } else if (self.orientation == ITTransitionOrientationLeftToRight) {
        rotation = CATransform3DTranslate(rotation, - viewWidth * 0.5f, 0.0f, - viewWidth * 0.5f);
        rotation = CATransform3DRotate(rotation, -M_PI * 0.5f, 0.0f, 1.0f, 0.0f);
        self.outTransform = CATransform3DRotate(self.outTransform, M_PI * 0.5f, 0.0f, 1.0f, 0.0f);
        self.outTransform = CATransform3DTranslate(self.outTransform, viewWidth * 0.5f, 0.0f, viewWidth * 0.5f);
    } else if (self.orientation == ITTransitionOrientationTopToBottom) {
        rotation = CATransform3DTranslate(rotation, 0.0f, - viewHeight * 0.5f, - viewHeight * 0.5f);
        rotation = CATransform3DRotate(rotation, M_PI * 0.5f, 1.0f, 0.0f, 0.0f);
        self.outTransform = CATransform3DRotate(self.outTransform, - M_PI * 0.5f, 1.0f, 0.0f, 0.0f);
        self.outTransform = CATransform3DTranslate(self.outTransform, 0.0f, viewHeight * 0.5f, viewHeight * 0.5f);
    } else if (self.orientation == ITTransitionOrientationTopToBottom) {
        rotation = CATransform3DTranslate(rotation, 0.0f, viewHeight * 0.5f, - viewHeight * 0.5f);
        rotation = CATransform3DRotate(rotation, - M_PI * 0.5f, 1.0f, 0.0f, 0.0f);
        self.outTransform = CATransform3DRotate(self.outTransform, M_PI * 0.5f, 1.0f, 0.0f, 0.0f);
        self.outTransform = CATransform3DTranslate(self.outTransform, 0.0f, - viewHeight * 0.5f, viewHeight * 0.5f);
    } else {
        NSAssert(FALSE, @"Unhandled ADTransitionOrientation!");
    }
    
    cubeRotation.fromValue = [NSValue valueWithCATransform3D:rotation];
    cubeRotation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    cubeRotation.duration = self.duration;
    
    CAKeyframeAnimation * zTranslationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"zPosition"];
    zTranslationAnimation.values = @[@0.0f, @-36.0f, @0.0f];
    
    zTranslationAnimation.timingFunctions = [self getCircleApproximationTimingFunctions];
    zTranslationAnimation.duration = self.duration;
    
    animation = [CAAnimationGroup animation];
    [(CAAnimationGroup *)animation setAnimations:@[cubeRotation, zTranslationAnimation]];
    
    self.animation = animation;
    self.animation.duration = self.duration;
    self.animation.delegate = self;
}

@end
