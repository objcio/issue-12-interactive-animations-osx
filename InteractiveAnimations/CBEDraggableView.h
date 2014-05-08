//
//  CBEDraggableView.h
//  InteractiveAnimations
//
//  Created by Chris Eidhof on 03.05.14.
//  Copyright (c) 2014 Chris Eidhof. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol CBEDraggableViewDelegate <NSObject>

- (void)draggingEndedWithVelocity:(CGPoint)velocity;
- (void)draggableViewMouseClicked;

@end

@interface CBEDraggableView : NSView

@property (nonatomic,weak) id<CBEDraggableViewDelegate> delegate;

@end
