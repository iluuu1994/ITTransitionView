//
//  ITAppDelegate.m
//  ITTransitionView-Demo
//
//  Created by Ilija Tovilo on 19/01/14.
//  Copyright (c) 2014 Ilija Tovilo. All rights reserved.
//

#import "ITAppDelegate.h"
#import "ITBackFadeTransition.h"
#import "ITCarrouselTransition.h"
#import "ITCrossTransition.h"
#import "ITCubeTransition.h"
#import "ITFadeTransition.h"
#import "ITFlipTransition.h"
#import "ITFoldTransition.h"
#import "ITGhostTransition.h"
#import "ITGlueTransition.h"
#import "ITModernPushTransition.h"
#import "ITPushRotateTransition.h"
#import "ITScaleTransition.h"
#import "ITSlideTransition.h"
#import "ITSwapTransition.h"
#import "ITSwipeFadeTransition.h"
#import "ITSwipeTransition.h"
#import "ITZoomTransition.h"

@implementation ITAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self transition:nil];
}

- (IBAction)animateToNext:(id)sender {
    ITTransition *transition;
    
    switch ([sender tag]) {
        case 0:
            transition = [ITBackFadeTransition new];
            break;
        case 1:
            transition = [ITCarrouselTransition new];
            break;
        case 2:
            transition = [ITCrossTransition new];
            break;
        case 3:
            transition = [ITCubeTransition new];
            break;
        case 4:
            transition = [ITFadeTransition new];
            break;
        case 5:
            transition = [ITFlipTransition new];
            break;
        case 6:
            transition = [ITFoldTransition new];
            break;
        case 7:
            transition = [ITGhostTransition new];
            break;
        case 8:
            transition = [ITGlueTransition new];
            break;
        case 9:
            transition = [ITModernPushTransition new];
            break;
        case 10:
            transition = [ITPushRotateTransition new];
            break;
        case 11:
            transition = [ITScaleTransition new];
            break;
        case 12:
            transition = [ITSlideTransition new];
            break;
        case 13:
            transition = [ITSwapTransition new];
            break;
        case 14:
            transition = [ITSwipeFadeTransition new];
            break;
        case 15:
            transition = [ITSwipeTransition new];
            break;
        case 16:
            transition = [ITZoomTransition new];
            ((ITZoomTransition *)transition).sourceRect = CGRectZero;
            ((ITZoomTransition *)transition).targetRect = self.transitionView.bounds;
            break;
        default:
            break;
    }
    
    transition.duration = 1.f;
    if ([NSApplication sharedApplication].currentEvent.modifierFlags & NSShiftKeyMask) transition.duration *= 5.f;
    
    [self transition:transition];
}

- (void)transition:(ITTransition *)transition {
    NSView *view = self.view1;
    
    if (self.transitionView.contentView == self.view1) view = self.view2;
    else if (self.transitionView.contentView == self.view2) view = self.view3;
    else if (self.transitionView.contentView == self.view3) view = self.view1;
    
    [self.transitionView transitionToView:view
                           withTransition:transition];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return 1000;
}

- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row
{
    NSTableCellView *cell = [tableView makeViewWithIdentifier:@"default" owner:self];
    cell.textField.stringValue = [NSString stringWithFormat:@"Test %ld", row];
    
    return cell;
}

@end
