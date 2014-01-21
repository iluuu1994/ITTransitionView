//
//  ITBackFadeTransition.m
//  ITTransitionView-Demo
//
//  Created by Ilija Tovilo on 21/01/14.
//  Copyright (c) 2014 Ilija Tovilo. All rights reserved.
//

#import "ITBackFadeTransition.h"
#import <QuartzCore/QuartzCore.h>

@implementation ITBackFadeTransition

- (void)prepareForUsage {
    CABasicAnimation * inFadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    inFadeAnimation.fromValue = @0.0f;
    inFadeAnimation.toValue = @1.0f;
    
    CABasicAnimation * outFadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    outFadeAnimation.fromValue = @1.0f;
    outFadeAnimation.toValue = @0.0f;
    
    CAKeyframeAnimation * backFadeTranslation = [CAKeyframeAnimation animationWithKeyPath:@"zPosition"];
    backFadeTranslation.values = @[@0.0f, @-2000.0f, @0.0f];
    
    CAMediaTimingFunction * SShapedFunction = [CAMediaTimingFunction functionWithControlPoints:0.8f :0.0f :0.0f :0.2f];
    inFadeAnimation.timingFunction = SShapedFunction;
    outFadeAnimation.timingFunction = SShapedFunction;
    
    CAAnimationGroup * inAnimation = [CAAnimationGroup animation];
    [inAnimation setAnimations:@[backFadeTranslation, inFadeAnimation]];
    inAnimation.duration = self.duration;
    
    CAAnimationGroup * outAnimation = [CAAnimationGroup animation];
    [outAnimation setAnimations:@[backFadeTranslation, outFadeAnimation]];
    outAnimation.duration = self.duration;
    
    self.inAnimation = inAnimation;
    self.outAnimation = outAnimation;
}

@end
