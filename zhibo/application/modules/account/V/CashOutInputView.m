//
//  CashOutInputView.m
//  zhibo
//
//  Created by qp on 2020/7/20.
//  Copyright © 2020 qp. All rights reserved.
//

#import "CashOutInputView.h"
@interface CashOutInputView ()<QMUITextFieldDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *accordLabel;
@property (nonatomic, strong) UIButton *allButton;
@property (nonatomic, strong) QMUILabel *noticeLabel;

@end
@implementation CashOutInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 0, self.width/2, 20)];
        self.titleLabel.text = @"提现金额";
        self.titleLabel.font = [UIFont PingFangSCBlod:15];
        self.titleLabel.textColor = [UIColor hexColor:@"#343434"];
        [self addSubview:self.titleLabel];

        
        self.allButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width-15-54, 0, 60, 20)];
        [self.allButton setTitleColor:[UIColor hexColor:@"#FF3483"] forState:UIControlStateNormal];
        self.allButton.titleLabel.font = [UIFont PingFangSC:14];
        [self.allButton setTitle:@"全部提现" forState:UIControlStateNormal];
        [self.allButton addTarget:self action:@selector(onall) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.allButton];
        
        
        _accordLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 32+14, 25, 30)];
        _accordLabel.textColor = [UIColor hexColor:@"#212121"];
        _accordLabel.text = @"¥";
        _accordLabel.font = [UIFont PingFangSC:40];
        [self addSubview:_accordLabel];
        
        _noticeLabel = [[QMUILabel alloc] initWithFrame:CGRectMake(0, self.height-23, self.width, 60)];
        _noticeLabel.textColor = [UIColor hexColor:@"#A8A8A8"];
        _noticeLabel.backgroundColor = [UIColor hexColor:@"#F7F8FA"];
        _noticeLabel.contentEdgeInsets = UIEdgeInsetsMake(0, 17, 0, 0);
        _noticeLabel.font = [UIFont PingFangSCBlod:12];
        _noticeLabel.numberOfLines = 0;
        [self addSubview:_noticeLabel];
        
        self.textField = [[QMUITextField alloc] initWithFrame:CGRectMake(60, 0, SCREEN_WIDTH-_accordLabel.right-15, 32)];
        self.textField.placeholder = @"请输入提现金额";
        self.textField.delegate = self;
        self.textField.keyboardType = UIKeyboardTypeDecimalPad;
        self.textField.tintColor = [UIColor hexColor:@"FF2A40"];
        [self addSubview:self.textField];
        self.textField.top = self.accordLabel.top;
    }
    return self;
}

- (void)recharge {
    self.titleLabel.text = @"充值金额";
    [self.allButton setHidden:true];
    self.textField.placeholder = @"请输入充值金额";
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    
}

- (void)onall {
    self.textField.text = [NSString stringWithFormat:@"%d", self.num];
}


- (void)setNoticeText:(NSString *)notice {
    self.noticeLabel.text = notice;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString * str = [NSString stringWithFormat:@"%@%@",textField.text,string];
    //匹配以0开头的数字
    NSPredicate * predicate0 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[0][0-9]+$"];
    //匹配两位小数、整数
    NSPredicate * predicate1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^(([1-9]{1}[0-9]*|[0])\.?[0-9]{0,2})$"];
    BOOL sucess = ![predicate0 evaluateWithObject:str] && [predicate1 evaluateWithObject:str] ? YES : NO;
    return sucess;
}

@end
