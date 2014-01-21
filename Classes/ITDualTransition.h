//
//  ITDualTransition.h
//  ITTransitionView-Demo
//
//  Created by Ilija Tovilo on 19/01/14.
//  Copyright (c) 2014 Ilija Tovilo. All rights reserved.
//

#import "ITTransition.h"

/**
 *  @class ITDualTransition
 *
 *  ITDualTransition is used to transition from one NSView to another using two separate CAAnimation instances
 */
@interface ITDualTransition : ITTransition

/**
 *  @property inAnimation - The animation applied to the view that is transitioned in
 */
@property (strong) CAAnimation *inAnimation;

/**
 *  @property outAnimation - The animation applied to the view that is transitioned out
 */
@property (strong) CAAnimation *outAnimation;

@end
