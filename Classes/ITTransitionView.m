//
//  ITTransitionView.m
//  ITTransitionView-Demo
//
//  Created by Ilija Tovilo on 19/01/14.
//  Copyright (c) 2014 Ilija Tovilo. All rights reserved.
//

#import "ITTransitionView.h"


#pragma mark - Private
@interface ITTransitionView () {
    BOOL _lock;
    NSView *_layerBackedContainer;
    NSView *_oldRepresentationView;
    NSView *_newRepresentationView;
}
@end



#pragma mark - Implementation
@implementation ITTransitionView

#pragma mark - Init
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self _commonInit];
    }
    
    return self;
}

- (id)initWithFrame:(NSRect)frameRect
{
    if (self = [super initWithFrame:frameRect]) {
        [self _commonInit];
    }
    
    return self;
}

- (void)_commonInit {
    // Init the layers
    _layerBackedContainer = [[NSView alloc] initWithFrame:self.bounds];
    _oldRepresentationView = [[NSView alloc] initWithFrame:self.bounds];
    _newRepresentationView = [[NSView alloc] initWithFrame:self.bounds];
    
    // Set the autoresizing masks
    _layerBackedContainer.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    _oldRepresentationView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    _newRepresentationView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    
    // Make layer backed
    _layerBackedContainer.wantsLayer = YES;
    
    // Make view hierarchy
    [_layerBackedContainer addSubview:_oldRepresentationView];
    [_layerBackedContainer addSubview:_newRepresentationView];
    [self addSubview:_layerBackedContainer];
    
    // 3d setup
    _oldRepresentationView.layer.doubleSided = NO;
    _newRepresentationView.layer.doubleSided = NO;
    
    float zDistance = 1000.f;
    CATransform3D sublayerTransform = CATransform3DIdentity;
    sublayerTransform.m34 = 1.0 / -zDistance;
    _layerBackedContainer.layer.sublayerTransform = sublayerTransform;

    // Setting anchor point
    CGRect oldFrame;
    
    oldFrame = _oldRepresentationView.layer.frame;
    _oldRepresentationView.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
    _oldRepresentationView.layer.frame = oldFrame;
    
    oldFrame = _newRepresentationView.layer.frame;
    _newRepresentationView.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
    _newRepresentationView.layer.frame = oldFrame;
    
    
    // Finally, we hide the container
    [_layerBackedContainer setHidden:YES];
}



#pragma mark - Transition
- (void)transitionToView:(NSView *)view
          withTransition:(ITTransition *)transition
{
    [self _transitionfromView:_contentView
                       toView:view
               withTransition:transition];
}

- (void)_transitionfromView:(NSView *)viewOut
                     toView:(NSView *)viewIn
             withTransition:(ITTransition *)transition
{
    if (_lock) return;
    
    if (transition && viewOut && viewOut != viewIn)
    {
        // Lock
        _lock = YES;
        
        // Prepare transition/views/layers
        transition.sourceRect = self.frame;
        viewIn.frame = self.bounds;
        [viewIn layoutSubtreeIfNeeded];
        [viewIn displayIfNeeded];
        
        _oldRepresentationView.layer.contents = [self _cacheContentsOfView:viewOut];
        _newRepresentationView.layer.contents = [self _cacheContentsOfView:viewIn];
        [self _prepareForTransition];
        [viewOut removeFromSuperview];

        
        // Start the animation
        [CATransaction begin];
        {
            // Hide the container
            CATransaction.completionBlock = ^{
                [self _addAutoresizingSubview:viewIn];
                [self display];
                
                [self _cleanupAfterTransition];
                _lock = NO;
            };
            
            [transition prepareForUsage];
            
            [transition transitionContainerView:_layerBackedContainer
                          oldRepresentationView:_oldRepresentationView
                          newRepresentationView:_newRepresentationView];
        }
        [CATransaction commit];
    }
    
    // Called when there is no other content view,
    // or `nil` passed for the transition.
    else
    {
        [self _addAutoresizingSubview:viewIn];
        [viewOut removeFromSuperview];
    }
    
    _contentView = viewIn;
}


#pragma mark - Helpers
- (void)_prepareForTransition {
    [_layerBackedContainer setHidden:NO];
}

- (void)_cleanupAfterTransition {
    [_layerBackedContainer setHidden:YES];
    _oldRepresentationView.layer.contents = nil;
    _newRepresentationView.layer.contents = nil;
}

- (NSImage *)_cacheContentsOfView:(NSView *)view {
    [view layoutSubtreeIfNeeded];
    [view setNeedsUpdateConstraints:YES];
    [view updateConstraintsForSubtreeIfNeeded];
    
    NSBitmapImageRep* rep = [view bitmapImageRepForCachingDisplayInRect:view.bounds];
    [view cacheDisplayInRect:view.bounds toBitmapImageRep:rep];
    
    return [[NSImage alloc] initWithCGImage:[rep CGImage] size:view.bounds.size];
}

- (void)_addAutoresizingSubview:(NSView *)aView {
    aView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    aView.frame = self.bounds;
    
    [self addSubview:aView];
}

@end
