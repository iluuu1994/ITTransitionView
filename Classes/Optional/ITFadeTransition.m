//
//  ITFadeTransition.m
//  ITTransitionView-Demo
//
//  Created by Ilija Tovilo on 19/01/14.
//  Copyright (c) 2014 Ilija Tovilo. All rights reserved.
//

#import "ITFadeTransition.h"
#import <QuartzCore/QuartzCore.h>

@implementation ITFadeTransition

- (void)prepareForUsage {
    CABasicAnimation * inFadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    inFadeAnimation.fromValue = @0.0f;
    inFadeAnimation.toValue = @1.0f;
    inFadeAnimation.duration = self.duration;
    
    CABasicAnimation * outFadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    outFadeAnimation.fromValue = @1.0f;
    outFadeAnimation.toValue = @0.0f;
    outFadeAnimation.duration = self.duration;
    
    self.inAnimation = inFadeAnimation;
    self.outAnimation = outFadeAnimation;
}

@end
