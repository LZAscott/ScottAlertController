# ScottAlertView
can display on controller and window,support custom view, custom animation, use AutoLayout,support iPhone,iPad.

# ScreenShot
![ScreenShot](https://github.com/LZAscott/ScottAlertController/blob/master/1.gif)

# Requirements
* Xcode 5 +
* iOS 7.0 +
* ARC

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
    UIImage *img = [UIImage scott_screenShot];
    img = [UIImage scott_blurImage:img blur:0.4];
    
    ScottAlertView *alertView = [ScottAlertView alertViewWithTitle:@"ScottAlertView" message:@"这是一段描述文字这是一段描述文字这是一段描述文字这是一段描述文字这是一段描述文字这是一段描述文字."];
    
    [alertView addAction:[ScottAlertAction actionWithTitle:@"取消" style:ScottAlertActionStyleCancel handler:^(ScottAlertAction *action) {
        
    }]];
    
    [alertView addAction:[ScottAlertAction actionWithTitle:@"确定" style:ScottAlertActionStyleDestructive handler:^(ScottAlertAction *action) {
        
    }]];
    
    ScottAlertViewController *alertController = [ScottAlertViewController alertControllerWithAlertView:alertView preferredStyle:ScottAlertControllerStyleAlert transitionAnimationStyle:ScottAlertTransitionStyleFade];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    imgView.userInteractionEnabled = YES;
    alertController.backgroundView = imgView;
    
    alertController.tapBackgroundDismissEnable = YES;
    [self presentViewController:alertController animated:YES completion:nil];
    ```
    
# Contact
* if you found a bug, open an issue
* if you need help, open an issue
* if you have a new demand, also open an issue

