//
//  CBEDraggableView.m
//  InteractiveAnimations
//
//  Created by Chris Eidhof on 03.05.14.
//  Copyright (c) 2014 Chris Eidhof. All rights reserved.
//

#import "CBEDraggableView.h"
#import "UINTGeometryExtras.h"

@interface CBEDraggableView ()

@property (nonatomic) NSPoint startPosition;
@property (nonatomic) CGPoint startOrigin;
@property (nonatomic) CGPoint velocity;
@property (nonatomic) BOOL didDrag;
@end

@implementation CBEDraggableView



- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    [[NSColor grayColor] setFill];
    NSRectFill(dirtyRect);    
}

- (void)mouseDown:(NSEvent *)theEvent
{
    self.startPosition = [theEvent locationInWindow];
    self.startOrigin = self.frame.origin;
    self.didDrag = NO;
}

- (void)mouseUp:(NSEvent *)theEvent
{
    if (self.didDrag) {
        [self.delegate draggingEndedWithVelocity:self.velocity];
    } else {
        [self.delegate draggableViewMouseClicked];
    }
    [super mouseUp:theEvent];
}

- (BOOL)acceptsFirstResponder
{
    return YES;
}

- (void)mouseDragged:(NSEvent *)theEvent
{
    [super mouseDragged:theEvent];
    self.didDrag = YES;
    NSPoint location = [theEvent locationInWindow];
    CGPoint diff = CGPointSubtract(location, self.startPosition);
    diff.x = 0; // only allow didDrag up and down
    CGPoint oldOrigin = self.frame.origin;
    self.frameOrigin = CGPointAdd(self.startOrigin, diff);
    self.velocity = CGPointSubtract(self.frame.origin, oldOrigin);
}

@end
