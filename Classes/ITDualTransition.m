//
//  ITDualTransition.m
//  ITTransitionView-Demo
//
//  Created by Ilija Tovilo on 19/01/14.
//  Copyright (c) 2014 Ilija Tovilo. All rights reserved.
//

#import "ITDualTransition.h"

@implementation ITDualTransition

- (void)transitionContainerView:(NSView *)containerView
          oldRepresentationView:(NSView *)oldRepresentationView
          newRepresentationView:(NSView *)newRepresentationView
{
    [oldRepresentationView.layer addAnimation:self.outAnimation forKey:nil];
    [newRepresentationView.layer addAnimation:self.inAnimation forKey:nil];
}

@end
