//
//  ITFlipTransition.m
//  ITTransitionView-Demo
//
//  Created by Ilija Tovilo on 19/01/14.
//  Copyright (c) 2014 Ilija Tovilo. All rights reserved.
//

#import "ITFlipTransition.h"
#import <QuartzCore/QuartzCore.h>

@implementation ITFlipTransition

- (void)prepareForUsage {
    CGFloat viewWidth = self.sourceRect.size.width;
    CGFloat viewHeight = self.sourceRect.size.height;
    
    CAKeyframeAnimation * zTranslationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"zPosition"];
    
    CATransform3D inPivotTransform = CATransform3DIdentity;
    CATransform3D outPivotTransform = CATransform3DIdentity;
    
    switch (self.orientation) {
        case ITTransitionOrientationRightToLeft:
        {
            zTranslationAnimation.values = @[@0.0f, @(-viewWidth * 0.5f), @0.0f];
            inPivotTransform = CATransform3DRotate(inPivotTransform, M_PI - 0.001, 0.0f, 1.0f, 0.0f);
            outPivotTransform = CATransform3DRotate(outPivotTransform, -M_PI + 0.001, 0.0f, 1.0f, 0.0f);
        }
            break;
        case ITTransitionOrientationLeftToRight:
        {
            zTranslationAnimation.values = @[@0.0f, @(-viewWidth * 0.5f), @0.0f];
            inPivotTransform = CATransform3DRotate(inPivotTransform, M_PI + 0.001, 0.0f, 1.0f, 0.0f);
            outPivotTransform = CATransform3DRotate(outPivotTransform, - M_PI - 0.001, 0.0f, 1.0f, 0.0f);
        }
            break;
        case ITTransitionOrientationBottomToTop:
        {
            zTranslationAnimation.values = @[@0.0f, @(-viewHeight * 0.5f), @0.0f];
            inPivotTransform = CATransform3DRotate(inPivotTransform, M_PI + 0.001, 1.0f, .0f, 0.0f);
            outPivotTransform = CATransform3DRotate(outPivotTransform, - M_PI - 0.001, 1.0f, 0.0f, 0.0f);
        }
            break;
        case ITTransitionOrientationTopToBottom:
        {
            zTranslationAnimation.values = @[@0.0f, @(-viewHeight * 0.5f), @0.0f];
            inPivotTransform = CATransform3DRotate(inPivotTransform, M_PI - 0.001, 1.0f, .0f, 0.0f);
            outPivotTransform = CATransform3DRotate(outPivotTransform, - M_PI + 0.001, 1.0f, 0.0f, 0.0f);
        }
            break;
        default:
            NSAssert(FALSE, @"Unhandled ADFlipTransitionOrientation!");
            break;
    }
    
    zTranslationAnimation.timingFunctions = [self getCircleApproximationTimingFunctions];
    
    CAKeyframeAnimation * inFlipAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    inFlipAnimation.values = @[[NSValue valueWithCATransform3D:inPivotTransform], [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    inFlipAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    
    CAKeyframeAnimation * outFlipAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    outFlipAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DIdentity], [NSValue valueWithCATransform3D:outPivotTransform]];
    outFlipAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    
    CAAnimationGroup * inAnimation = [CAAnimationGroup animation];
    [inAnimation setAnimations:@[inFlipAnimation, zTranslationAnimation]];
    inAnimation.duration = self.duration;
    
    CAAnimationGroup * outAnimation = [CAAnimationGroup animation];
    [outAnimation setAnimations:@[outFlipAnimation, zTranslationAnimation]];
    outAnimation.duration = self.duration;
    
    self.inAnimation = inAnimation;
    self.outAnimation = outAnimation;
}

@end
