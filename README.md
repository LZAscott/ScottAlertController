# ScottAlertController
can display on controller and window,support custom view, custom animation, use AutoLayout,support iPhone,iPad.
if ScottAlertController can help you, i hope you give a star

# ScreenShot
![ScreenShot](https://github.com/LZAscott/ScottAlertController/blob/master/1.gif)

# Requirements
* Xcode 5 +
* iOS 7.0 +
* ARC

# The way to import
* Cocoapods

```
pod 'ScottAlertController'
```

* download and drag to your project

# How to use
* show in controller

    ```objc
    ScottAlertView *alertView = [ScottAlertView alertViewWithTitle:@"ScottAlertView" message:@"这是一段描述文字这是一段描述文字这是一段描述文字这是一段描述文字这是一段描述文字这是一段描述文字."];
    
    [alertView addAction:[ScottAlertAction actionWithTitle:@"取消" style:ScottAlertActionStyleCancel handler:^(ScottAlertAction *action) {
        
    }]];
    
    [alertView addAction:[ScottAlertAction actionWithTitle:@"确定" style:ScottAlertActionStyleDestructive handler:^(ScottAlertAction *action) {
        
    }]];
    
    ScottAlertViewController *alertController = [ScottAlertViewController alertControllerWithAlertView:alertView preferredStyle:ScottAlertControllerStyleAlert transitionAnimationStyle:ScottAlertTransitionStyleDropDown];
    alertController.tapBackgroundDismissEnable = YES;
    [self presentViewController:alertController animated:YES completion:nil];
    
    ```

* show in window

    ```objc
    ScottAlertView *alertView = [ScottAlertView alertViewWithTitle:@"提示" message:@"这是一个显示在窗口的alertView"];
    ScottAlertAction *action = [ScottAlertAction actionWithTitle:@"好的" style:ScottAlertActionStyleDestructive handler:nil];
    [alertView addAction:action];
    
    [ScottShowAlertView showAlertViewWithView:alertView backgroundDismissEnable:YES];
    ```
    
* show with blur effect

    ```objc
    ScottAlertView *alertView = [ScottAlertView alertViewWithTitle:@"ScottAlertView" message:@"这是一段描述文字这是一段描述文字这是一段描述文字这是一段描述文字这是一段描述文字这是一段描述文字."];
    
    [alertView addAction:[ScottAlertAction actionWithTitle:@"取消" style:ScottAlertActionStyleCancel handler:^(ScottAlertAction *action) {
        
    }]];
    
    [alertView addAction:[ScottAlertAction actionWithTitle:@"确定" style:ScottAlertActionStyleDestructive handler:^(ScottAlertAction *action) {
        
    }]];
    
    ScottAlertViewController *alertController = [ScottAlertViewController alertControllerWithAlertView:alertView preferredStyle:ScottAlertControllerStyleAlert transitionAnimationStyle:ScottAlertTransitionStyleFade];
    
    [alertController setBlurEffectWithView:self.view style:ScottEffectStyleLite];
    
    alertController.tapBackgroundDismissEnable = YES;
    [self presentViewController:alertController animated:YES completion:nil];
    ```
    
# Contact
* if you found a bug, open an issue
* if you need help, open an issue
* if you have a new demand, also open an issue




# 中文说明

# 介绍
ScottAlertController 既能显示在控制器上又能显示在window上，支持自定义弹出的view,弹出动画，采用AutoLayout自动布局，支持iPhone，iPad.

如果ScottAlertController能够帮助到你，希望你能够给我star.

# 截屏
![ScreenShot](https://github.com/LZAscott/ScottAlertController/blob/master/1.gif)

# 要求
* Xcode 5 +
* iOS 7.0 +
* ARC

# 导入方式
* 方式一： Cocoapods

```
pod 'ScottAlertController'
```

* 方式二：下载，然后拖入你的项目

# 如何使用
* 展示在Controller上

    ```objc
    ScottAlertView *alertView = [ScottAlertView alertViewWithTitle:@"ScottAlertView" message:@"这是一段描述文字这是一段描述文字这是一段描述文字这是一段描述文字这是一段描述文字这是一段描述文字."];
    
    [alertView addAction:[ScottAlertAction actionWithTitle:@"取消" style:ScottAlertActionStyleCancel handler:^(ScottAlertAction *action) {
        
    }]];
    
    [alertView addAction:[ScottAlertAction actionWithTitle:@"确定" style:ScottAlertActionStyleDestructive handler:^(ScottAlertAction *action) {
        
    }]];
    
    ScottAlertViewController *alertController = [ScottAlertViewController alertControllerWithAlertView:alertView preferredStyle:ScottAlertControllerStyleAlert transitionAnimationStyle:ScottAlertTransitionStyleDropDown];
    alertController.tapBackgroundDismissEnable = YES;
    [self presentViewController:alertController animated:YES completion:nil];
    
    ```

* 展示在Window上

    ```objc
    ScottAlertView *alertView = [ScottAlertView alertViewWithTitle:@"提示" message:@"这是一个显示在窗口的alertView"];
    ScottAlertAction *action = [ScottAlertAction actionWithTitle:@"好的" style:ScottAlertActionStyleDestructive handler:nil];
    [alertView addAction:action];
    
    [ScottShowAlertView showAlertViewWithView:alertView backgroundDismissEnable:YES];
    ```
    
* 背景模糊方式

    ```objc
    
    ScottAlertView *alertView = [ScottAlertView alertViewWithTitle:@"ScottAlertView" message:@"这是一段描述文字这是一段描述文字这是一段描述文字这是一段描述文字这是一段描述文字这是一段描述文字."];
    
    [alertView addAction:[ScottAlertAction actionWithTitle:@"取消" style:ScottAlertActionStyleCancel handler:^(ScottAlertAction *action) {
        
    }]];
    
    [alertView addAction:[ScottAlertAction actionWithTitle:@"确定" style:ScottAlertActionStyleDestructive handler:^(ScottAlertAction *action) {
        
    }]];
    
    ScottAlertViewController *alertController = [ScottAlertViewController alertControllerWithAlertView:alertView preferredStyle:ScottAlertControllerStyleAlert transitionAnimationStyle:ScottAlertTransitionStyleFade];
    
    [alertController setBlurEffectWithView:self.view style:ScottEffectStyleLite];
    
    alertController.tapBackgroundDismissEnable = YES;
    [self presentViewController:alertController animated:YES completion:nil];
    ```
    
# 联系
* 如果你发现有bug，欢迎提issue
* 如果你需要帮忙拓展，欢迎提issue
* 如果你想为代码做贡献，欢迎联系。

