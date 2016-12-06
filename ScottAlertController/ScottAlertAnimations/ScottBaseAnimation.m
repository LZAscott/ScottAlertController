//
//  ScottBaseAnimation.m
//  QQLive
//
//  Created by Scott_Mr on 2016/12/1.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottBaseAnimation.h"

@interface ScottBaseAnimation ()

@property (nonatomic, assign) BOOL isPresenting;

@end


@implementation ScottBaseAnimation

- (instancetype)initWithPresenting:(BOOL)isPresenting {
    if (self = [super init]) {
        self.isPresenting = isPresenting;
    }
    return self;
}

+ (instancetype)animationIsPresenting:(BOOL)isPresenting {
    return [[self alloc] initWithPresenting:isPresenting];
}

+ (instancetype)animationIsPresenting:(BOOL)isPresenting preferredStyle:(ScottAlertControllerStyle)preferredStyle {
    return [[self alloc] initWithPresenting:isPresenting];
}

- (void)presentAnimationTransition:(id<UIViewControllerContextTransitioning>)transitionContext {

}

- (void)dismissAnimationTransition:(id<UIViewControllerContextTransitioning>)transitionContext {

}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.4f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    if (_isPresenting) {
        [self presentAnimationTransition:transitionContext];
    }else{
        [self dismissAnimationTransition:transitionContext];
    }
}
@end
