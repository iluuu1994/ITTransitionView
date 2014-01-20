//
//  ITCarrouselTransition.m
//  ITTransitionView-Demo
//
//  Created by Ilija Tovilo on 19/01/14.
//  Copyright (c) 2014 Ilija Tovilo. All rights reserved.
//

#import "ITCarrouselTransition.h"
#import <QuartzCore/QuartzCore.h>

@implementation ITCarrouselTransition

- (void)prepareForUsage {
    CAAnimation * animation = nil;

    CGFloat viewWidth = self.sourceRect.size.width;
    CGFloat viewHeight = self.sourceRect.size.height;
    
    CGFloat zPositionMax = 0.0f;
    
    CATransform3D rotation = CATransform3DIdentity;
    if (self.orientation == ITTransitionOrientationRightToLeft) {
        zPositionMax = - viewWidth;
        rotation = CATransform3DTranslate(rotation, viewWidth * 0.5f, 0.0f, viewWidth * 0.5f);
        rotation = CATransform3DRotate(rotation, - M_PI * 0.5f, 0.0f, 1.0f, 0.0f);
        self.outTransform = CATransform3DRotate(self.outTransform, M_PI * 0.5f, 0.0f, 1.0f, 0.0f);
        self.outTransform = CATransform3DTranslate(self.outTransform, - viewWidth * 0.5f, 0.0f, - viewWidth * 0.5f);
    } else if (self.orientation == ITTransitionOrientationLeftToRight) {
        zPositionMax = - viewWidth;
        rotation = CATransform3DTranslate(rotation, - viewWidth * 0.5f, 0.0f, viewWidth * 0.5f);
        rotation = CATransform3DRotate(rotation, M_PI * 0.5f, 0.0f, 1.0f, 0.0f);
        self.outTransform = CATransform3DRotate(self.outTransform, - M_PI * 0.5f, 0.0f, 1.0f, 0.0f);
        self.outTransform = CATransform3DTranslate(self.outTransform, viewWidth * 0.5f, 0.0f, - viewWidth * 0.5f);
    } else if (self.orientation == ITTransitionOrientationTopToBottom) {
        zPositionMax = - viewHeight;
        rotation = CATransform3DTranslate(rotation, 0.0f, viewHeight * 0.5f, viewHeight * 0.5f);
        rotation = CATransform3DRotate(rotation, M_PI * 0.5f, 1.0f, 0.0f, 0.0f);
        self.outTransform = CATransform3DRotate(self.outTransform, - M_PI * 0.5f, 1.0f, 0.0f, 0.0f);
        self.outTransform = CATransform3DTranslate(self.outTransform, 0.0f, - viewHeight * 0.5f, - viewHeight * 0.5f);
    } else if (self.orientation == ITTransitionOrientationBottomToTop) {
        zPositionMax = - viewHeight;
        rotation = CATransform3DTranslate(rotation, 0.0f, - viewHeight * 0.5f, viewHeight * 0.5f);
        rotation = CATransform3DRotate(rotation,- M_PI * 0.5f, 1.0f, 0.0f, 0.0f);
        self.outTransform = CATransform3DRotate(self.outTransform, M_PI * 0.5f, 1.0f, 0.0f, 0.0f);
        self.outTransform = CATransform3DTranslate(self.outTransform, 0.0f, viewHeight * 0.5f, - viewHeight * 0.5f);
    } else {
        NSAssert(FALSE, @"Unhandled ADTransitionOrientation!");
    }
    
    CABasicAnimation * carrouselRotation = [CABasicAnimation animationWithKeyPath:@"transform"];
    carrouselRotation.fromValue = [NSValue valueWithCATransform3D:rotation];
    carrouselRotation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    carrouselRotation.duration = self.duration;
    
    CAKeyframeAnimation * zTranslationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"zPosition"];
    zTranslationAnimation.values = @[@0.0f, @(zPositionMax), @0.0f];
    zTranslationAnimation.timingFunctions = [self getCircleApproximationTimingFunctions];
    zTranslationAnimation.duration = self.duration;
    
    animation = [CAAnimationGroup animation];
    [(CAAnimationGroup *)animation setAnimations:@[carrouselRotation, zTranslationAnimation]];
    
    self.animation = animation;
    self.animation.duration = self.duration;
    self.animation.delegate = self;
}

@end
