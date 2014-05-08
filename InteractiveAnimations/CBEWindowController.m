//
//  CBEWindowController.m
//  InteractiveAnimations
//
//  Created by Chris Eidhof on 03.05.14.
//  Copyright (c) 2014 Chris Eidhof. All rights reserved.
//

#import "CBEWindowController.h"
#import "Animator.h"
#import "UINTSpringAnimation.h"
#import "CBEDraggableView.h"

typedef NS_ENUM(NSInteger, PaneState) {
    PaneStateOpen,
    PaneStateClosed,
};

@interface CBEWindowController () <CBEDraggableViewDelegate>

@property (strong) IBOutlet CBEDraggableView *pane;
@property (nonatomic) PaneState paneState;
@property (nonatomic) UINTSpringAnimation *springAnimation;

@end

@implementation CBEWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];

    self.paneState = PaneStateClosed;
    self.pane.delegate = self;
}

- (CGPoint)targetOrigin
{
    return self.paneState == PaneStateClosed > 0 ? CGPointMake(0,-215) : CGPointMake(0, -50);
}

- (void)animateWithVelocity:(CGPoint)velocity
{    
    Animator *animator = self.pane.objc_animator;
    [animator removeAnimation:self.springAnimation];
    self.springAnimation = [UINTSpringAnimation animationWithView:self.pane target:self.targetOrigin velocity:velocity];
    [animator addAnimation:self.springAnimation];
}

- (void)draggingEndedWithVelocity:(CGPoint)velocity
{
    PaneState targetState = velocity.y < 0 ? PaneStateClosed : PaneStateOpen;
    self.paneState = targetState;
    [self animateWithVelocity:velocity];
}

- (void)draggableViewMouseClicked
{
    PaneState targetState = self.paneState == PaneStateOpen ? PaneStateClosed : PaneStateOpen;
    self.paneState = targetState;
    [self animateWithVelocity:self.springAnimation.velocity];

}


@end
