//
//  ScottAlertViewController+BlurEffects.h
//  ScottAlertViewDemo
//
//  Created by Scott_Mr on 2017/6/15.
//  Copyright © 2017年 Scott. All rights reserved.
//

#import "ScottAlertViewController.h"

typedef NS_ENUM(NSInteger, ScottEffectStyle) {
    ScottEffectStyleLite = 0,
    ScottEffectStyleDark
};

@interface ScottAlertViewController (BlurEffects)

- (void)setBlurEffectWithView:(UIView *)effectView;
- (void)setBlurEffectWithView:(UIView *)effectView style:(ScottEffectStyle)style;

@end
