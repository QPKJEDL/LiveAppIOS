//
//  JnPasswordView.m
//  New_Patient
//
//  Created by Jn_Kindle on 2018/5/28.
//  Copyright © 2018年 新开元 iOS. All rights reserved.
//

//布局配置
#define JnScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define JnScreenHeight [[UIScreen mainScreen] bounds].size.height
#define JnScreenPercentage JnScreenWidth / 375 //尺寸比例（以iphone6 750 X 1334 为基础）



#define JnPwdWidth 315*JnScreenPercentage  //密码输入视图的宽
#define JnPwdHeight 179*JnScreenPercentage //密码输入视图的高


#define JnDotCount 6  //密码个数
#define JnDotSize CGSizeMake (10, 10) //密码点的大小
#define Jn_Field_Width 291*JnScreenPercentage  //输入框的宽度
#define Jn_Field_Height 44*JnScreenPercentage  //输入框的高度


//线条颜色
#define Jn_DefaultLineColor [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]

#import "JnPasswordView.h"

@interface JnPasswordView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIWindow *window;

@property (nonatomic, weak) UIView *maskingView;

@property (nonatomic, weak) UIView *pwdView;
@property (nonatomic, weak) UITextField *textField;

@property (nonatomic, strong) NSMutableArray *dotArray; //用于存放黑色的点点


@property (nonatomic, weak) UIButton *cancelButton;
@property (nonatomic, weak) UIButton *certainButton;


@end

@implementation JnPasswordView

+ (instancetype)sharedInstance {
    static JnPasswordView *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [JnPasswordView new];
    });
    return instance;
}


-(void)setInputPwdBlock:(InputPwdBlock)inputPwdBlock
{
    _inputPwdBlock = inputPwdBlock;
}

-(void)setCancelBlock:(CancelBlock)cancelBlock
{
    _cancelBlock = cancelBlock;
}

-(void)setCertainBlock:(CertainBlock)certainBlock
{
    _certainBlock = certainBlock;
}


- (void)initPwdUI
{
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    [self maskingView];
    
    [self pwdView];
    [self titleLabel];
    [self textField];
    
    [self initPwdTextField];
    
    [self cancelButton];
    [self certainButton];
    
    //添加出现动画
    [self addAppearAnimation];
    
    //[self.textField becomeFirstResponder];
    
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    NSLog(@"%d",height);
    
    if (height == 0) {
        return;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        self.pwdView.frame = CGRectMake((JnScreenWidth-JnPwdWidth)/2, JnScreenHeight-height-80.0*JnScreenPercentage-JnPwdHeight, JnPwdWidth, JnPwdHeight);
    }];
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    [UIView animateWithDuration:0.2 animations:^{
        self.pwdView.frame = CGRectMake((JnScreenWidth-JnPwdWidth)/2, (JnScreenHeight-JnPwdHeight)/2, JnPwdWidth, JnPwdHeight);
    }];
}

- (void)initPwdTextField
{
    
    //每个密码输入框的宽度
    CGFloat width = Jn_Field_Width / JnDotCount;
    
    //生成分割线
    for (int i = 0; i < JnDotCount - 1; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.textField.frame) + (i + 1) * width, CGRectGetMinY(self.textField.frame), 1, Jn_Field_Height)];
        lineView.backgroundColor = Jn_DefaultLineColor;
        [self.pwdView addSubview:lineView];
    }
    
    self.dotArray = [[NSMutableArray alloc] init];
    //生成中间的点
    for (int i = 0; i < JnDotCount; i++) {
        UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.textField.frame) + (width - JnDotCount) / 2 + i * width, CGRectGetMinY(self.textField.frame) + (Jn_Field_Height - JnDotSize.height) / 2, JnDotSize.width, JnDotSize.height)];
        dotView.backgroundColor = [UIColor blackColor];
        dotView.layer.cornerRadius = JnDotSize.width / 2.0f;
        dotView.clipsToBounds = YES;
        dotView.hidden = YES; //先隐藏
        [self.pwdView addSubview:dotView];
        //把创建的黑色点加入到数组中
        [self.dotArray addObject:dotView];
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"变化%@", string);
    if([string isEqualToString:@"\n"]) {
        //按回车关闭键盘
        [textField resignFirstResponder];
        return NO;
    } else if(string.length == 0) {
        //判断是不是删除键
        
        return YES;
    }else if(textField.text.length >= JnDotCount) {
        //输入的字符个数大于6，则无法继续输入，返回NO表示禁止输入
        //NSLog(@"输入的字符个数大于6，忽略输入");
        return NO;
    } else {
        return YES;
    }
}

