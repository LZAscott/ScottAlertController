//
//  ScottShowAlertView.m
//  QQLive
//
//  Created by Scott_Mr on 2016/12/3.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottShowAlertView.h"
#import "UIView+ScottAutoLayout.m"

@interface ScottShowAlertView ()

@property (nonatomic, weak) UIView *alertView;

@property (nonatomic, weak) UITapGestureRecognizer *tapGesture;

@end

@implementation ScottShowAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _tapBackgroundDismissEnable = NO;
        _alertViewMargin = 15;
        [self addBackgroundView];
        [self addTapGesture];
    }
    return self;
}

- (instancetype)initWithAlertView:(UIView *)view {
    if (self = [self initWithFrame:CGRectZero]) {
        [self addSubview:view];
        
        _alertView = view;
    }
    return self;
}

+ (instancetype)alertViewWithView:(UIView *)view {
    return [[self alloc] initWithAlertView:view];
}

// 显示方式
+ (void)showAlertViewWithView:(UIView *)alertView {
    [self showAlertViewWithView:alertView backgroundDismissEnable:NO];
}

+ (void)showAlertViewWithView:(UIView *)alertView backgroundDismissEnable:(BOOL)backgroundDismissEnable {
    ScottShowAlertView *showAlertView = [self alertViewWithView:alertView];
    showAlertView.tapBackgroundDismissEnable = backgroundDismissEnable;
    [showAlertView show];
}

+ (void)showAlertViewWithView:(UIView *)alertView withOriginY:(CGFloat)originY {
    [self showAlertViewWithView:alertView withOriginY:originY backgroundDismissEnable:NO];
}

+ (void)showAlertViewWithView:(UIView *)alertView withOriginY:(CGFloat)originY backgroundDismissEnable:(BOOL)backgroundDismissEnable {
    ScottShowAlertView *showAlertView = [self alertViewWithView:alertView];
    showAlertView.alertOriginY = originY;
    showAlertView.tapBackgroundDismissEnable = backgroundDismissEnable;
    [showAlertView show];
}

- (void)addBackgroundView {
    if (_backgroundView == nil) {
        UIView *backgroundView = [[UIView alloc]initWithFrame:self.bounds];
        backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        _backgroundView = backgroundView;
    }
    [self insertSubview:_backgroundView atIndex:0];
    _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    [self scott_addConstraintToView:_backgroundView edgeInset:UIEdgeInsetsZero];
}

- (void)setBackgroundView:(UIView *)backgroundView {
    if (_backgroundView != backgroundView) {
        [_backgroundView removeFromSuperview];
        _backgroundView = backgroundView;
        [self addBackgroundView];
        [self addTapGesture];
    }
}

- (void)addTapGesture {
    self.userInteractionEnabled = YES;
    //单指单击
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    singleTap.enabled = _tapBackgroundDismissEnable;
    //增加事件者响应者，
    [_backgroundView addGestureRecognizer:singleTap];
    _tapGesture = singleTap;
}

- (void)tapGestureAction:(UITapGestureRecognizer *)tap {
    [self dismiss];
}

- (void)setTapBackgroundDismissEnable:(BOOL)tapBackgroundDismissEnable {
    _tapBackgroundDismissEnable = tapBackgroundDismissEnable;
    _tapGesture.enabled = tapBackgroundDismissEnable;
}

- (void)didMoveToSuperview {
    if (self.superview) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [self.superview scott_addConstraintToView:self edgeInset:UIEdgeInsetsZero];
        [self layoutAlertView];
    }
}

- (void)layoutAlertView {
    _alertView.translatesAutoresizingMaskIntoConstraints = NO;
    // center X
    [self scott_addConstraintCenterXToView:_alertView constant:0];
    
    // width, height
    if (!CGSizeEqualToSize(_alertView.frame.size,CGSizeZero)) {
        [_alertView scott_addConstraintWidth:CGRectGetWidth(_alertView.frame) height:CGRectGetHeight(_alertView.frame)];
    }else {
        BOOL findAlertViewWidthConstraint = NO;
        for (NSLayoutConstraint *constraint in _alertView.constraints) {
            if (constraint.firstAttribute == NSLayoutAttributeWidth) {
                findAlertViewWidthConstraint = YES;
                break;
            }
        }
        
        if (!findAlertViewWidthConstraint) {
            CGFloat width = CGRectGetWidth(self.superview.frame) - (2 * _alertViewMargin);
            [_alertView scott_addConstraintWidth:width height:0];
        }
    }
    
    // topY
    NSLayoutConstraint *alertViewCenterYConstraint = [self scott_addConstraintCenterYToView:_alertView constant:0];
    
    if (_alertOriginY > 0) {
        [_alertView layoutIfNeeded];
        alertViewCenterYConstraint.constant = _alertOriginY - (CGRectGetHeight(self.superview.frame) - CGRectGetHeight(_alertView.frame))/2;
    }
}


- (void)show {
    if (self.superview == nil) {
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    self.alpha = 0;
    _alertView.transform = CGAffineTransformScale(_alertView.transform,0.1,0.1);
    [UIView animateWithDuration:0.3 animations:^{
        _alertView.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    }];
}

- (void)dismiss {
    if (self.superview) {
        [UIView animateWithDuration:0.3 animations:^{
            _alertView.transform = CGAffineTransformScale(_alertView.transform, 0.1, 0.1);
            _alertView.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

@end
