//
//  UIView+ScottAutoLayout.m
//  QQLive
//
//  Created by Scott_Mr on 2016/12/1.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "UIView+ScottAutoLayout.h"

@implementation UIView (ScottAutoLayout)

- (void)scott_addConstraintToView:(UIView *)view edgeInset:(UIEdgeInsets)edgeInset {
    if (view.translatesAutoresizingMaskIntoConstraints) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    [self scott_addConstraintWithView:view topView:self leftView:self bottomView:self rightView:self edgeInset:edgeInset];
}

- (void)scott_addConstraintWithView:(UIView *)view topView:(UIView *)topView leftView:(UIView *)leftView bottomView:(UIView *)bottomView rightView:(UIView *)rightView edgeInset:(UIEdgeInsets)edgeInset
{
    if (view.translatesAutoresizingMaskIntoConstraints) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    if (topView) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:topView attribute:NSLayoutAttributeTop multiplier:1 constant:edgeInset.top]];
    }
    
    if (leftView) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:leftView attribute:NSLayoutAttributeLeft multiplier:1 constant:edgeInset.left]];
    }
    
    if (rightView) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:rightView attribute:NSLayoutAttributeRight multiplier:1 constant:edgeInset.right]];
    }
    
    if (bottomView) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:bottomView attribute:NSLayoutAttributeBottom multiplier:1 constant:edgeInset.bottom]];
    }
}

- (NSLayoutConstraint *)scott_addConstraintWithLeftView:(UIView *)leftView toRightView:(UIView *)rightView constant:(CGFloat)constant {
    if (leftView.translatesAutoresizingMaskIntoConstraints) {
        leftView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:leftView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:rightView attribute:NSLayoutAttributeLeft multiplier:1 constant:-constant];
    [self addConstraint:rightConstraint];
    
    return rightConstraint;
}

- (NSLayoutConstraint *)scott_addConstraintWithTopView:(UIView *)topView toBottomView:(UIView *)bottomView constant:(CGFloat)constant
{
    if (topView.translatesAutoresizingMaskIntoConstraints) {
        topView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    NSLayoutConstraint *topBottomConstraint =[NSLayoutConstraint constraintWithItem:topView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:bottomView attribute:NSLayoutAttributeTop multiplier:1 constant:-constant];
    [self addConstraint:topBottomConstraint];
    return topBottomConstraint;
}

- (void)scott_addConstraintWidth:(CGFloat)width height:(CGFloat)height {
    if (self.translatesAutoresizingMaskIntoConstraints) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }

    if (width > 0) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:width]];
    }
    
    if (height > 0) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:height]];
    }
}

- (void)scott_addConstraintEqualWithView:(UIView *)view widthToView:(UIView *)wView heightToView:(UIView *)hView {
    if (view.translatesAutoresizingMaskIntoConstraints) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }

    if (wView) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:wView attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    }
    
    if (hView) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:hView attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    }
}

- (NSLayoutConstraint *)scott_addConstraintCenterXToView:(UIView *)xView constant:(CGFloat)constant {
    if (xView.translatesAutoresizingMaskIntoConstraints) {
        xView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    
    NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:xView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:constant];
    [self addConstraint:centerXConstraint];
    return centerXConstraint;
}

- (NSLayoutConstraint *)scott_addConstraintCenterYToView:(UIView *)yView constant:(CGFloat)constant {
    if (yView.translatesAutoresizingMaskIntoConstraints) {
        yView.translatesAutoresizingMaskIntoConstraints = NO;
    }

    NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:yView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:constant];
    [self addConstraint:centerYConstraint];
    return centerYConstraint;
}

- (void)scott_removeConstraintWithAttribte:(NSLayoutAttribute)attr {
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == attr) {
            [self removeConstraint:constraint];
            break;
        }
    }
}

- (void)scott_removeConstraintWithView:(UIView *)view attribute:(NSLayoutAttribute)attr {
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == attr && constraint.firstItem == view) {
            [self removeConstraint:constraint];
            break;
        }
    }
}

- (void)scott_removeAllConstraints {
    [self removeConstraints:self.constraints];
}


@end
