//
//  ITCrossTransition.m
//  ITTransitionView-Demo
//
//  Created by Ilija Tovilo on 21/01/14.
//  Copyright (c) 2014 Ilija Tovilo. All rights reserved.
//

#import "ITCrossTransition.h"
#import <QuartzCore/QuartzCore.h>

@implementation ITCrossTransition

- (void)prepareForUsage {
    CAAnimation * animation = nil;
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    ((CABasicAnimation *)animation).fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI * 0.5f, 0.0f, 1.0f, 0.0f)];
    ((CABasicAnimation *)animation).toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    self.outTransform = CATransform3DRotate(self.outTransform, -M_PI * 0.5f, 0.0f, 1.0f, 0.0f);
    
    self.animation = animation;
    self.duration = self.duration;
    self.animation.delegate = self;
}

@end
