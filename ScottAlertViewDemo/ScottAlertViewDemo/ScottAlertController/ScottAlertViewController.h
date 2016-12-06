//
//  ScottAlertViewController.h
//  QQLive
//
//  Created by Scott_Mr on 2016/12/1.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScottAlertView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ScottAlertTransitionStyle) {  // 动画类型
    ScottAlertTransitionStyleFade = 0,
    ScottAlertTransitionStyleScaleFade,
    ScottAlertTransitionStyleDropDown,
    scottAlertTransitionStyleCustom
};

typedef NS_ENUM(NSInteger, ScottAlertControllerStyle) {
    ScottAlertControllerStyleActionSheet = 0,
    ScottAlertControllerStyleAlert
};

@interface ScottAlertViewController : UIViewController

@property (nonatomic, strong, readonly) UIView *alertView;
@property (nonatomic, assign, readonly) ScottAlertControllerStyle preferredStyle;
@property (nonatomic, assign, readonly) ScottAlertTransitionStyle transitionStyle;
@property (nonatomic, assign, readonly) Class transitionAnimationClass;

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIColor *backgroundColor;
// 是否可以点击背景消失（默认为NO）
@property (nonatomic, assign) BOOL tapBackgroundDismissEnable;
// Default is 15
@property (nonatomic, assign) CGFloat alertStyleMargin;
// Default is 0
@property (nonatomic, assign) CGFloat actionSheetStyleMargin;
// Default centerY
@property (nonatomic, assign) CGFloat alertOriginY;


@property (nonatomic, copy) void(^dismissCompleteBlock)();

+ (instancetype)alertControllerWithAlertView:(UIView *)alertView;
+ (instancetype)alertControllerWithAlertView:(UIView *)alertView preferredStyle:(ScottAlertControllerStyle)preferredStyle;
+ (instancetype)alertControllerWithAlertView:(UIView *)alertView preferredStyle:(ScottAlertControllerStyle)preferredStyle transitionAnimationStyle:(ScottAlertTransitionStyle)transitionStyle;
+ (instancetype)alertControllerWithAlertView:(UIView *)alertView preferredStyle:(ScottAlertControllerStyle)preferredStyle transitionAnimationClass:(Class)transitionAnimationClass;

- (void)dismissViewControllerAnimated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
