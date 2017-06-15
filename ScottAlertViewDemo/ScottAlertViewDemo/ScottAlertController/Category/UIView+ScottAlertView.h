//
//  UIView+ScottAlertView.h
//  QQLive
//
//  Created by Scott_Mr on 2016/12/3.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScottAlertViewController.h"

@interface UIView (ScottAlertView)

+ (instancetype)createViewFromNib;
+ (instancetype)createViewFromNibName:(NSString *)nibName;

- (void)dismiss;


#pragma mark - show in controller
- (void)showInController:(UIViewController *)controller backgroundDismissEnable:(BOOL)backgroundDismissEnable;
- (void)showInController:(UIViewController *)controller preferredStyle:(ScottAlertControllerStyle)preferredStyle backgroundDismissEnable:(BOOL)backgroundDismissEnable;
- (void)showInController:(UIViewController *)controller preferredStyle:(ScottAlertControllerStyle)preferredStyle transitionStyle:(ScottAlertTransitionStyle)transitionStyle backgroundDismissEnable:(BOOL)backgroundDismissEnable;


#pragma mark - show in window
- (void)showInWindowWithBackgroundDismissEnable:(BOOL)backgroundDismissEnable;
- (void)showInWindowOriginY:(CGFloat)originY backgroundDismissEnable:(BOOL)backgroundDismissEnable;

@end
