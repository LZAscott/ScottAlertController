//
//  UIView+ScottAutoLayout.h
//  QQLive
//
//  Created by Scott_Mr on 2016/12/1.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ScottAutoLayout)


/**
 view到父视图的边距约束

 @param view 需要添加约束的view
 @param edgeInset 边距
 */
- (void)scott_addConstraintToView:(UIView *)view edgeInset:(UIEdgeInsets)edgeInset;


/**
 给view添加四边约束

 @param view 需要添加约束的view
 @param topView 顶部参考视图
 @param leftView 左边参考视图
 @param bottomView 底部参考视图
 @param rightView 右边参考视图
 @param edgeInset 边距
 */
- (void)scott_addConstraintWithView:(UIView *)view topView:(UIView *)topView leftView:(UIView *)leftView
                   bottomView:(UIView *)bottomView rightView:(UIView *)rightView edgeInset:(UIEdgeInsets)edgeInset;


/**
 leftView右边到rightView左边的约束

 @param leftView 需要添加约束的view
 @param rightView 参考view
 @param constant 约束距离
 @return 约束
 */
- (NSLayoutConstraint *)scott_addConstraintWithLeftView:(UIView *)leftView toRightView:(UIView *)rightView constant:(CGFloat)constant;


/**
 topView底部到bottomView顶部的约束

 @param topView 需要添加约束的view
 @param bottomView 参考view
 @param constant 约束距离
 @return 约束
 */
- (NSLayoutConstraint *)scott_addConstraintWithTopView:(UIView *)topView toBottomView:(UIView *)bottomView constant:(CGFloat)constant;


/**
 固定view的宽高

 @param width 宽
 @param height 高
 */
- (void)scott_addConstraintWidth:(CGFloat)width height:(CGFloat)height;


/**
 view和wView等宽，和hView等高

 @param view 需要添加约束的view
 @param wView 宽度参考view
 @param hView 高度参考view
 */
- (void)scott_addConstraintEqualWithView:(UIView *)view widthToView:(UIView *)wView heightToView:(UIView *)hView;


/**
 yView的中点y坐标与父视图中点y坐标的约束

 @param yView 需要添加约束的view
 @param constant 约束距离
 @return 约束
 */
- (NSLayoutConstraint *)scott_addConstraintCenterYToView:(UIView *)yView constant:(CGFloat)constant;



/**
 xView的中点x坐标与父视图中点x坐标的约束

 @param xView 需要添加约束的view
 @param constant 约束距离
 @return 约束
 */
- (NSLayoutConstraint *)scott_addConstraintCenterXToView:(UIView *)xView constant:(CGFloat)constant;

/**
 移除view的某个约束
 
 @param attr 某个约束
 */
- (void)scott_removeConstraintWithAttribte:(NSLayoutAttribute)attr;


/**
 移除指定某个子view的某个约束
 
 @param view 子view
 @param attr 某个约束
 */
- (void)scott_removeConstraintWithView:(UIView *)view attribute:(NSLayoutAttribute)attr;

/**
 移除所有的约束
 */
- (void)scott_removeAllConstraints;

@end
