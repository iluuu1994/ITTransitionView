//
//  ITTransformTransition.h
//  ITTransitionView-Demo
//
//  Created by Ilija Tovilo on 19/01/14.
//  Copyright (c) 2014 Ilija Tovilo. All rights reserved.
//

#import "ITTransition.h"

@interface ITTransformTransition : ITTransition

@property (strong) CAAnimation *animation;
@property CATransform3D inTransform;
@property CATransform3D outTransform;

@end
