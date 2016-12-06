//
//  ScottAlertView.m
//  QQLive
//
//  Created by Scott_Mr on 2016/12/1.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottAlertView.h"
#import "UIView+ScottAutoLayout.h"
#import "ScottAlertViewController.h"
#import "UIView+ScottAlertView.h"

@interface ScottAlertAction ()

@property (nullable, nonatomic) NSString *title;
@property (nonatomic, assign) ScottAlertActionStyle style;
@property (nonatomic, copy) void(^handler)(ScottAlertAction *);

@end

@implementation ScottAlertAction


+ (instancetype)actionWithTitle:(nullable NSString *)title style:(ScottAlertActionStyle)style handler:(void (^ __nullable)(ScottAlertAction *action))handler {
    return [[self alloc] initWithTitle:title style:style handler:handler];
}

- (instancetype)initWithTitle:(NSString *)title style:(ScottAlertActionStyle)style handler:(void(^)(ScottAlertAction *))handler {
    if (self = [super init]) {
        _title = title;
        _style = style;
        _handler = handler;
        _enabled = YES;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    ScottAlertAction *action = [self copyWithZone:zone];
    action.title = self.title;
    action.style = self.style;
    return action;
}

@end


@interface ScottAlertView ()

// text content View
@property (nonatomic, weak) UIView *textContentView;
@property (nonatomic, weak) UILabel *titleLable;
@property (nonatomic, weak) UILabel *messageLabel;

@property (nonatomic, weak) UIView *textFieldContentView;
@property (nonatomic, weak) NSLayoutConstraint *textFieldTopConstraint;
@property (nonatomic, strong) NSMutableArray *textFields;
@property (nonatomic, strong) NSMutableArray *textFieldSeparateViews;

// button content View
@property (nonatomic, weak) UIView *buttonContentView;
@property (nonatomic, weak) NSLayoutConstraint *buttonTopConstraint;

@property (nonatomic, strong) NSMutableArray<UIButton *> *buttons;
@property (nonatomic, strong) NSMutableArray<ScottAlertAction *> *actions;

@end

#define kAlertViewWidth 280
#define kContentViewEdge 15
#define kContentViewSpace 15

#define kTextLabelSpace  6

#define kButtonTagOffset 1000
#define kButtonSpace     6
#define KButtonHeight    44

#define kTextFieldOffset 10000
#define kTextFieldHeight 29
#define kTextFieldEdge  8
#define KTextFieldBorderWidth 0.5


@implementation ScottAlertView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self configureProperty];
        
        [self addContentViews];
        
        [self addTextLabels];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message {
    if (self = [super init]) {
        _titleLable.text = title;
        _messageLabel.text = message;
    }
    return self;
}

+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSString *)message {
    return [[self alloc]initWithTitle:title message:message];
}

#pragma mark - 初始化变量
- (void)configureProperty {
    self.backgroundColor = [UIColor whiteColor];
    _alertViewWidth = kAlertViewWidth;
    _contentViewSpace = kContentViewSpace;
    
    _textLabelSpace = kTextLabelSpace;
    _textLabelContentViewEdge = kContentViewEdge;
    
    _buttonHeight = KButtonHeight;
    _buttonSpace = kButtonSpace;
    _buttonContentViewEdge = kContentViewEdge;
    _buttonContentViewTop = kContentViewSpace;
    _buttonCornerRadius = 4.0;
    _buttonFont = [UIFont fontWithName:@"HelveticaNeue" size:18];
    _buttonDefaultBgColor = [UIColor colorWithRed:52/255.0 green:152/255.0 blue:219/255.0 alpha:1];
    _buttonCancelBgColor = [UIColor colorWithRed:127/255.0 green:140/255.0 blue:141/255.0 alpha:1];
    _buttonDestructiveBgColor = [UIColor colorWithRed:231/255.0 green:76/255.0 blue:60/255.0 alpha:1];
    
    _textFieldHeight = kTextFieldHeight;
    _textFieldEdge = kTextFieldEdge;
    _textFieldBorderWidth = KTextFieldBorderWidth;
    _textFieldContentViewEdge = kContentViewEdge;
    
    _textFieldBorderColor = [UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1];
    _textFieldBackgroudColor = [UIColor whiteColor];
    _textFieldFont = [UIFont systemFontOfSize:14];
    
    _buttons = [NSMutableArray array];
    _actions = [NSMutableArray array];
}

- (UIColor *)buttonBgColorWithStyle:(ScottAlertActionStyle)style {
    switch (style) {
        case ScottAlertActionStyleDefault:
            return _buttonDefaultBgColor;
        case ScottAlertActionStyleCancel:
            return _buttonCancelBgColor;
        case ScottAlertActionStyleDestructive:
            return _buttonDestructiveBgColor;
            
        default:
            return nil;
    }
}

#pragma mark - add contentview

