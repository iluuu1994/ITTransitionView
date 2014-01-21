//
//  ITSwipeTransition.m
//  ITTransitionView-Demo
//
//  Created by Ilija Tovilo on 21/01/14.
//  Copyright (c) 2014 Ilija Tovilo. All rights reserved.
//

#import "ITSwipeTransition.h"
#import <QuartzCore/QuartzCore.h>

@implementation ITSwipeTransition

- (void)prepareForUsage {
    const CGFloat viewWidth = self.transitionViewBounds.size.width;
    const CGFloat viewHeight = self.transitionViewBounds.size.height;
    
    CABasicAnimation * inSwipeAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    inSwipeAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    CABasicAnimation * outSwipeAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    outSwipeAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    switch (self.orientation) {
        case ITTransitionOrientationRightToLeft:
        {
            inSwipeAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(viewWidth, 0.0f, 0.0f)];
            outSwipeAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(- viewWidth, 0.0f, 0.0f)];
        }
            break;
        case ITTransitionOrientationLeftToRight:
        {
            inSwipeAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(- viewWidth, 0.0f, 0.0f)];
            outSwipeAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(viewWidth, 0.0f, 0.0f)];
        }
            break;
        case ITTransitionOrientationTopToBottom:
        {
            inSwipeAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0.0f, - viewHeight, 0.0f)];
            outSwipeAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0.0f, viewHeight, 0.0f)];
        }
            break;
        case ITTransitionOrientationBottomToTop:
        {
            inSwipeAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0.0f, viewHeight, 0.0f)];
            outSwipeAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0.0f, - viewHeight, 0.0f)];
        }
            break;
        default:
            NSAssert(FALSE, @"Unhandled ADTransitionOrientation");
            break;
    }
    inSwipeAnimation.duration = self.duration;
    outSwipeAnimation.duration = self.duration;
    
    CABasicAnimation * inPositionAnimation = [CABasicAnimation animationWithKeyPath:@"zPosition"];
    inPositionAnimation.fromValue = @-0.001;
    inPositionAnimation.toValue = @-0.001;
    inPositionAnimation.duration = self.duration;
    
    CAAnimationGroup * inAnimation = [CAAnimationGroup animation];
    inAnimation.animations = @[inSwipeAnimation, inPositionAnimation];
    inAnimation.duration = self.duration;
    
    CABasicAnimation * outPositionAnimation = [CABasicAnimation animationWithKeyPath:@"zPosition"];
    outPositionAnimation.fromValue = @-0.001;
    outPositionAnimation.toValue = @-0.001;
    outPositionAnimation.duration = self.duration;
    
    CAAnimationGroup * outAnimation = [CAAnimationGroup animation];
    outAnimation.animations = @[outSwipeAnimation, outPositionAnimation];
    outAnimation.duration = self.duration;
    
    self.inAnimation = inAnimation;
    self.outAnimation = outAnimation;
}

@end
