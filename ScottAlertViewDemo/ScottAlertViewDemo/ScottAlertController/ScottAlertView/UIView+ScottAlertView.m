//
//  UIView+ScottAlertView.m
//  QQLive
//
//  Created by Scott_Mr on 2016/12/3.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "UIView+ScottAlertView.h"
#import "ScottAlertViewController.h"
#import "ScottAlertView.h"
#import "ScottShowAlertView.h"

@implementation UIView (ScottAlertView)

+ (instancetype)createViewFromNib {
    return [self createViewFromNibName:NSStringFromClass(self)];
}

+ (instancetype)createViewFromNibName:(NSString *)nibName {
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
    return [nib objectAtIndex:0];
}

- (void)dismiss {
    if ([self isShowInAlertController]) {
        [(ScottAlertViewController *)self.viewController dismissViewControllerAnimated:YES];
    }else if ([self isShowInWindow]){
        [self hiddenInWindow];
    }
}

- (BOOL)isShowInAlertController {
    UIViewController *viewController = [self viewController];
    if (viewController && [viewController isKindOfClass:[ScottAlertViewController class]]) {
        return YES;
    }
    return NO;
}

- (BOOL)isShowInWindow {
    if (self.superview && [self.superview isKindOfClass:[ScottShowAlertView class]]) {
        return YES;
    }
    return NO;
}

- (void)hiddenInWindow {
    if ([self isShowInWindow]) {
        ScottShowAlertView *supView = (ScottShowAlertView *)self.superview;
        [supView dismiss];
    }
}

- (void)showInController:(UIViewController *)controller backgroundDismissEnable:(BOOL)backgroundDismissEnable {
    [self showInController:controller preferredStyle:ScottAlertControllerStyleAlert transitionStyle:ScottAlertTransitionStyleFade backgroundDismissEnable:backgroundDismissEnable];
}

- (void)showInController:(UIViewController *)controller preferredStyle:(ScottAlertControllerStyle)preferredStyle backgroundDismissEnable:(BOOL)backgroundDismissEnable {
    [self showInController:controller preferredStyle:preferredStyle transitionStyle:ScottAlertTransitionStyleFade backgroundDismissEnable:backgroundDismissEnable];

}
- (void)showInController:(UIViewController *)controller preferredStyle:(ScottAlertControllerStyle)preferredStyle transitionStyle:(ScottAlertTransitionStyle)transitionStyle backgroundDismissEnable:(BOOL)backgroundDismissEnable {
    if (self.superview) {
        [self removeFromSuperview];
    }
    
    ScottAlertViewController *alertVC = [ScottAlertViewController alertControllerWithAlertView:self preferredStyle:preferredStyle transitionAnimationStyle:transitionStyle];
    alertVC.tapBackgroundDismissEnable = backgroundDismissEnable;
    [controller presentViewController:alertVC animated:YES completion:nil];
}


#pragma mark - show in window
- (void)showInWindowWithBackgroundDismissEnable:(BOOL)backgroundDismissEnable {
    if (self.superview) {
        [self removeFromSuperview];
    }
    
    [ScottShowAlertView showAlertViewWithView:self backgroundDismissEnable:backgroundDismissEnable];
}

- (void)showInWindowOriginY:(CGFloat)originY backgroundDismissEnable:(BOOL)backgroundDismissEnable {
    if (self.superview) {
        [self removeFromSuperview];
    }
    
    [ScottShowAlertView showAlertViewWithView:self withOriginY:originY backgroundDismissEnable:backgroundDismissEnable];
}

#pragma mark - 通过响应者链找到UIViewController
- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}


@end
