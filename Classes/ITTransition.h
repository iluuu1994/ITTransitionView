//
//  ITTransition.h
//  ITTransitionView-Demo
//
//  Created by Ilija Tovilo on 19/01/14.
//  Copyright (c) 2014 Ilija Tovilo. All rights reserved.
//

#import <Foundation/Foundation.h>

// Forward declaration
@class ITTransition;
@protocol ITTransitionDelegate;


/**
 *  @enum ITTransitionOrientation - Used to describe the direction of the transition
 */
typedef NS_ENUM(NSUInteger, ITTransitionOrientation) {
    ITTransitionOrientationRightToLeft,
    ITTransitionOrientationLeftToRight,
    ITTransitionOrientationTopToBottom,
    ITTransitionOrientationBottomToTop,
};


/**
 *  @protocol- The transition delegate protocol
 */
@protocol ITTransitionDelegate <NSObject>

/**
 *  This method is called when the transition finishes
 *
 *  @param transition - The transition that has finished
 */
- (void)transitionDidFinish:(ITTransition *)transition;

@end


/**
 *  @class ITTransition
 *
 *  A transition is the animation that occurs when a view is replaced with a different one.
 *  ITTransition is used to describe that animation.
 *  Eventually, ITTransitions can be passed to the ITTransitionView.
 */
@interface ITTransition : NSObject

/**
 *  @property delegate
 *
 *  The delegate of the transition.
 *  Look at the `ITTransitionDelegate` protocol to see what method calls the delegate will receive.
 */
@property (weak) id <ITTransitionDelegate> delegate;

/**
 *  @property orientation - The orientation of the transition
 */
@property (nonatomic, assign) ITTransitionOrientation orientation;

/**
 *  @property transitionViewBounds - The bounds of the transition view
 */
@property (nonatomic, assign) NSRect transitionViewBounds;

/**
 *  @property duration - The duration of the transition
 */
@property (nonatomic) NSTimeInterval duration;

/**
 *  @property timingFunction - The preferred timing function
 */
@property CAMediaTimingFunction *timingFunction;

/**
 *  Starts the transition.
 *  This is abstract and should be overriden in subclasses.
 *
 *  @param contentView           - The layer-backed content view, which contains the two view representations
 *  @param oldRepresentationView - The old representation view
 *  @param newRepresentationView - The new representation view
 */
- (void)transitionContainerView:(NSView *)containerView
          oldRepresentationView:(NSView *)oldRepresentationView
          newRepresentationView:(NSView *)newRepresentationView;

/**
 *  Should always be called before used.
 *  This will create the CAAnimation instances.
 */
- (void)prepareForUsage;

/**
 *  Returns some timing functions used for animating
 *
 *  @return NSArray - An array of timing functions
 */
- (NSArray *)getCircleApproximationTimingFunctions;

@end
