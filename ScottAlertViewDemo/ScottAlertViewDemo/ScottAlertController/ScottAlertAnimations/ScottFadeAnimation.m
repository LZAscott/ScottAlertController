//
//  ScottFadeAnimation.m
//  QQLive
//
//  Created by Scott_Mr on 2016/12/1.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottFadeAnimation.h"

@implementation ScottFadeAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.isPresenting ? 0.45 : 0.25;
}

- (void)presentAnimationTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    ScottAlertViewController *alertController = (ScottAlertViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    alertController.backgroundView.alpha = 0.0;
    
    switch (alertController.preferredStyle) {
        case ScottAlertControllerStyleAlert:{
            alertController.alertView.alpha = 0.0;
            alertController.alertView.transform = CGAffineTransformMakeScale(0.5, 0.5);
        }
            break;
        case ScottAlertControllerStyleActionSheet:{
            alertController.alertView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(alertController.alertView.frame));
        }
            break;
        default:
            break;
    }
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:alertController.view];
    
    [UIView animateWithDuration:0.25 animations:^{
        alertController.backgroundView.alpha = 1.0;
        switch (alertController.preferredStyle) {
            case ScottAlertControllerStyleAlert:{
                alertController.alertView.alpha = 1.0;
                alertController.alertView.transform = CGAffineTransformMakeScale(1.05, 1.05);
            }
                break;
            case ScottAlertControllerStyleActionSheet:{
                alertController.alertView.transform = CGAffineTransformMakeTranslation(0, -10.0);
            }
                break;
            default:
                break;
        }
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            alertController.alertView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }];
}

- (void)dismissAnimationTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    ScottAlertViewController *alertController = (ScottAlertViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [UIView animateWithDuration:0.25 animations:^{
        alertController.backgroundView.alpha = 0.0;
        switch (alertController.preferredStyle) {
            case ScottAlertControllerStyleAlert:{
                alertController.alertView.alpha = 0.0;
                alertController.alertView.transform = CGAffineTransformMakeScale(0.9, 0.9);
            }
                break;
            case ScottAlertControllerStyleActionSheet:{
                alertController.alertView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(alertController.alertView.frame));
            }
                break;
            default:
                break;
        }
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
