//
//  ITPushRotateTransition.m
//  ITTransitionView-Demo
//
//  Created by Ilija Tovilo on 21/01/14.
//  Copyright (c) 2014 Ilija Tovilo. All rights reserved.
//

#import "ITPushRotateTransition.h"
#import <QuartzCore/QuartzCore.h>

@implementation ITPushRotateTransition

- (void)prepareForUsage {
    const CGFloat viewWidth = self.transitionViewBounds.size.width;
    const CGFloat viewHeight = self.transitionViewBounds.size.height;
    const CGFloat angle = M_PI / 2.0f;
    
    CABasicAnimation * inSwipeAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    inSwipeAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    CGPoint anchorPoint;
    CATransform3D startTranslation;
    CATransform3D rotation;
    switch (self.orientation) {
        case ITTransitionOrientationRightToLeft:
        {
            inSwipeAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(viewWidth, 0.0f, 0.0f)];
            anchorPoint = CGPointMake(0, 0.5f);
            startTranslation = CATransform3DMakeTranslation(-viewWidth * 0.5f, 0, 0);
            rotation = CATransform3DRotate(startTranslation, angle, 0, 1.0f, 0);
        }
            break;
        case ITTransitionOrientationLeftToRight:
        {
            inSwipeAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-viewWidth, 0.0f, 0.0f)];
            anchorPoint = CGPointMake(1.0f, 0.5f);
            startTranslation = CATransform3DMakeTranslation(viewWidth * 0.5f, 0, 0);
            rotation = CATransform3DRotate(startTranslation, -angle, 0, 1.0f, 0);
        }
            break;
        case ITTransitionOrientationTopToBottom:
        {
            inSwipeAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0.0f, -viewHeight, 0.0f)];
            anchorPoint = CGPointMake(0.5f, 1.0f);
            startTranslation = CATransform3DMakeTranslation(0, viewHeight * 0.5f, 0);
            rotation = CATransform3DRotate(startTranslation, angle, 1.0f, 0, 0);
        }
            break;
        case ITTransitionOrientationBottomToTop:
        {
            inSwipeAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0.0f, viewHeight, 0.0f)];
            anchorPoint = CGPointMake(0.5f, 0);
            startTranslation = CATransform3DMakeTranslation(0, -viewHeight * 0.5f, 0);
            rotation = CATransform3DRotate(startTranslation, -angle, 1.0f, 0, 0);
        }
            break;
        default:
            NSAssert(FALSE, @"Unhandled ADTransitionOrientation");
            break;
    }
    inSwipeAnimation.duration = self.duration;
    
    CABasicAnimation * inPositionAnimation = [CABasicAnimation animationWithKeyPath:@"zPosition"];
    inPositionAnimation.fromValue = @-0.001;
    inPositionAnimation.toValue = @-0.001;
    inPositionAnimation.duration = self.duration;
    
    CAAnimationGroup * inAnimation = [CAAnimationGroup animation];
    inAnimation.animations = @[inSwipeAnimation, inPositionAnimation];
    inAnimation.duration = self.duration;
    
    CABasicAnimation * outAnchorPointAnimation = [CABasicAnimation animationWithKeyPath:@"anchorPoint"];
    outAnchorPointAnimation.fromValue = [NSValue valueWithPoint:anchorPoint];
    outAnchorPointAnimation.toValue = [NSValue valueWithPoint:anchorPoint];
    
    CABasicAnimation * outRotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    outRotationAnimation.fromValue = [NSValue valueWithCATransform3D:startTranslation];
    outRotationAnimation.toValue = [NSValue valueWithCATransform3D:rotation];
    
    CABasicAnimation * outOpacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    outOpacityAnimation.fromValue = @1.0f;
    outOpacityAnimation.toValue = @0.0f;
    
    CAAnimationGroup * outAnimation = [CAAnimationGroup animation];
    [outAnimation setAnimations:@[outOpacityAnimation, outRotationAnimation, outAnchorPointAnimation]];
    
    outAnimation.duration = self.duration;
    
    self.inAnimation = inAnimation;
    self.outAnimation = outAnimation;
}

@end
