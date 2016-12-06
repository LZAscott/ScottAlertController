//
//  ScottShowAlertView.h
//  QQLive
//
//  Created by Scott_Mr on 2016/12/3.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScottShowAlertView : UIView

@property (nonatomic, weak, readonly) UIView *alertView;
@property (nonatomic, strong) UIView *backgroundView;

// 是否可以点击背景消失（默认为NO）
@property (nonatomic, assign) BOOL tapBackgroundDismissEnable;
// Default is 15
@property (nonatomic, assign) CGFloat alertViewMargin;
// Default centerY
@property (nonatomic, assign) CGFloat alertOriginY;

// 初始化
+ (instancetype)alertViewWithView:(UIView *)view;


// 显示方式
+ (void)showAlertViewWithView:(UIView *)alertView;
+ (void)showAlertViewWithView:(UIView *)alertView backgroundDismissEnable:(BOOL)backgroundDismissEnable;
+ (void)showAlertViewWithView:(UIView *)alertView withOriginY:(CGFloat)originY;
+ (void)showAlertViewWithView:(UIView *)alertView withOriginY:(CGFloat)originY backgroundDismissEnable:(BOOL)backgroundDismissEnable;

- (void)show;
- (void)dismiss;


@end