/**
 *  重置显示的点
 */
- (void)textFieldDidChange:(UITextField *)textField
{
    NSLog(@"%@", textField.text);
    //handle
    if (_inputPwdBlock) {
        _inputPwdBlock(textField.text);
    }
    
    for (UIView *dotView in self.dotArray) {
        dotView.hidden = YES;
    }
    for (int i = 0; i < textField.text.length; i++) {
        ((UIView *)[self.dotArray objectAtIndex:i]).hidden = NO;
    }
    if (textField.text.length == JnDotCount) {
        //NSLog(@"输入完毕");
    }
    
}




#pragma mark - init

-(UIWindow *)window
{
    if (!_window) {
        _window = [UIApplication sharedApplication].keyWindow;
    }
    return _window;
}

-(UIView *)maskingView
{
    if (!_maskingView) {
        UIView *maskingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, JnScreenWidth, JnScreenHeight)];
        maskingView.backgroundColor = [UIColor blackColor];
        maskingView.alpha = 0.0;
        [self.window addSubview:maskingView];
        
        //添加手势
        maskingView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskingViewHandleTap:)];
        tapGesture.numberOfTapsRequired = 1;
        tapGesture.numberOfTouchesRequired = 1;
        [maskingView addGestureRecognizer:tapGesture];
        
        _maskingView = maskingView;
    }
    return _maskingView;
}

