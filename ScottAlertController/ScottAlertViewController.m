//
//  ScottAlertViewController.m
//  QQLive
//
//  Created by Scott_Mr on 2016/12/1.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottAlertViewController.h"
#import "ScottFadeAnimation.h"
#import "ScottScaleFadeAnimation.h"
#import "ScottDropDownAnimation.h"
#import "UIView+ScottAutoLayout.h"

@interface ScottAlertViewController ()<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, assign) ScottAlertControllerStyle preferredStyle;
@property (nonatomic, assign) ScottAlertTransitionStyle transitionStyle;
@property (nonatomic, assign) Class transitionAnimationClass;

@property (nonatomic, weak) UITapGestureRecognizer *tapGesture;

// alertView中点y坐标
@property (nonatomic, strong) NSLayoutConstraint *alertCenterYConstraint;
@property (nonatomic, assign) CGFloat alertViewCenterYOffset;

@end

@implementation ScottAlertViewController

#pragma mark - 初始化
- (instancetype)init {
    self = [super init];
    if (self) {
        [self configureController];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self configureController];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self configureController];
    }
    return self;
}

- (instancetype)initWithAlertView:(UIView *)alertView preferredStyle:(ScottAlertControllerStyle)preferredStyle transitionAnimationStyle:(ScottAlertTransitionStyle)transitionStyle transitionAnimationClass:(Class)transitionAnimationClass {
    if (self = [self initWithNibName:nil bundle:nil]) {
        _alertView = alertView;
        _preferredStyle = preferredStyle;
        _transitionStyle = transitionStyle;
        _transitionAnimationClass = transitionAnimationClass;
    }
    return self;
}

+ (instancetype)alertControllerWithAlertView:(UIView *)alertView {
    return [[self alloc] initWithAlertView:alertView preferredStyle:ScottAlertControllerStyleAlert transitionAnimationStyle:ScottAlertTransitionStyleFade transitionAnimationClass:nil];
}

+ (instancetype)alertControllerWithAlertView:(UIView *)alertView preferredStyle:(ScottAlertControllerStyle)preferredStyle {
    return [[self alloc] initWithAlertView:alertView preferredStyle:preferredStyle transitionAnimationStyle:ScottAlertTransitionStyleFade transitionAnimationClass:nil];
}

+ (instancetype)alertControllerWithAlertView:(UIView *)alertView preferredStyle:(ScottAlertControllerStyle)preferredStyle transitionAnimationStyle:(ScottAlertTransitionStyle)transitionStyle {
    return [[self alloc] initWithAlertView:alertView preferredStyle:preferredStyle transitionAnimationStyle:transitionStyle transitionAnimationClass:nil];
}

+ (instancetype)alertControllerWithAlertView:(UIView *)alertView preferredStyle:(ScottAlertControllerStyle)preferredStyle transitionAnimationClass:(Class)transitionAnimationClass {
    return [[self alloc] initWithAlertView:alertView preferredStyle:preferredStyle transitionAnimationStyle:scottAlertTransitionStyleCustom transitionAnimationClass:transitionAnimationClass];
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor = [UIColor clearColor];
    [self addBackgroundView];
    [self addSigleTapGuesture];
    [self configureAlertView];
    
    [self.view layoutIfNeeded];
    
    if (_preferredStyle == ScottAlertControllerStyleAlert) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
}

- (void)addBackgroundView {
    if (_backgroundView == nil) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = _backgroundColor;
    }
    
    _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view insertSubview:_backgroundView atIndex:0];
    [self.view scott_addConstraintToView:_backgroundView edgeInset:UIEdgeInsetsZero];
}

- (void)setBackgroundView:(UIView *)backgroundView {
    if (backgroundView != nil) {
        _backgroundView = backgroundView;
    }else if(backgroundView != _backgroundView){
        backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view insertSubview:backgroundView aboveSubview:_backgroundView];
        [self.view scott_addConstraintToView:backgroundView edgeInset:UIEdgeInsetsZero];
        backgroundView.alpha = 0.0;
        [UIView animateWithDuration:0.3 animations:^{
            backgroundView.alpha = 1.0;
        } completion:^(BOOL finished) {
            [_backgroundView removeFromSuperview];
            _backgroundView = backgroundView;
            [self addSigleTapGuesture];
        }];
    }
}

- (void)addSigleTapGuesture {
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sigleTap:)];
    tapGesture.enabled = _tapBackgroundDismissEnable;
    [_backgroundView addGestureRecognizer:tapGesture];
    _tapGesture = tapGesture;
}

- (void)sigleTap:(UITapGestureRecognizer *)tap {
    [self dismissViewControllerAnimated:YES];
}

- (void)setTapBackgroundDismissEnable:(BOOL)tapBackgroundDismissEnable {
    _tapBackgroundDismissEnable = tapBackgroundDismissEnable;
    _tapGesture.enabled = tapBackgroundDismissEnable;
}

