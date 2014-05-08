//
// Created by chris on 02.05.14.
//

#import "UINTSpringAnimation.h"
#import "UINTGeometryExtras.h"

@interface UINTSpringAnimation ()

@property (nonatomic) CGPoint targetPoint;
@property (nonatomic) NSView *view;

@property (nonatomic, readwrite) CGPoint velocity;
@end

@implementation UINTSpringAnimation

- (instancetype)initWithView:(NSView *)view target:(CGPoint)target velocity:(CGPoint)velocity
{
    self = [super init];
    if (self) {
        self.view = view;
        self.targetPoint = target;
        self.velocity = velocity;
    }
    return self;
}

+ (instancetype)animationWithView:(NSView *)view target:(CGPoint)target velocity:(CGPoint)velocity
{
    return [[self alloc] initWithView:view target:target velocity:velocity];
}

- (void)animationTick:(CFTimeInterval)dt finished:(BOOL *)finished
{
    static const float frictionConstant = 20;
    static const float springConstant = 300;
    CGFloat time = 1.0/60.0; // TODO use dt

    // friction force = velocity * friction constant
    CGPoint frictionForce = CGPointMultiply(self.velocity, frictionConstant);
    // spring force = (target point - current position) * spring constant
    CGPoint springForce = CGPointMultiply(CGPointSubtract(self.targetPoint, self.view.frame.origin), springConstant);
    // force = spring force - friction force
    CGPoint force = CGPointSubtract(springForce, frictionForce);
    // velocity = current velocity + force * time / mass
    self.velocity = CGPointAdd(self.velocity, CGPointMultiply(force, time));
    // position = current position + velocity * time
    CGPoint origin = CGPointAdd(self.view.frame.origin, CGPointMultiply(self.velocity, time));
    [self.view setFrameOrigin:origin];

    CGFloat speed = CGPointLength(self.velocity);
    CGFloat distanceToGoal = CGPointLength(CGPointSubtract(self.targetPoint, self.view.frame.origin));
    if (speed < 0.05 && distanceToGoal < 1) {
        [self.view setFrameOrigin:self.targetPoint];
        *finished = YES;
    }
}

@end