- (void)addContentViews
{
    UIView *textContentView = [[UIView alloc]init];
    [self addSubview:textContentView];
    _textContentView = textContentView;
    
    UIView *textFieldContentView = [[UIView alloc]init];
    [self addSubview:textFieldContentView];
    _textFieldContentView = textFieldContentView;
    
    UIView *buttonContentView = [[UIView alloc]init];
    buttonContentView.userInteractionEnabled = YES;
    [self addSubview:buttonContentView];
    _buttonContentView = buttonContentView;
}

- (void)addTextLabels
{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
    titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [_textContentView addSubview:titleLabel];
    _titleLable = titleLabel;
    
    UILabel *messageLabel = [[UILabel alloc]init];
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    messageLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [_textContentView addSubview:messageLabel];
    _messageLabel = messageLabel;
}

- (void)didMoveToSuperview
{
    if (self.superview) {
        [self layoutContentViews];
        [self layoutTextLabels];
    }
}

- (void)addAction:(ScottAlertAction *)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.clipsToBounds = YES;
    button.layer.cornerRadius = _buttonCornerRadius;
    [button setTitle:action.title forState:UIControlStateNormal];
    button.titleLabel.font = _buttonFont;
    button.backgroundColor = [self buttonBgColorWithStyle:action.style];
    button.enabled = action.enabled;
    button.tag = kButtonTagOffset + _buttons.count;
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [_buttonContentView addSubview:button];
    [_buttons addObject:button];
    [_actions addObject:action];
    
    if (_buttons.count == 1) {
        [self layoutContentViews];
        [self layoutTextLabels];
    }
    
    [self layoutButtons];
}

- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField *textField))configurationHandler
{
    if (_textFields == nil) {
        _textFields = [NSMutableArray array];
    }
    
    UITextField *textField = [[UITextField alloc]init];
    textField.tag = kTextFieldOffset + _textFields.count;
    textField.font = _textFieldFont;
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    
    if (configurationHandler) {
        configurationHandler(textField);
    }
    
    [_textFieldContentView addSubview:textField];
    [_textFields addObject:textField];
    
    if (_textFields.count > 1) {
        if (_textFieldSeparateViews == nil) {
            _textFieldSeparateViews = [NSMutableArray array];
        }
        UIView *separateView = [[UIView alloc]init];
        separateView.backgroundColor = _textFieldBorderColor;
        separateView.translatesAutoresizingMaskIntoConstraints = NO;
        [_textFieldContentView addSubview:separateView];
        [_textFieldSeparateViews addObject:separateView];
    }
    
    [self layoutTextFields];
}

- (NSArray *)textFieldArray
{
    return _textFields;
}

#pragma mark - layout contenview

- (void)layoutContentViews {
    if (!_textContentView.translatesAutoresizingMaskIntoConstraints) return;
    if (_alertViewWidth) {
        [self scott_addConstraintWidth:_alertViewWidth height:0];
    }
    
    // textContentView
    _textContentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self scott_addConstraintWithView:_textContentView topView:self leftView:self bottomView:nil rightView:self edgeInset:UIEdgeInsetsMake(_contentViewSpace, _textLabelContentViewEdge, 0, -_textLabelContentViewEdge)];
    
    // textFieldContentView
    _textFieldContentView.translatesAutoresizingMaskIntoConstraints = NO;
    _textFieldTopConstraint = [self scott_addConstraintWithTopView:_textContentView toBottomView:_textFieldContentView constant:0];
    
    [self scott_addConstraintWithView:_textFieldContentView topView:nil leftView:self bottomView:nil rightView:self edgeInset:UIEdgeInsetsMake(0, _textFieldContentViewEdge, 0, -_textFieldContentViewEdge)];
    
    // buttonContentView
    _buttonContentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    _buttonTopConstraint = [self scott_addConstraintWithTopView:_textFieldContentView toBottomView:_buttonContentView constant:_buttonContentViewTop];
    
    [self scott_addConstraintWithView:_buttonContentView topView:nil leftView:self bottomView:self rightView:self edgeInset:UIEdgeInsetsMake(0, _buttonContentViewEdge, -_contentViewSpace, -_buttonContentViewEdge)];
}

- (void)layoutTextLabels {
    if (!_titleLable.translatesAutoresizingMaskIntoConstraints && !_messageLabel.translatesAutoresizingMaskIntoConstraints) return;
    // title
    _titleLable.translatesAutoresizingMaskIntoConstraints = NO;
    [_textContentView scott_addConstraintWithView:_titleLable topView:_textContentView leftView:_textContentView bottomView:nil rightView:_textContentView edgeInset:UIEdgeInsetsZero];
    
    // message
    _messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_textContentView scott_addConstraintWithTopView:_titleLable toBottomView:_messageLabel constant:_textLabelSpace];
    [_textContentView scott_addConstraintWithView:_messageLabel topView:nil leftView:_textContentView bottomView:_textContentView rightView:_textContentView edgeInset:UIEdgeInsetsZero];
}

