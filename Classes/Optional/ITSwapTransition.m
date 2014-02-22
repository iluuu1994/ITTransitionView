//
//  ITSwapTransition.m
//  ITTransitionView-Demo
//
//  Created by Ilija Tovilo on 19/01/14.
//  Copyright (c) 2014 Ilija Tovilo. All rights reserved.
//

#import "ITSwapTransition.h"
#import <QuartzCore/QuartzCore.h>

@implementation ITSwapTransition

- (id)init {
    if (self = [super init]) {
        self.depth = 1000.f;
    }
    
    return self;
}

- (void)prepareForUsage
{
    CGFloat viewWidth = self.transitionViewBounds.size.width;
    CGFloat viewHeight = self.transitionViewBounds.size.height;
    
    CABasicAnimation * inZPosition = [CABasicAnimation animationWithKeyPath:@"zPosition"];
    inZPosition.fromValue = @( -self.depth );
    inZPosition.toValue = @0.0f;
    
    CATransform3D rightTransform = CATransform3DMakeTranslation(viewWidth * 0.6f, 0.0f, 0.0f);
    rightTransform = CATransform3DRotate(rightTransform,- M_PI / 5.0f, 0.0f, 1.0f, 0.0f);
    CATransform3D leftTransform = CATransform3DMakeTranslation(-viewWidth * 0.6, 0.0f, 0.0f);
    leftTransform = CATransform3DRotate(leftTransform, M_PI / 5.0f, 0.0f, 1.0f, 0.0f);
    CATransform3D topTransform = CATransform3DMakeTranslation(0.0f, -viewHeight * 0.6f, 0.0f);
    topTransform = CATransform3DRotate(topTransform,- M_PI / 5.0f, 1.0f, 0.0f, 0.0f);
    CATransform3D bottomTransform = CATransform3DMakeTranslation(0.0f, viewHeight * 0.6f, 0.0f);
    bottomTransform = CATransform3DRotate(bottomTransform, M_PI / 5.0f, 1.0f, 0.0f, 0.0f);
    
    CAKeyframeAnimation * inPosition = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    CAKeyframeAnimation * outPosition = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    switch (self.orientation) {
        case ITTransitionOrientationRightToLeft:
        {
            inPosition.values = @[[NSValue valueWithCATransform3D:CATransform3DIdentity], [NSValue valueWithCATransform3D:rightTransform], [NSValue valueWithCATransform3D:CATransform3DIdentity]];
            outPosition.values = @[[NSValue valueWithCATransform3D:CATransform3DIdentity], [NSValue valueWithCATransform3D:leftTransform], [NSValue valueWithCATransform3D:CATransform3DIdentity]];
        }
            break;
        case ITTransitionOrientationLeftToRight:
        {
            inPosition.values = @[[NSValue valueWithCATransform3D:CATransform3DIdentity], [NSValue valueWithCATransform3D:leftTransform], [NSValue valueWithCATransform3D:CATransform3DIdentity]];
            outPosition.values = @[[NSValue valueWithCATransform3D:CATransform3DIdentity], [NSValue valueWithCATransform3D:rightTransform], [NSValue valueWithCATransform3D:CATransform3DIdentity]];
        }
            break;
        case ITTransitionOrientationBottomToTop:
        {
            inPosition.values = @[[NSValue valueWithCATransform3D:CATransform3DIdentity], [NSValue valueWithCATransform3D:bottomTransform], [NSValue valueWithCATransform3D:CATransform3DIdentity]];
            outPosition.values = @[[NSValue valueWithCATransform3D:CATransform3DIdentity], [NSValue valueWithCATransform3D:topTransform], [NSValue valueWithCATransform3D:CATransform3DIdentity]];
        }
            break;
        case ITTransitionOrientationTopToBottom:
        {
            inPosition.values = @[[NSValue valueWithCATransform3D:CATransform3DIdentity], [NSValue valueWithCATransform3D:topTransform], [NSValue valueWithCATransform3D:CATransform3DIdentity]];
            outPosition.values = @[[NSValue valueWithCATransform3D:CATransform3DIdentity], [NSValue valueWithCATransform3D:bottomTransform], [NSValue valueWithCATransform3D:CATransform3DIdentity]];
        }
            break;
        default:
            NSAssert(FALSE, @"Unhandlded ADSwapTransitionOrientation!");
            break;
    }
    
    CABasicAnimation * outZPosition = [CABasicAnimation animationWithKeyPath:@"zPosition"];
    outZPosition.fromValue = @0.0f;
    outZPosition.toValue = @( -self.depth );
    
    inPosition.timingFunctions = [self getCircleApproximationTimingFunctions];
    outPosition.timingFunctions = [self getCircleApproximationTimingFunctions];
    
    CAMediaTimingFunction * LinearFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    inPosition.timingFunction = LinearFunction;
    outPosition.timingFunction = LinearFunction;
    
    CAAnimationGroup * inAnimation = [CAAnimationGroup animation];
    [inAnimation setAnimations:@[inZPosition, inPosition]];
    inAnimation.duration = self.duration;
    if (self.timingFunction) inAnimation.timingFunction = self.timingFunction;
    
    CAAnimationGroup * outAnimation = [CAAnimationGroup animation];
    [outAnimation setAnimations:@[outZPosition, outPosition]];
    outAnimation.duration = self.duration;
    if (self.timingFunction) outAnimation.timingFunction = self.timingFunction;
    
    self.inAnimation = inAnimation;
    self.outAnimation = outAnimation;
}

@end
