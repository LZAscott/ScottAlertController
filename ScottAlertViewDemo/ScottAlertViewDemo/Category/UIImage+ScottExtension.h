//
//  UIImage+ScottExtension.h
//  ScottAlertViewDemo
//
//  Created by Scott_Mr on 2016/12/6.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ScottExtension)

/// 获取屏幕截图
///
/// @return 屏幕截图图像
+ (UIImage *)scott_screenShot;


/**
 *  生成一张高斯模糊的图片
 *
 *  @param image 原图
 *  @param blur  模糊程度 (0~1)
 *
 *  @return 高斯模糊图片
 */
+ (UIImage *)scott_blurImage:(UIImage *)image blur:(CGFloat)blur;


@end
