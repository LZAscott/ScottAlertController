//
//  UIImage+ScottAlertView.h
//  ScottAlertViewDemo
//
//  Created by Scott_Mr on 2017/6/15.
//  Copyright © 2017年 Scott. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ScottAlertView)

- (UIImage *)scott_alertViewLite;
- (UIImage *)scott_alertViewDark;


// snapscreen
+ (UIImage *)scott_snapshotImageWithView:(UIView *)view;

@end
