//
//  ScottDropDownAnimation.m
//  QQLive
//
//  Created by Scott_Mr on 2016/12/1.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottDropDownAnimation.h"

@implementation ScottDropDownAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.isPresenting ? 0.5 : 0.25;
}

- (void)presentAnimationTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    ScottAlertViewController *alertController = (ScottAlertViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    alertController.backgroundView.alpha = 0.0;
    
    switch (alertController.preferredStyle) {
        case ScottAlertControllerStyleAlert:{
            alertController.alertView.transform = CGAffineTransformMakeTranslation(0, -CGRectGetMaxY(alertController.alertView.frame));
        }
            break;
        case ScottAlertControllerStyleActionSheet:{
            
        }
            break;
        default:
            break;
    }
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:alertController.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.65 initialSpringVelocity:0.5 options:0 animations:^{
        alertController.backgroundView.alpha = 1.0;
        alertController.alertView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}


- (void)dismissAnimationTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    ScottAlertViewController *alertController = (ScottAlertViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        alertController.backgroundView.alpha = 0.0;
        switch (alertController.preferredStyle) {
            case ScottAlertControllerStyleAlert:{
                alertController.alertView.alpha = 0.0;
                alertController.alertView.transform = CGAffineTransformMakeScale(0.9, 0.9);
            }
                break;
            case ScottAlertControllerStyleActionSheet: {
                
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
