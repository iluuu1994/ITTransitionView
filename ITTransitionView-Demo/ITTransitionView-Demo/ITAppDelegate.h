//
//  ITAppDelegate.h
//  ITTransitionView-Demo
//
//  Created by Ilija Tovilo on 19/01/14.
//  Copyright (c) 2014 Ilija Tovilo. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ITTransitionView.h"

@interface ITAppDelegate : NSObject <NSApplicationDelegate, NSTableViewDataSource, NSTableViewDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet ITTransitionView *transitionView;

@property (assign) IBOutlet NSView *view1;
@property (assign) IBOutlet NSView *view2;
@property (assign) IBOutlet NSView *view3;

@end
