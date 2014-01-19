//
//  ITTransformTransition.m
//  ITTransitionView-Demo
//
//  Created by Ilija Tovilo on 19/01/14.
//  Copyright (c) 2014 Ilija Tovilo. All rights reserved.
//

#import "ITTransformTransition.h"

@implementation ITTransformTransition

- (void)transitionContainerView:(NSView *)containerView
          oldRepresentationView:(NSView *)oldRepresentationView
          newRepresentationView:(NSView *)newRepresentationView
{
    oldRepresentationView.layer.transform = self.outTransform;
    newRepresentationView.layer.transform = self.inTransform;
    
    // We now balance viewIn.layer.transform by taking its invert and putting it in the superlayer of viewIn.layer
    // so that viewIn.layer appears ok in the final state.
    // (When pushing, viewIn.layer.transform == CATransform3DIdentity)
    containerView.layer.transform = CATransform3DInvert(newRepresentationView.layer.transform);
    [containerView.layer addAnimation:self.animation forKey:nil];
}

@end
