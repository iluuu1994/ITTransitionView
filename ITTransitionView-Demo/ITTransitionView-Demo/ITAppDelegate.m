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

@implementation ITAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self transition:nil];
}

- (IBAction)animateToNext:(id)sender {
    ITTransition *transition = [ITFlipTransition new];
    transition.duration = 1.f;
    
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
