//
//  LoginPhoneView.m
//  zhibo
//
//  Created by qp on 2020/7/2.
//  Copyright © 2020 qp. All rights reserved.
//

#import "LoginPhoneView.h"
#import "ABUICodeInput.h"
@interface LoginPhoneView ()<ABUICodeInputDelegate, INetData>
@property (nonatomic, strong) ABUITextInput *phoneInput;
@property (nonatomic, strong) ABUICodeInput *codeInput;

@property (nonatomic, strong) UIButton *switchButton;
@property (nonatomic, strong) UIButton *loginButton;

@end
@implementation LoginPhoneView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        self.layer.shadowColor = [UIColor colorWithRed:85/255.0 green:100/255.0 blue:130/255.0 alpha:0.13].CGColor;
        self.layer.shadowOffset = CGSizeMake(0,1);
        self.layer.shadowOpacity = 1;
        self.layer.shadowRadius = 12;
        self.layer.cornerRadius = 12;
        
        self.phoneInput = [[ABUITextInput alloc] initWithFrame:CGRectMake(30, 23, self.width-60, 60)];
        self.phoneInput.titleLabel.text = @"手机号";
        self.phoneInput.textField.placeholder = @"请输入手机号";
        self.phoneInput.textField.keyboardType = UIKeyboardTypeNumberPad;
        self.phoneInput.iconImageName = @"phone";
        [self addSubview:self.phoneInput];
        [self.phoneInput addLineDirection:LineDirectionBottom color:[UIColor colorWithRed:228/255.0 green:227/255.0 blue:228/255.0 alpha:1.0] width:1];
        
        
        self.codeInput = [[ABUICodeInput alloc] initWithFrame:CGRectMake(30, self.phoneInput.bottom+23, self.width-60, 60)];
        self.codeInput.titleLabel.text = @"验证码";
        self.codeInput.textField.placeholder = @"请输入验证码";
        [self addSubview:self.codeInput];
        self.codeInput.delegate = self;
        [self.codeInput addLineDirection:LineDirectionBottom color:[UIColor colorWithRed:228/255.0 green:227/255.0 blue:228/255.0 alpha:1.0] width:1];
        
        
        self.switchButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width-31-60, self.codeInput.bottom, 60, 44)];
        [self.switchButton setTitle:@"密码登录" forState:UIControlStateNormal];
        [self.switchButton setTitleColor:[UIColor hexColor:@"#FF2B2B"] forState:UIControlStateNormal];
        self.switchButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [self.switchButton addTarget:self action:@selector(switchButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.switchButton];
        
        self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.codeInput.bottom+64, 297, 44)];
        [self.loginButton setTitle:@"立即登录" forState:UIControlStateNormal];
        [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.loginButton.layer.cornerRadius = 20;
        self.loginButton.clipsToBounds = true;
        self.loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        self.loginButton.backgroundColor = [UIColor hexColor:@"FF2B2B"];
        [self addSubview:self.loginButton];
        [self.loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
        self.loginButton.centerX = self.width/2;
        
    }
    return self;
}

- (void)switchButtonAction {

    [self.delegate loginPhoneViewOnChange:self];
}

- (void)codeinputOnSendCode:(ABUICodeInput *)codeinput {
    if (self.phoneInput.text.length == 0) {
        [ABUITips showError:@"请输入手机号"];
        return;
    }
    if (![ABTools isValidPhone:self.phoneInput.text]) {
        [ABUITips showError:@"手机号不合法"];
        return;
    }
    

    [self fetchPostUri:URI_SMS_SEND params:@{@"type":@0, @"mobile":self.phoneInput.text}];
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    [self.codeInput start];
    [ABUITips showError:@"发送成功"];
}

- (void)onNetRequestFailure:(ABNetRequest *)req err:(ABNetError *)err {
    [ABUITips showError:err.des];
}

- (void)loginButtonAction {
    
    if (self.phoneInput.text.length == 0) {
        [ABUITips showError:@"请输入手机号"];
        return;
    }
    if (![ABTools isValidPhone:self.phoneInput.text]) {
        [ABUITips showError:@"手机号不合法"];
        return;
    }
    if (self.codeInput.text.length == 0) {
        [ABUITips showError:@"请输入验证码"];
        return;
    }
    
    [self.delegate loginPhoneView:self onLoginPhone:self.phoneInput.textField.text code:self.codeInput.textField.text];
}

@end

