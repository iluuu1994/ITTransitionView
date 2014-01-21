//
//  ITGlueTransition.m
//  ITTransitionView-Demo
//
//  Created by Ilija Tovilo on 21/01/14.
//  Copyright (c) 2014 Ilija Tovilo. All rights reserved.
//

#import "ITGlueTransition.h"
#import <QuartzCore/QuartzCore.h>

@implementation ITGlueTransition

- (void)prepareForUsage {
    const CGFloat viewWidth = self.transitionViewBounds.size.width;
    const CGFloat viewHeight = self.transitionViewBounds.size.height;
    const CGFloat widthAngle = M_PI / 4.0f;
    const CGFloat heightAngle = M_PI / 6.0f;
    
    CABasicAnimation * inSwipeAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    inSwipeAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    CGPoint anchorPoint;
    CATransform3D startTranslation;
    CATransform3D rotation;
    switch (self.orientation) {
        case ITTransitionOrientationRightToLeft:
        {
            inSwipeAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(1.5 *viewWidth, 0.0f, 0.0f)];
            anchorPoint = CGPointMake(0, 0.5f);
            startTranslation = CATransform3DMakeTranslation(-viewWidth * 0.5f, 0, 0);
            rotation = CATransform3DRotate(startTranslation,widthAngle, 0, 1.0f, 0);
        }
            break;
        case ITTransitionOrientationLeftToRight:
        {
            inSwipeAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(- 1.5 * viewWidth, 0.0f, 0.0f)];
            anchorPoint = CGPointMake(1.0f, 0.5f);
            startTranslation = CATransform3DMakeTranslation(viewWidth * 0.5f, 0, 0);
            rotation = CATransform3DRotate(startTranslation, -widthAngle, 0, 1.0f, 0);
        }
            break;
        case ITTransitionOrientationTopToBottom:
        {
            inSwipeAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0.0f, - 1.5 * viewHeight, 0.0f)];
            anchorPoint = CGPointMake(0.5f, 1.0f);
            startTranslation = CATransform3DMakeTranslation(0, viewHeight * 0.5f, 0);
            rotation = CATransform3DRotate(startTranslation, heightAngle, 1.0f, 0, 0);
        }
            break;
        case ITTransitionOrientationBottomToTop:
        {
            inSwipeAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0.0f, 1.5 * viewHeight, 0.0f)];
            anchorPoint = CGPointMake(0.5f, 0);
            startTranslation = CATransform3DMakeTranslation(0, -viewHeight * 0.5f, 0);
            rotation = CATransform3DRotate(startTranslation, -heightAngle, 1.0f, 0, 0);
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
    
    CATransform3D endTranslation = CATransform3DTranslate(startTranslation, 0, 0, -viewWidth * 0.7f);
    
    CABasicAnimation * outAnchorPointAnimation = [CABasicAnimation animationWithKeyPath:@"anchorPoint"];
    outAnchorPointAnimation.fromValue = [NSValue valueWithPoint:anchorPoint];
    outAnchorPointAnimation.toValue = [NSValue valueWithPoint:anchorPoint];
    
    CAKeyframeAnimation * outTransformKeyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    outTransformKeyFrameAnimation.values = @[[NSValue valueWithCATransform3D:startTranslation], [NSValue valueWithCATransform3D:rotation], [NSValue valueWithCATransform3D:endTranslation]];
    outTransformKeyFrameAnimation.timingFunctions = [self getCircleApproximationTimingFunctions];
    
    CAKeyframeAnimation * outOpacityKeyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    outOpacityKeyFrameAnimation.values = @[@1.0f, @1.0f, @0.0f];
    
    CAAnimationGroup * outAnimation = [CAAnimationGroup animation];
    [outAnimation setAnimations:@[outOpacityKeyFrameAnimation, outTransformKeyFrameAnimation, outAnchorPointAnimation]];
    outAnimation.duration = self.duration;
    
    self.inAnimation = inAnimation;
    self.outAnimation = outAnimation;
}


@end
