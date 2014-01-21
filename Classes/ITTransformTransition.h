//
//  ITTransformTransition.h
//  ITTransitionView-Demo
//
//  Created by Ilija Tovilo on 19/01/14.
//  Copyright (c) 2014 Ilija Tovilo. All rights reserved.
//

#import "ITTransition.h"

/**
 *  @class ITTransformTransition
 *
 *  Used to transition from one NSView to another using CATransform3D
 */
@interface ITTransformTransition : ITTransition

/**
 *  @property animaiton - The animation applied to the container that holds both views
 */
@property (strong) CAAnimation *animation;


/**
 *  @property inTransform - The transform applied to the view that is transitioned in
 */
@property CATransform3D inTransform;


/**
 *  @property outTransform - The transform applied to the view that is transitioned out
 */
@property CATransform3D outTransform;

@end
