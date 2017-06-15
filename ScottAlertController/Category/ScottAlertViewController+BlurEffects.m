//
//  ScottAlertViewController+BlurEffects.m
//  ScottAlertViewDemo
//
//  Created by Scott_Mr on 2017/6/15.
//  Copyright © 2017年 Scott. All rights reserved.
//

#import "ScottAlertViewController+BlurEffects.h"
#import "UIImage+ScottAlertView.h"

@implementation ScottAlertViewController (BlurEffects)

#pragma mark - 设置模糊背景
- (void)setBlurEffectWithView:(UIView *)effectView {
    [self setBlurEffectWithView:effectView style:ScottEffectStyleLite];
}

- (void)setBlurEffectWithView:(UIView *)effectView style:(ScottEffectStyle)style {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        UIImage *snapImage = [UIImage scott_snapshotImageWithView:effectView];
        UIImage *blurImage = [self blurImageWithSnapImage:snapImage style:style];
    
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImageView *imageView = [[UIImageView alloc] initWithImage:blurImage];
            imageView.userInteractionEnabled = YES;
            self.backgroundView = imageView;
        });
    });
}

- (UIImage *)blurImageWithSnapImage:(UIImage *)image style:(ScottEffectStyle)style {
    switch (style) {
        case ScottEffectStyleLite:{
            return [image scott_alertViewLite];
        }
            break;
        case ScottEffectStyleDark:{
            return [image scott_alertViewDark];
        }
            break;
        default:
            break;
    }
}

@end