-(UIView *)pwdView
{
    if (!_pwdView) {
        UIView *pwdView = [[UIView alloc] init];
        //pwdView.size = CGSizeMake(JnPwdWidth, JnPwdHeight);
        //pwdView.size = CGSizeMake(0, 0);
        //pwdView.center = CGPointMake(JnScreenWidth/2, JnScreenHeight/2);
        pwdView.frame =  CGRectMake((JnScreenWidth-JnPwdWidth)/2, (JnScreenHeight-JnPwdHeight)/2, JnPwdWidth, JnPwdHeight);
        pwdView.backgroundColor = [UIColor whiteColor];
        [self.window addSubview:pwdView];
        [self setRoundWithView:pwdView cornerRadius:8*JnScreenPercentage];
        _pwdView = pwdView;
    }
    return _pwdView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20*JnScreenPercentage, JnPwdWidth, 20*JnScreenPercentage)];
        titleLabel.text = @"请输入支付密码";
        titleLabel.font = [UIFont systemFontOfSize:16.0*JnScreenPercentage];
        titleLabel.textColor = [self colorWithHexString:@"#333333"];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.numberOfLines = 0;
        [self.pwdView addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

- (UITextField *)textField
{
    if (!_textField) {
        UITextField *textField = [[UITextField alloc] init];
        textField.frame = CGRectMake((JnPwdWidth-Jn_Field_Width)/2, (JnPwdHeight-Jn_Field_Height)/2, Jn_Field_Width, Jn_Field_Height);
        textField.backgroundColor = [UIColor whiteColor];
        //输入的文字颜色为白色
        textField.textColor = [UIColor whiteColor];
        //输入框光标的颜色为白色
        textField.tintColor = [UIColor whiteColor];
        textField.delegate = self;
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.layer.borderColor = [Jn_DefaultLineColor CGColor];
        textField.layer.borderWidth = 1;
        [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self.pwdView addSubview:textField];
        _textField = textField;
    }
    return _textField;
}

-(UIButton *)cancelButton
{
    if (!_cancelButton) {
        UIButton *cancelButton = [[UIButton alloc] init];
        cancelButton.frame = CGRectMake(0, JnPwdHeight-40.0*JnScreenPercentage, JnPwdWidth/2, 40.0*JnScreenPercentage);
        
        //cancelButton.backgroundColor = [UIColor colorWithHexString:@"#4086FF"];
        //设置边框
        [self setBorderWithView:cancelButton width:0.5 color:Jn_DefaultLineColor];
        
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitle:@"取消" forState:UIControlStateHighlighted];
        [cancelButton setTitleColor:[self colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [cancelButton setTitleColor:[self colorWithHexString:@"#999999"] forState:UIControlStateHighlighted];
        
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:15.0*JnScreenPercentage];
        
        [cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.pwdView addSubview: cancelButton];
        
        _cancelButton = cancelButton;
    }
    return _cancelButton;
}

-(UIButton *)certainButton
{
    if (!_certainButton) {
        UIButton *certainButton = [[UIButton alloc] init];
        certainButton.frame = CGRectMake(JnPwdWidth/2, JnPwdHeight-40.0*JnScreenPercentage, JnPwdWidth/2, 40.0*JnScreenPercentage);
        
        //certainButton.backgroundColor = [UIColor colorWithHexString:@"#4086FF"];
        //设置边框
        [self setBorderWithView:certainButton width:0.5 color:Jn_DefaultLineColor];
        
        [certainButton setTitle:@"确认" forState:UIControlStateNormal];
        [certainButton setTitle:@"确认" forState:UIControlStateHighlighted];
        [certainButton setTitleColor:[self colorWithHexString:@"#528DF0"] forState:UIControlStateNormal];
        [certainButton setTitleColor:[self colorWithHexString:@"#528DF0"] forState:UIControlStateHighlighted];
        
        certainButton.titleLabel.font = [UIFont systemFontOfSize:15.0*JnScreenPercentage];
        
        [certainButton addTarget:self action:@selector(certainButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.pwdView addSubview: certainButton];
        _certainButton = certainButton;
    }
    return _certainButton;
}


#pragma mark - Action
/**
 切圆角
 
 @param cornerRadius 圆角半径
 */
- (void)setRoundWithView:(UIView *)view cornerRadius:(float)cornerRadius
{
    view.layer.cornerRadius = cornerRadius;
    view.layer.masksToBounds = YES;
}

/**
 设置边宽
 
 @param borderWidth 边宽宽度
 @param borderColor 边宽颜色
 */
- (void)setBorderWithView:(UIView *)view width:(float)borderWidth color:(UIColor *)borderColor
{
    view.layer.borderWidth = borderWidth;
    view.layer.borderColor = borderColor.CGColor;
}




/**
  显示密码输入视图

 @param inputPwdBlock 输入handle
 @param cancelBlock 取消
 @param certainBlock 确认
 */
- (void)showPasswordViewWithInputPwd:(InputPwdBlock)inputPwdBlock
                              cancel:(CancelBlock)cancelBlock
                             certain:(CertainBlock)certainBlock
{
    [self setInputPwdBlock:inputPwdBlock];
    [self setCancelBlock:cancelBlock];
    [self setCertainBlock:certainBlock];
    
    [self initPwdUI];
    
    [self.textField becomeFirstResponder];
    
}

/**
 蒙版点击
 
 @param tap tap description
 */
- (void)maskingViewHandleTap:(UITapGestureRecognizer *)tap
{
    //[self dismissPasswordView];
    [self.textField resignFirstResponder];
}


/**
 销毁
 */
- (void)dismissPasswordView
{
    [self.textField resignFirstResponder];
    [self removeObserver];
    
    for (UIView *subView in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([subView isEqual:_pwdView] || [subView isEqual:_maskingView]) {
            [subView removeFromSuperview];
        }
    }
}


/**
 取消点击

 @param sender sender description
 */
- (void)cancelButtonClick:(UIButton *)sender
{
    if (_cancelBlock) {
        _cancelBlock();
    }
    
    
    
    [self dismissPasswordView];
}


/**
 确认点击

 @param sender sender description
 */
- (void)certainButtonClick:(UIButton *)sender
{
    if (_certainBlock) {
        _certainBlock();
    }
    
}


/**
 添加出现动画
 */
- (void)addAppearAnimation
{
    CFTimeInterval dutation = 0.1;
    
    //执行动画
    [UIView animateWithDuration:dutation animations:^{
        //蒙版
        self.maskingView.alpha = 0.5;
    }];
    
    //密码视图
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = dutation;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95, 0.95, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05, 1.05, 1.0)]];
    //[values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95, 0.95, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [self.pwdView.layer addAnimation:animation forKey:nil];
    
}

-(void)removeObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (UIColor *)colorWithHexString:(NSString *)color
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    //适配新方法
    return [self colorwithR:r G:g B:b alpha:1.0];
}

- (UIColor *)colorwithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b alpha:(CGFloat)alpha{
    if (@available(iOS 10.0, *)) {
        return [UIColor colorWithDisplayP3Red:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
    } else {
        // Fallback on earlier versions
        return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
    }
}


@end
