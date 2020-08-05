//
//  MoneyOutPrompt.m
//  zhibo
//
//  Created by qp on 2020/8/3.
//  Copyright © 2020 qp. All rights reserved.
//

#import "MoneyOutPrompt.h"

@interface MoneyOutPrompt ()<INetData>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *balanceLabel;
@property (nonatomic, strong) QMUITextField *textField;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *okButton;
@end
@implementation MoneyOutPrompt

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 40)];
        self.titleLabel.text = @"余额转出";
        self.titleLabel.textColor = [UIColor hexColor:@"474747"];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont PingFangSCBlod:16];
        [self addSubview:self.titleLabel];
        [self.titleLabel addLineDirection:LineDirectionBottom color:[UIColor hexColor:@"dedede"] width:LINGDIANWU];
        
        
        self.textField = [[QMUITextField alloc] initWithFrame:CGRectMake(15, self.titleLabel.bottom+10, self.width-30, 44)];
        [self.textField setPlaceholder:@"请输入金额"];
        self.textField.textColor = [UIColor hexColor:@"#474747"];
        self.textField.layer.cornerRadius = 5;
        self.textField.clipsToBounds = true;
        self.textField.font = [UIFont PingFangSC:14];
        self.textField.textInsets = UIEdgeInsetsMake(0, 10, 0, 10);
        self.textField.backgroundColor = [UIColor hexColor:@"#EFEFEF"];
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
        [self addSubview:self.textField];
        
        self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width/2-15-75, self.height-18-33, 75, 34)];
        [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        self.cancelButton.titleLabel.font = [UIFont PingFangSC:14];
        self.cancelButton.backgroundColor = [UIColor hexColor:@"#D9D9D9"];
        [self.cancelButton setTitleColor:[UIColor hexColor:@"#313131"] forState:UIControlStateNormal];
        [self addSubview:self.cancelButton];
        self.cancelButton.layer.cornerRadius = 34/2;
        self.cancelButton.clipsToBounds = true;
        [self.cancelButton addTarget:self action:@selector(onCancel) forControlEvents:UIControlEventTouchUpInside];
        
        self.okButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width/2+15, self.height-18-33, 75, 34)];
        [self.okButton setTitle:@"确定" forState:UIControlStateNormal];
        self.okButton.titleLabel.font = [UIFont PingFangSC:14];
        self.okButton.backgroundColor = [UIColor hexColor:@"#FF2828"];
        [self.okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:self.okButton];
        self.okButton.layer.cornerRadius = 34/2;
        self.okButton.clipsToBounds = true;
        [self.okButton addTarget:self action:@selector(onOk) forControlEvents:UIControlEventTouchUpInside];
        
        self.balanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15,self.textField.bottom+10 , self.width, 40)];
        self.balanceLabel.text = @"余额转入";
        self.balanceLabel.textColor = [UIColor hexColor:@"868687"];
        self.balanceLabel.textAlignment = NSTextAlignmentCenter;
        self.balanceLabel.font = [UIFont PingFangSC:14];
        [self addSubview:self.balanceLabel];
        
        
    }
    return self;
}

- (void)onCancel {
    [[ABUIPopUp shared] remove];
    
}

- (void)setBalance:(NSString *)text {
    self.balanceLabel.text = [NSString stringWithFormat:@"可用余额:%@", text];
    [self.balanceLabel sizeToFit];
}

- (void)onOk {
    [self fetchPostUri:URI_ACCOUNT_WITHDRAW params:@{@"money":self.textField.text}];
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    [ABUITips showError:@"转出成功"];
    [self onCancel];
    [[ABMQ shared] publish:@"" channel:@"refreshbalance"];
}

- (void)onNetRequestFailure:(ABNetRequest *)req err:(ABNetError *)err {
    [ABUITips showError:err.message];
}

- (void)removeFromSuperview {
    [self.textField resignFirstResponder];
    [super removeFromSuperview];
}

@end
