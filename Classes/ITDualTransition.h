//
//  ITDualTransition.h
//  ITTransitionView-Demo
//
//  Created by Ilija Tovilo on 19/01/14.
//  Copyright (c) 2014 Ilija Tovilo. All rights reserved.
//

#import "ITTransition.h"

@interface ITDualTransition : ITTransition

@property (strong) CAAnimation *outAnimation;
@property (strong) CAAnimation *inAnimation;

@end