- (void)layoutButtons {
    UIButton *button = _buttons.lastObject;
    if (_buttons.count == 1) {
        _buttonTopConstraint.constant = -_buttonContentViewTop;
        [_buttonContentView scott_addConstraintToView:button edgeInset:UIEdgeInsetsZero];
        [button scott_addConstraintWidth:0 height:_buttonHeight];
    }else if (_buttons.count == 2) {
        UIButton *firstButton = _buttons.firstObject;
        [_buttonContentView scott_removeConstraintWithView:firstButton attribute:NSLayoutAttributeRight];
        [_buttonContentView scott_addConstraintWithView:button topView:_buttonContentView leftView:nil bottomView:nil rightView:_buttonContentView edgeInset:UIEdgeInsetsZero];
        [_buttonContentView scott_addConstraintWithLeftView:firstButton toRightView:button constant:_buttonSpace];
        [_buttonContentView scott_addConstraintEqualWithView:button widthToView:firstButton heightToView:firstButton];
    }else {
        if (_buttons.count == 3) {
            UIButton *firstBtn = _buttons[0];
            UIButton *secondBtn = _buttons[1];
            [_buttonContentView scott_removeConstraintWithView:firstBtn attribute:NSLayoutAttributeRight];
            [_buttonContentView scott_removeConstraintWithView:firstBtn attribute:NSLayoutAttributeBottom];
            [_buttonContentView scott_removeConstraintWithView:secondBtn attribute:NSLayoutAttributeTop];
            [_buttonContentView scott_addConstraintWithView:firstBtn topView:nil leftView:nil bottomView:nil rightView:_buttonContentView edgeInset:UIEdgeInsetsZero];
            [_buttonContentView scott_addConstraintWithTopView:firstBtn toBottomView:secondBtn constant:_buttonSpace];
            
        }
        
        UIButton *lastSecondBtn = _buttons[_buttons.count - 2];
        [_buttonContentView scott_removeConstraintWithView:lastSecondBtn attribute:NSLayoutAttributeBottom];
        [_buttonContentView scott_addConstraintWithTopView:lastSecondBtn toBottomView:button constant:_buttonSpace];
        [_buttonContentView scott_addConstraintWithView:button topView:nil leftView:_buttonContentView bottomView:_buttonContentView rightView:_buttonContentView edgeInset:UIEdgeInsetsZero];
        [_buttonContentView scott_addConstraintEqualWithView:button widthToView:nil heightToView:lastSecondBtn];
    }
}

- (void)layoutTextFields {
    UITextField *textField = _textFields.lastObject;
    
    if (_textFields.count == 1) {
        _textFieldContentView.backgroundColor = _textFieldBackgroudColor;
        _textFieldContentView.layer.masksToBounds = YES;
        _textFieldContentView.layer.cornerRadius = 4;
        _textFieldContentView.layer.borderWidth = _textFieldBorderWidth;
        _textFieldContentView.layer.borderColor = _textFieldBorderColor.CGColor;
        _textFieldTopConstraint.constant = -_contentViewSpace;
        [_textFieldContentView scott_addConstraintToView:textField edgeInset:UIEdgeInsetsMake(_textFieldBorderWidth, _textFieldEdge, -_textFieldBorderWidth, -_textFieldEdge)];
        [textField scott_addConstraintWidth:0 height:_textFieldHeight];
    }else {
        // textField
        UITextField *lastSecondTextField = _textFields[_textFields.count - 2];
        [_textFieldContentView scott_removeConstraintWithView:lastSecondTextField attribute:NSLayoutAttributeBottom];
        [_textFieldContentView scott_addConstraintWithTopView:lastSecondTextField toBottomView:textField constant:_textFieldBorderWidth];
        [_textFieldContentView scott_addConstraintWithView:textField topView:nil leftView:_textFieldContentView bottomView:_textFieldContentView rightView:_textFieldContentView edgeInset:UIEdgeInsetsMake(0, _textFieldEdge, -_textFieldBorderWidth, -_textFieldEdge)];
        [_textFieldContentView scott_addConstraintEqualWithView:textField widthToView:nil heightToView:lastSecondTextField];
        
        // separateview
        UIView *separateView = _textFieldSeparateViews[_textFields.count - 2];
        [_textFieldContentView scott_addConstraintWithView:separateView topView:nil leftView:_textFieldContentView bottomView:nil rightView:_textFieldContentView edgeInset:UIEdgeInsetsZero];
        [_textFieldContentView scott_addConstraintWithTopView:separateView toBottomView:textField constant:0];
        [separateView scott_addConstraintWidth:0 height:_textFieldBorderWidth];
    }
}

#pragma mark - action
- (void)actionButtonClicked:(UIButton *)button {
    ScottAlertAction *action = _actions[button.tag - kButtonTagOffset];
    
    [self dismiss];
    
    if (action.handler) {
        action.handler(action);
    }
}

@end
