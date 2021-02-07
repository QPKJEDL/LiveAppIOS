//
//  EditLowerTeamFeeView.m
//  zhibo
//
//  Created by qp on 2021/2/7.
//  Copyright © 2021 qp. All rights reserved.
//

#import "EditLowerTeamFeeView.h"

@interface EditLowerTeamFeeView ()<INetData>
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *noteLabel;
@property (nonatomic, strong) UIButton *okButton;
@property (nonatomic, strong) UIButton *cancelButton;
@end
@implementation EditLowerTeamFeeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 44)];
        self.titleLabel.text = @"修改费率";
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor hexColor:@"222222"];
        self.titleLabel.font = [UIFont PingFangMedium:16];
        [self addSubview:self.titleLabel];
        [self.titleLabel addLineDirection:LineDirectionBottom color:[UIColor hexColor:@"f6f6f6"] width:LINGDIANWU];
        
        self.progressView = [[ZBProgressView alloc] initWithFrame:CGRectMake(15, self.titleLabel.bottom+10, self.width-30, 30)];
        self.progressView.progress = 0.5;
        self.progressView.maxValue = self.maxValue;
        [self addSubview:self.progressView];
        
        
        self.noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.progressView.bottom+10, self.width-30, 44)];
        self.noteLabel.text = @"修改规则:高于下级现有,低于自身5%";
        self.noteLabel.textAlignment = NSTextAlignmentLeft;
        self.noteLabel.textColor = [UIColor redColor];
        self.noteLabel.font = [UIFont PingFangMedium:13];
        [self addSubview:self.noteLabel];
        
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
        self.okButton.backgroundColor = [UIColor hexColor:@"#FF2A40"];
        [self.okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:self.okButton];
        self.okButton.layer.cornerRadius = 34/2;
        self.okButton.clipsToBounds = true;
        [self.okButton addTarget:self action:@selector(onOk) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


- (void)onOk {
    int fee = [self.progressView.cursorLabel.text intValue];
    [self fetchPostUri:URI_ACCOUNT_SavaFee params:@{@"touid":@(self.uid), @"fee":@(fee)}];
}
- (void)onCancel {
    [[ABUIPopUp shared] remove];
}

- (void)setMaxValue:(int)maxValue {
    _maxValue = maxValue;
    self.progressView.maxValue = maxValue;
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    [ABUITips showSucceed:@"修改成功"];
    [self.delegate onUpdateSuccessed];
    [[ABUIPopUp shared] remove];
}

- (void)onNetRequestFailure:(ABNetRequest *)req err:(ABNetError *)err {
    [ABUITips showError:err.message];
}

@end