- (void)configureAlertView {
    if (_alertView == nil) return;
    
    _alertView.userInteractionEnabled = YES;
    [self.view addSubview:_alertView];
    
    _alertView.translatesAutoresizingMaskIntoConstraints = NO;
    switch (_preferredStyle) {
        case ScottAlertControllerStyleAlert:{
            [self layoutAlertStyleView];
        }
            break;
        case ScottAlertControllerStyleActionSheet:{
            [self layoutActionSheetStyleView];
        }
            break;
        default:
            break;
    }
}

- (void)configureAlertViewWidth {
    if (!CGSizeEqualToSize(_alertView.frame.size, CGSizeZero)) {
        [_alertView scott_addConstraintWidth:CGRectGetWidth(_alertView.frame) height:CGRectGetHeight(_alertView.frame)];
    }else{
        BOOL findAlertViewWidConstraint = NO;
        for (NSLayoutConstraint *constraint in _alertView.constraints) {
            if (constraint.firstAttribute == NSLayoutAttributeWidth) {
                findAlertViewWidConstraint = YES;
                break;
            }
        }
        if (!findAlertViewWidConstraint) {
            CGFloat width = CGRectGetWidth(self.view.frame) - 2 * _alertStyleMargin;
            [_alertView scott_addConstraintWidth:width height:0];
        }
    }
}

#pragma mark - 布局
- (void)layoutAlertStyleView {
    // centerX
    [self.view scott_addConstraintCenterXToView:_alertView constant:0];
    
    // width
    [self configureAlertViewWidth];
    
    // centerY
    _alertCenterYConstraint = [self.view scott_addConstraintCenterYToView:_alertView constant:0];
    if (_alertOriginY > 0) {
        [_alertView layoutIfNeeded];
        _alertViewCenterYOffset = _alertOriginY - (CGRectGetHeight(self.view.frame) - CGRectGetHeight(self.alertView.frame))/2.0;
        _alertCenterYConstraint.constant = _alertViewCenterYOffset;
    }else{
        _alertViewCenterYOffset = 0;
    }
}

- (void)layoutActionSheetStyleView {
    // 移除宽度约束
    for (NSLayoutConstraint *constraint in _alertView.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeWidth) {
            [_alertView removeConstraint:constraint];
            break;
        }
    }
    
    [self.view scott_addConstraintWithView:_alertView topView:nil leftView:self.view bottomView:self.view rightView:self.view edgeInset:UIEdgeInsetsMake(0, _actionSheetStyleMargin, 0, -_actionSheetStyleMargin)];
    
    if (CGRectGetHeight(_alertView.frame) > 0) {
        // height
        [_alertView scott_addConstraintWidth:0 height:CGRectGetHeight(_alertView.frame)];
    }
}

- (void)configureController {
    // 是否视图控制器定义它呈现视图控制器的过渡风格（默认为NO）
    self.providesPresentationContextTransitionStyle = YES;
    self.definesPresentationContext = YES;
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.transitioningDelegate = self;
    
    _backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    _tapBackgroundDismissEnable = NO;
    _alertStyleMargin = 15.0;
    _actionSheetStyleMargin = 0.0;
}

- (void)dismissViewControllerAnimated:(BOOL)animated {
    [self dismissViewControllerAnimated:animated completion:self.dismissCompleteBlock];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - keyboard notification
- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat alertViewBottomEdge = (CGRectGetHeight(self.view.frame) -  CGRectGetHeight(_alertView.frame))/2 - _alertViewCenterYOffset;
    
    //当开启热点时，向下偏移20px
    //修复键盘遮挡问题
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat differ = CGRectGetHeight(keyboardRect) - alertViewBottomEdge;
    
    //修复：输入框获取焦点时，会重复刷新，导致输入框文章偏移一下
    if (_alertCenterYConstraint.constant == -differ -statusBarHeight) {
        return;
    }
    
    if (differ >= 0) {
        _alertCenterYConstraint.constant = _alertViewCenterYOffset - differ - statusBarHeight;
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

- (void)keyboardWillHide:(NSNotification *)note {
    _alertCenterYConstraint.constant = _alertViewCenterYOffset;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}


#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    switch (self.transitionStyle) {
        case ScottAlertTransitionStyleFade:
            return [ScottFadeAnimation animationIsPresenting:YES];
        case ScottAlertTransitionStyleScaleFade:
            return [ScottScaleFadeAnimation animationIsPresenting:YES];
        case ScottAlertTransitionStyleDropDown:
            return [ScottDropDownAnimation animationIsPresenting:YES];
        case scottAlertTransitionStyleCustom:
            return [self.class animationIsPresenting:YES preferredStyle:self.preferredStyle];
        default:
            return nil;
    }
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    switch (self.transitionStyle) {
        case ScottAlertTransitionStyleFade:
            return [ScottFadeAnimation animationIsPresenting:NO];
        case ScottAlertTransitionStyleScaleFade:
            return [ScottScaleFadeAnimation animationIsPresenting:NO];
        case ScottAlertTransitionStyleDropDown:
            return [ScottDropDownAnimation animationIsPresenting:NO];
        case scottAlertTransitionStyleCustom:
            return [self.class animationIsPresenting:NO preferredStyle:self.preferredStyle];
        default:
            return nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
