//
//  ScottBaseAnimation.h
//  QQLive
//
//  Created by Scott_Mr on 2016/12/1.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScottAlertViewController.h"

NS_ASSUME_NONNULL_BEGIN
@interface ScottBaseAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign, readonly) BOOL isPresenting;

+ (instancetype)animationIsPresenting:(BOOL)isPresenting;

+ (instancetype)animationIsPresenting:(BOOL)isPresenting preferredStyle:(ScottAlertControllerStyle)preferredStyle;

- (void)presentAnimationTransition:(id<UIViewControllerContextTransitioning>)transitionContext;

- (void)dismissAnimationTransition:(id<UIViewControllerContextTransitioning>)transitionContext;

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext;

@end

NS_ASSUME_NONNULL_END
