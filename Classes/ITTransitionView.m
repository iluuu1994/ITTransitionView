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
    CALayer *_rootLayer;
    NSView *_layerBackedContainer;
    NSView *_containerView;
    NSView *_oldRepresentationView;
    NSView *_newRepresentationView;
}
@end


@implementation CATransformLayer (MyExtension)
// Avoid warning at start "changing property ... in transform-only layer, will have no effect"
-(void)setOpaque:(BOOL)opaque { return; }
- (void)setEdgeAntialiasingMask:(unsigned int)edgeAntialiasingMask { return; }
- (void)setShadowColor:(CGColorRef)shadowColor { return; }
- (void)setMasksToBounds:(BOOL)masksToBounds { return; }
- (void)setFilters:(NSArray *)filters { return; }
- (void)setBackgroundFilters:(NSArray *)backgroundFilters { return; }
@end

@interface IT3DView : NSView
@end

@implementation IT3DView
- (CALayer *)makeBackingLayer {
    return [CATransformLayer layer];
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
    _cachesContents = YES;
    
    // Init the layers
    _layerBackedContainer = [[NSView alloc] initWithFrame:self.bounds];
    _containerView = [[IT3DView alloc] initWithFrame:self.bounds];
    _oldRepresentationView = [[NSView alloc] initWithFrame:self.bounds];
    _newRepresentationView = [[NSView alloc] initWithFrame:self.bounds];
    
    // Set the autoresizing masks
    _layerBackedContainer.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    _containerView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    _oldRepresentationView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    _newRepresentationView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    
    // Make layer backed
    _rootLayer = [CALayer layer];
    _layerBackedContainer.layer = _rootLayer;
    _layerBackedContainer.wantsLayer = YES;
    _layerBackedContainer.autoresizesSubviews = YES;
    
    // Make view hierarchy
    [_layerBackedContainer addSubview:_containerView];
    [_containerView addSubview:_oldRepresentationView];
    [_containerView addSubview:_newRepresentationView];
    [self addSubview:_layerBackedContainer];
    
    // No Clipping (for shadows)
    _rootLayer.masksToBounds = NO;
    _layerBackedContainer.layer.masksToBounds = NO;
    _oldRepresentationView.layer.masksToBounds = NO;
    _newRepresentationView.layer.masksToBounds = NO;
    
    _oldRepresentationView.layer.doubleSided = NO;
    _newRepresentationView.layer.doubleSided = NO;
    
    // 3d setup
    float zDistance = 1000.f;
    CATransform3D sublayerTransform = CATransform3DIdentity;
    sublayerTransform.m34 = 1.0 / -zDistance;
    _rootLayer.sublayerTransform = sublayerTransform;

    [self _reloadAnchorPoints];

    // Finally, we hide the container
    [_layerBackedContainer setHidden:YES];
}

- (void)awakeFromNib {
    self.layer.masksToBounds = NO; // Disable mask if the view is layer-backed
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
    if (_lock || viewOut == viewIn) return;
    
    _contentView = viewIn;
    
    if (transition && viewOut)
    {
        // Lock
        _lock = YES;
        
        // Prepare transition/views/layers
        transition.transitionViewBounds = self.bounds;
        viewIn.frame = self.bounds;
        
        [viewOut removeFromSuperview];
        
        [self _prepareForTransition];
        
        if (self.cachesContents) {
            _oldRepresentationView.layer.contents = [self _cacheContentsOfView:viewOut];
            _newRepresentationView.layer.contents = [self _cacheContentsOfView:viewIn];
        } else {
            [_newRepresentationView addSubview:viewIn];
            [_oldRepresentationView addSubview:viewOut];
        }
        
        // Start the animation
        [CATransaction begin];
        {
            // Hide the container
            CATransaction.completionBlock = ^{
                if (viewIn == _contentView) {
                    NSDisableScreenUpdates();
                    {
                        if (!self.cachesContents) {
                            [viewIn removeFromSuperview];
                            [viewOut removeFromSuperview];
                        }
                        
                        [self _addAutoresizingSubview:viewIn];
                        [self _cleanupAfterTransition];
                        
                        [self display];
                    }
                    NSEnableScreenUpdates();
                        
                    _lock = NO;
                }
            };
            
            [transition prepareForUsage];
            
            [transition transitionContainerView:_containerView
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
}


#pragma mark - Helpers
- (void)_reloadAnchorPoints {
    // Setting anchor point
    CGRect frame = (CGRect){
        .origin.x = self.bounds.size.width * self.layer.anchorPoint.x,
        .origin.y = self.bounds.size.height * self.layer.anchorPoint.y,
        .size = self.bounds.size
    };
    
    _rootLayer.anchorPoint = CGPointMake(0.5f, 0.5f);
    _rootLayer.frame = frame;
    
    _containerView.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
    _containerView.layer.frame = frame;
    
    _oldRepresentationView.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
    _oldRepresentationView.layer.frame = frame;
    
    _newRepresentationView.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
    _newRepresentationView.layer.frame = frame;
}

- (void)_prepareForTransition {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    {
        [_layerBackedContainer setHidden:NO];
        
        [self _reloadAnchorPoints];
        
        _containerView.layer.transform = CATransform3DIdentity;
        _newRepresentationView.layer.transform = CATransform3DIdentity;
        _oldRepresentationView.layer.transform = CATransform3DIdentity;
    }
    [CATransaction commit];
}

- (void)_cleanupAfterTransition {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    {
        [_layerBackedContainer setHidden:YES];
        _oldRepresentationView.layer.contents = nil;
        _newRepresentationView.layer.contents = nil;
        
        _containerView.layer.sublayerTransform = CATransform3DIdentity;
    }
    [CATransaction commit];
}

- (NSImage *)_cacheContentsOfView:(NSView *)view {
    [view layoutSubtreeIfNeeded];
    [view updateConstraints];
    [view updateConstraintsForSubtreeIfNeeded];
    [view displayIfNeeded];
    
    NSBitmapImageRep* rep = [view bitmapImageRepForCachingDisplayInRect:view.bounds];
    [view cacheDisplayInRect:view.bounds toBitmapImageRep:rep];
    
    return [[NSImage alloc] initWithCGImage:[rep CGImage] size:view.bounds.size];
}

- (void)_addAutoresizingSubview:(NSView *)aView {
    aView.frame = self.bounds;
    aView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    
    [self addSubview:aView];
}

@end
