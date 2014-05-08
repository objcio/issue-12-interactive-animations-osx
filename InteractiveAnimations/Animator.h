@protocol Animation <NSObject>
- (void)animationTick:(CFTimeInterval)dt finished:(BOOL *)finished;
@end

@interface Animator : NSObject

+ (instancetype)animatorWithScreen:(NSScreen *)screen;

- (void)addAnimation:(id<Animation>)animatable;
- (void)removeAnimation:(id<Animation>)animatable;

@end

@interface NSView (Animator)

- (Animator*)objc_animator;

@end