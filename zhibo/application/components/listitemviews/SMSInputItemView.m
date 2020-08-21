//
//  SMSInputItemView.m
//  zhibo
//
//  Created by qp on 2020/8/20.
//  Copyright © 2020 qp. All rights reserved.
//

#import "SMSInputItemView.h"
@interface SMSInputItemView ()<INetData>
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) QMUITextField *textField;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) ABCountDownButton *cbButton;

@property (nonatomic, assign) NSInteger smstype;
@end
@implementation SMSInputItemView

- (void)setupAdjustContents {
    self.containView = [[UIView alloc] initWithFrame:self.bounds];
    self.containView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.containView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = [UIColor hexColor:@"222222"];
    [self.containView addSubview:self.titleLabel];
    
    self.textField = [[QMUITextField alloc] initWithFrame:CGRectMake(114, 0, SCREEN_WIDTH-15-114, self.height)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged) name:UITextFieldTextDidChangeNotification object:nil];
    [self.containView addSubview:self.textField];
    
    self.cbButton = [[ABCountDownButton alloc] initWithFrame:CGRectMake(0, 0, 84, 34)];
    [self.cbButton setBackgroundColor:[UIColor hexColor:@"FF2B2B"]];
    [self.cbButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.cbButton.titleLabel.font = [UIFont systemFontOfSize:11];
    self.cbButton.layer.cornerRadius = 34/2;
    self.cbButton.clipsToBounds = true;
    [self.cbButton addTarget:self action:@selector(cbButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.containView addSubview:self.cbButton];
}

- (void)cbButtonAction {
    NSString *mobile = [Service shared].account.info[@"Account"];
    [ABUITips showLoading];
    [self fetchPostUri:URI_SMS_SEND params:@{@"mobile":mobile, @"type":@(self.smstype)}];
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    [ABUITips hideLoading];
    [self.cbButton startCountDownWithSecond:60];
    [ABUITips showSucceed:@"发送成功"];
}

- (void)onNetRequestFailure:(ABNetRequest *)req err:(ABNetError *)err {
    [ABUITips hideLoading];
    [ABUITips showError:err.des];
}

- (void)reload:(NSDictionary *)item {
    self.smstype = [item[@"smstype"] intValue];
    self.titleLabel.text = item[@"title"];
    [self.titleLabel sizeToFit];
    
    self.key = item[@"key"];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:item[@"placeholder"] attributes:
    @{NSForegroundColorAttributeName:[UIColor hexColor:@"cccccc"],
                 NSFontAttributeName:[UIFont systemFontOfSize:12]
         }];
    self.textField.attributedPlaceholder = attrString;
    if (item[@"value"] != nil) {
        self.textField.text = [NSString stringWithFormat:@"%@", [Service shared].account.bank[item[@"value"]]];
        if ([self.textField.text isEqualToString:@"0"]) {
            self.textField.text = @"";
        }
    }
    if (item[@"text"] != nil) {
        self.textField.text = item[@"text"];
        [[Stack shared] set:item[@"text"] key:item[@"key"]];
    }
    
    self.textField.textColor = [UIColor hexColor:@"222222"];
    [self.textField setEnabled:true];
    if (item[@"max"] != nil) {
        self.textField.maximumTextLength = [item[@"max"] intValue];
    }
    if ([item[@"disable"] isEqualToString:@"count"]) {
        if (self.textField.text.length > 0) {
            self.textField.textColor = [UIColor hexColor:@"999999"];
            [self.textField setEnabled:false];
        }
    }
    self.textField.keyboardType = UIKeyboardTypeDefault;
    if ([item[@"tt"] isEqualToString:@"number"]) {
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    [self textFieldChanged];
}

- (void)layoutAdjustContents {
    self.titleLabel.left = 15;
    self.titleLabel.centerY = self.height/2;
    
    self.cbButton.left = self.width-15-self.cbButton.width;
    self.cbButton.centerY = self.containView.height/2;
}

- (void)textFieldChanged {
    [[Stack shared] set:_textField.text key:self.key];
}

@end
