//
//  LoginView.m
//  zhibo
//
//  Created by qp on 2020/7/1.
//  Copyright © 2020 qp. All rights reserved.
//

#import "LoginView.h"
@interface LoginView ()
@property (nonatomic, strong) ABUITextInput *accountInput;
@property (nonatomic, strong) ABUITextInput *passwordInput;

@property (nonatomic, strong) UIButton *switchButton;
@property (nonatomic, strong) UIButton *loginButton;

@property (nonatomic, strong) UIButton *rmButton;
@end
@implementation LoginView

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
        
        self.accountInput = [[ABUITextInput alloc] initWithFrame:CGRectMake(30, 23, self.width-60, 60)];
        self.accountInput.titleLabel.text = @"手机号";
        self.accountInput.textField.keyboardType = UIKeyboardTypeNumberPad;
        self.accountInput.textField.placeholder = @"请输入账号";
        self.accountInput.iconImageName = @"account";
        [self addSubview:self.accountInput];
        [self.accountInput addLineDirection:LineDirectionBottom color:[UIColor colorWithRed:228/255.0 green:227/255.0 blue:228/255.0 alpha:1.0] width:1];
        
        
        self.passwordInput = [[ABUITextInput alloc] initWithFrame:CGRectMake(30, self.accountInput.bottom+23, self.width-60, 60)];
        self.passwordInput.titleLabel.text = @"密码";
        self.passwordInput.textField.placeholder = @"请输入密码";
        self.passwordInput.textField.secureTextEntry = true;
        self.passwordInput.iconImageName = @"pwd";
        [self addSubview:self.passwordInput];
        [self.passwordInput addLineDirection:LineDirectionBottom color:[UIColor colorWithRed:228/255.0 green:227/255.0 blue:228/255.0 alpha:1.0] width:1];
        
        
        self.switchButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width-31-60, self.passwordInput.bottom, 60, 44)];
        [self.switchButton setTitle:@"短信登录" forState:UIControlStateNormal];
        [self.switchButton setTitleColor:[UIColor hexColor:@"#FF2B2B"] forState:UIControlStateNormal];
        self.switchButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [self.switchButton addTarget:self action:@selector(switchButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.switchButton];
        
        
        self.rmButton = [[UIButton alloc] initWithFrame:CGRectMake(30, self.passwordInput.bottom, 80, 44)];
        [self.rmButton setTitle:@" 记住密码" forState:UIControlStateNormal];
        self.rmButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.rmButton setTitleColor:[UIColor hexColor:@"#FF2B2B"] forState:UIControlStateNormal];
        self.rmButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [self.rmButton addTarget:self action:@selector(rmButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.rmButton setImage:[UIImage imageNamed:@"cb_xuan"] forState:UIControlStateNormal];
        [self.rmButton setImage:[UIImage imageNamed:@"cb_quan"] forState:UIControlStateSelected];
//        [self addSubview:self.rmButton];
        
        self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.passwordInput.bottom+64, 297, 44)];
        [self.loginButton setTitle:@"立即登录" forState:UIControlStateNormal];
        [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.loginButton.layer.cornerRadius = 20;
        self.loginButton.clipsToBounds = true;
        self.loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        self.loginButton.backgroundColor = [UIColor hexColor:@"FF2B2B"];
        [self addSubview:self.loginButton];
        [self.loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
        self.loginButton.centerX = self.width/2;
        
        NSString *account = [[Service shared] rememberAccount];
        NSString *password = [[Service shared] rememberPassword];
        if (account) {
            self.accountInput.text = account;
        }
        if (password) {
            self.passwordInput.text = password;
        }
    }
    return self;
}

- (void)switchButtonAction {
    [self.delegate loginViewOnChange:self];
}

- (void)rmButtonAction {
    self.rmButton.selected = !self.rmButton.selected;
}

- (void)loginButtonAction {
    if (self.accountInput.text.length == 0) {
        [ABUITips showError:@"请输入手机号"];
        return;
    }
    if (![ABTools isValidPhone:self.accountInput.text]) {
        [ABUITips showError:@"手机号不合法"];
        return;
    }
    if (self.passwordInput.text.length == 0) {
        [ABUITips showError:@"请输入密码"];
        return;
    }
    [self.delegate loginView:self onLoginUserName:self.accountInput.textField.text password:self.passwordInput.textField.text];
}

@end
