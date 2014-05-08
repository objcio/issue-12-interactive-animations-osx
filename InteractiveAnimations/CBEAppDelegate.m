//
//  CBEAppDelegate.m
//  InteractiveAnimations
//
//  Created by Chris Eidhof on 03.05.14.
//  Copyright (c) 2014 Chris Eidhof. All rights reserved.
//

#import "CBEAppDelegate.h"
#import "CBEWindowController.h"

@interface CBEAppDelegate ()

@property (nonatomic, strong) CBEWindowController *rootWindowController;
@end

@implementation CBEAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.rootWindowController = [[CBEWindowController alloc] initWithWindowNibName:@"CBEWindowController"];
    [self.rootWindowController.window makeKeyAndOrderFront:nil];
}

@end
