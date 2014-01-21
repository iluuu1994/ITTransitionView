//
//  ITZoomTransition.h
//  ITTransitionView-Demo
//
//  Created by Ilija Tovilo on 21/01/14.
//  Copyright (c) 2014 Ilija Tovilo. All rights reserved.
//

#import "ITDualTransition.h"

@interface ITZoomTransition : ITDualTransition
@property (assign) CGRect sourceRect;
@property (assign) CGRect targetRect;
@end
