//
//  RegisterView.m
//  zhibo
//
//  Created by qp on 2020/7/1.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RegisterView.h"

@interface RegisterView ()
@property (nonatomic, strong) ABUITextInput *accountInput;
@property (nonatomic, strong) ABUITextInput *nickNameInput;
@property (nonatomic, strong) ABUITextInput *passwordInput;
@property (nonatomic, strong) ABUITextInput *repasswordInput;

@property (nonatomic, strong) UIButton *loginButton;
@end
@implementation RegisterView

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
        
        self.accountInput = [[ABUITextInput alloc] initWithFrame:CGRectMake(30, 15, self.width-60, 60)];
        self.accountInput.titleLabel.text = @"手机号";
        self.accountInput.textField.placeholder = @"请输入手机号";
        self.accountInput.textField.keyboardType = UIKeyboardTypeNumberPad;
        self.accountInput.iconImageName = @"account";
        [self addSubview:self.accountInput];
        [self.accountInput addLineDirection:LineDirectionBottom color:[UIColor colorWithRed:228/255.0 green:227/255.0 blue:228/255.0 alpha:1.0] width:1];
        
        self.nickNameInput = [[ABUITextInput alloc] initWithFrame:CGRectMake(30, self.accountInput.bottom+15, self.width-60, 60)];
        self.nickNameInput.titleLabel.text = @"昵称";
        self.nickNameInput.textField.placeholder = @"请输入昵称";
        self.nickNameInput.iconImageName = @"nick";
        [self addSubview:self.nickNameInput];
        [self.nickNameInput addLineDirection:LineDirectionBottom color:[UIColor colorWithRed:228/255.0 green:227/255.0 blue:228/255.0 alpha:1.0] width:1];
        
        
        
        self.passwordInput = [[ABUITextInput alloc] initWithFrame:CGRectMake(30, self.nickNameInput.bottom+15, self.width-60, 60)];
        self.passwordInput.titleLabel.text = @"密码";
        self.passwordInput.textField.secureTextEntry = true;
        self.passwordInput.textField.placeholder = @"请输入密码";
        self.passwordInput.iconImageName = @"pwd";
        [self addSubview:self.passwordInput];
        [self.passwordInput addLineDirection:LineDirectionBottom color:[UIColor colorWithRed:228/255.0 green:227/255.0 blue:228/255.0 alpha:1.0] width:1];
        
        
        self.repasswordInput = [[ABUITextInput alloc] initWithFrame:CGRectMake(30, self.passwordInput.bottom+15, self.width-60, 60)];
        self.repasswordInput.titleLabel.text = @"确认密码";
        self.repasswordInput.textField.secureTextEntry = true;
        self.repasswordInput.textField.placeholder = @"再次输入密码";
        self.repasswordInput.iconImageName = @"pwd";
        [self addSubview:self.repasswordInput];
        [self.repasswordInput addLineDirection:LineDirectionBottom color:[UIColor colorWithRed:228/255.0 green:227/255.0 blue:228/255.0 alpha:1.0] width:1];
        
        
        self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.repasswordInput.bottom+36, self.width-88, 44)];
        [self.loginButton setTitle:@"注册并登录" forState:UIControlStateNormal];
        [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.loginButton.layer.cornerRadius = 20;
        self.loginButton.clipsToBounds = true;
        self.loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        self.loginButton.backgroundColor = [UIColor hexColor:@"FF2B2B"];
        [self addSubview:self.loginButton];
        [self.loginButton addTarget:self action:@selector(registerButtonAction) forControlEvents:UIControlEventTouchUpInside];
        self.loginButton.centerX = self.width/2;
        
//        self.accountInput.text = @"13888888888";
//        self.nickNameInput.text = @"小白菜";
//        self.passwordInput.text = @"123456";
//        self.repasswordInput.text = @"123456";
        
    }
    return self;
}

- (void)registerButtonAction {
    if (self.accountInput.text.length == 0) {
        [ABUITips showError:@"请输入手机号"];
        return;
    }
    if (![ABTools isValidPhone:self.accountInput.text]) {
        [ABUITips showError:@"手机号不合法"];
        return;
    }
    if (self.nickNameInput.text.length == 0) {
        [ABUITips showError:@"请输入昵称"];
        return;
    }
    if (self.passwordInput.text.length == 0) {
        [ABUITips showError:@"请输入密码"];
        return;
    }
    if ([self.passwordInput.text isEqualToString:self.repasswordInput.text]) {
        [self.delegate registerView:self onRegisterUserName:self.accountInput.text nickName:self.nickNameInput.text password:self.passwordInput.text];
    }else{
        [ABUITips showError:@"两次输入密码不一致"];
    }
    
}

@end
