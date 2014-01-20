//
//  ITAppDelegate.m
//  ITTransitionView-Demo
//
//  Created by Ilija Tovilo on 19/01/14.
//  Copyright (c) 2014 Ilija Tovilo. All rights reserved.
//

#import "ITAppDelegate.h"
#import "ITSwapTransition.h"
#import "ITFlipTransition.h"
#import "ITFadeTransition.h"
#import "ITCarrouselTransition.h"
#import "ITCubeTransition.h"
#import "ITGhostTransition.h"
#import "ITSlideTransition.h"

@implementation ITAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self transition:nil];
}

- (IBAction)animateToNext:(id)sender {
    ITTransition *transition;
    
    switch ([sender tag]) {
        case 0:
            transition = [ITSwapTransition new];
            break;
        case 1:
            transition = [ITFlipTransition new];
            break;
        case 2:
            transition = [ITFadeTransition new];
            break;
        case 3:
            transition = [ITCarrouselTransition new];
            break;
        case 4:
            transition = [ITCubeTransition new];
            break;
        case 5:
            transition = [ITGhostTransition new];
            break;
        case 6:
            transition = [ITSlideTransition new];
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
