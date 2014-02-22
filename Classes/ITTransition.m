//
//  ITTransition.m
//  ITTransitionView-Demo
//
//  Created by Ilija Tovilo on 19/01/14.
//  Copyright (c) 2014 Ilija Tovilo. All rights reserved.
//

#import "ITTransition.h"
#import <QuartzCore/QuartzCore.h>

@implementation ITTransition

#pragma mark - Init
- (id)init
{
    if (self = [super init]) {
        self.duration = 0.5;
        self.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    }
    return self;
}

#pragma mark - Transition
- (void)transitionContainerView:(NSView *)containerView
          oldRepresentationView:(NSView *)oldRepresentationView
          newRepresentationView:(NSView *)newRepresentationView
{
    NSAssert(FALSE, @"%s needs to be overridden", __func__);
}

- (void)prepareForUsage
{
    NSAssert(FALSE, @"%s needs to be overridden", __func__);
}

- (NSArray *)getCircleApproximationTimingFunctions
{
    const double kappa = 4.0/3.0 * (sqrt(2.0)-1.0) / sqrt(2.0);
    CAMediaTimingFunction *firstQuarterCircleApproximationFuction = [CAMediaTimingFunction functionWithControlPoints:kappa /(M_PI/2.0f) :kappa :1.0-kappa :1.0];
    CAMediaTimingFunction * secondQuarterCircleApproximationFuction = [CAMediaTimingFunction functionWithControlPoints:kappa :0.0 :1.0-(kappa /(M_PI/2.0f)) :1.0-kappa];
    return @[firstQuarterCircleApproximationFuction, secondQuarterCircleApproximationFuction];
}

@end
