//
//  ViewController.m
//  ScottAlertViewDemo
//
//  Created by Scott_Mr on 2016/12/6.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ViewController.h"
#import "ScottAlertController.h"
#import "UIImage+ScottAlertView.h"
#import "ScottCustomAlertView.h"
#import "ScottCustomActionSheet.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

/// 默认形式的alertView
- (IBAction)defaultAlertViewClick:(UIButton *)sender {
    ScottAlertView *alertView = [ScottAlertView alertViewWithTitle:@"ScottAlertView" message:@"这是一段描述文字这是一段描述文字这是一段描述文字这是一段描述文字这是一段描述文字这是一段描述文字."];
    
    [alertView addAction:[ScottAlertAction actionWithTitle:@"取消" style:ScottAlertActionStyleCancel handler:^(ScottAlertAction *action) {
        
    }]];
    
    [alertView addAction:[ScottAlertAction actionWithTitle:@"确定" style:ScottAlertActionStyleDestructive handler:^(ScottAlertAction *action) {
        
    }]];
    
    ScottAlertViewController *alertController = [ScottAlertViewController alertControllerWithAlertView:alertView preferredStyle:ScottAlertControllerStyleAlert transitionAnimationStyle:ScottAlertTransitionStyleDropDown];
    alertController.tapBackgroundDismissEnable = YES;
    [self presentViewController:alertController animated:YES completion:nil];
}

/// 自定义形式的alertView
- (IBAction)customAlertViewClick:(UIButton *)sender {
    ScottCustomAlertView *customAlertView = [ScottCustomAlertView createViewFromNib];
    ScottAlertViewController *alertController = [ScottAlertViewController alertControllerWithAlertView:customAlertView preferredStyle:ScottAlertControllerStyleAlert transitionAnimationStyle:ScottAlertTransitionStyleFade];
    alertController.tapBackgroundDismissEnable = YES;
    [self presentViewController:alertController animated:YES completion:nil];
}

/// 背景模糊的alertView
- (IBAction)effAlertViewClick:(UIButton *)sender {
    
    ScottAlertView *alertView = [ScottAlertView alertViewWithTitle:@"ScottAlertView" message:@"这是一段描述文字这是一段描述文字这是一段描述文字这是一段描述文字这是一段描述文字这是一段描述文字."];
    
    [alertView addAction:[ScottAlertAction actionWithTitle:@"取消" style:ScottAlertActionStyleCancel handler:^(ScottAlertAction *action) {
        
    }]];
    
    [alertView addAction:[ScottAlertAction actionWithTitle:@"确定" style:ScottAlertActionStyleDestructive handler:^(ScottAlertAction *action) {
        
    }]];
    
    ScottAlertViewController *alertController = [ScottAlertViewController alertControllerWithAlertView:alertView preferredStyle:ScottAlertControllerStyleAlert];
    
    [alertController setBlurEffectWithView:self.view style:ScottEffectStyleLite];
    alertController.tapBackgroundDismissEnable = YES;
    [self presentViewController:alertController animated:YES completion:nil];
}

/// 带有textfield的alertView
- (IBAction)textfieldAlertViewClick:(UIButton *)sender {
    ScottAlertView *alertView = [ScottAlertView alertViewWithTitle:@"ScottAlertView" message:@"This is a message, the alert view containt text and textfiled. "];
    
    [alertView addAction:[ScottAlertAction actionWithTitle:@"取消" style:ScottAlertActionStyleCancel handler:^(ScottAlertAction *action) {
        NSLog(@"%@",action.title);
    }]];
    
    // 弱引用alertView 否则 会循环引用
    __weak typeof(alertView) weakAlertView = alertView;
    [alertView addAction:[ScottAlertAction actionWithTitle:@"确定" style:ScottAlertActionStyleDestructive handler:^(ScottAlertAction *action) {
        
        NSLog(@"%@",action.title);
        for (UITextField *textField in weakAlertView.textFieldArray) {
            NSLog(@"%@",textField.text);
        }
    }]];
    
    [alertView addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入账号";
    }];
    [alertView addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入密码";
    }];
    
    ScottAlertViewController *alertController = [ScottAlertViewController alertControllerWithAlertView:alertView preferredStyle:ScottAlertControllerStyleAlert transitionAnimationStyle:ScottAlertTransitionStyleScaleFade];
    alertController.tapBackgroundDismissEnable = YES;
    [self presentViewController:alertController animated:YES completion:nil];
}

/// 默认形式的actionSheet
- (IBAction)defaultActionSheetClick:(UIButton *)sender {
    ScottAlertView *alertView = [ScottAlertView alertViewWithTitle:@"ScottActionSheet" message:@"This is a message, the alert view style is actionsheet. "];
    
    [alertView addAction:[ScottAlertAction actionWithTitle:@"默认1" style:ScottAlertActionStyleDefault handler:^(ScottAlertAction *action) {
        NSLog(@"%@",action.title);
    }]];
    
    [alertView addAction:[ScottAlertAction actionWithTitle:@"删除" style:ScottAlertActionStyleDestructive handler:^(ScottAlertAction *action) {
        NSLog(@"%@",action.title);
    }]];
    [alertView addAction:[ScottAlertAction actionWithTitle:@"取消" style:ScottAlertActionStyleCancel handler:^(ScottAlertAction *action) {
        NSLog(@"%@",action.title);
    }]];
    
    ScottAlertViewController *alertController = [ScottAlertViewController alertControllerWithAlertView:alertView preferredStyle:ScottAlertControllerStyleActionSheet];
    alertController.tapBackgroundDismissEnable = YES;
    [self presentViewController:alertController animated:YES completion:nil];
}

/// 自定义形式的actionSheet
- (IBAction)customActionSheetClick:(UIButton *)sender {
    ScottCustomActionSheet *customActionSheet = [ScottCustomActionSheet createViewFromNib];
    ScottAlertViewController *alertController = [ScottAlertViewController alertControllerWithAlertView:customActionSheet preferredStyle:ScottAlertControllerStyleActionSheet transitionAnimationStyle:ScottAlertTransitionStyleFade];
    alertController.tapBackgroundDismissEnable = YES;
    [self presentViewController:alertController animated:YES completion:nil];
}

/// 显示在窗口的alertView
- (IBAction)showOnWindowClick:(UIButton *)sender {
    ScottAlertView *alertView = [ScottAlertView alertViewWithTitle:@"提示" message:@"这是一个显示在窗口的alertView"];
    ScottAlertAction *action = [ScottAlertAction actionWithTitle:@"好的" style:ScottAlertActionStyleDestructive handler:nil];
    [alertView addAction:action];
    [ScottShowAlertView showAlertViewWithView:alertView backgroundDismissEnable:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
