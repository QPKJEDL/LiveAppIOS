//
//  WalletViewTopView.m
//  zhibo
//
//  Created by FaiWong on 2020/4/25.
//  Copyright © 2020 qp. All rights reserved.
//

#import "WalletViewTopView.h"
#import "BalanceView.h"
@interface WalletViewTopView ()
@property (nonatomic, strong) BalanceView *balanceView;
@property (nonatomic, strong) UILabel *zhiboDouLabel;
@property (nonatomic, strong) UILabel *zhiboBiLabel;
@property (nonatomic, strong) UILabel *zhiboDouTextLabel;
@property (nonatomic, strong) UILabel *zhiboBiTextLabel;

//@property (nonatomic, strong) UIButton *cashoutButton;
//@property (nonatomic, strong) UIButton *rechargeButton;
@end
@implementation WalletViewTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor hexColor:@"FF2A40"];
        
        self.zhiboDouLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SYS_STATUSBAR_HEIGHT+80, self.width/2, 20)];
        [self.zhiboDouLabel setFont:[UIFont PingFangSCBlod:24]];
        self.zhiboDouLabel.textAlignment = NSTextAlignmentCenter;
        self.zhiboDouLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.zhiboDouLabel];
        
        
        self.zhiboBiLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.zhiboDouLabel.right, SYS_STATUSBAR_HEIGHT+80, self.width/2, 20)];
        [self.zhiboBiLabel setFont:[UIFont PingFangSCBlod:24]];
        self.zhiboBiLabel.textAlignment = NSTextAlignmentCenter;
        self.zhiboBiLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.zhiboBiLabel];
        

        
        self.zhiboDouTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.zhiboDouLabel.bottom+24, self.width/2, 20)];
        [self.zhiboDouTextLabel setFont:[UIFont PingFangSCBlod:15]];
        self.zhiboDouTextLabel.textAlignment = NSTextAlignmentCenter;
        self.zhiboDouTextLabel.textColor = [UIColor whiteColor];
        self.zhiboDouTextLabel.text = @"直播豆";
        [self addSubview:self.zhiboDouTextLabel];
            
        
        self.zhiboBiTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.zhiboDouLabel.right, self.zhiboDouLabel.bottom+24, self.width/2, 20)];
        [self.zhiboBiTextLabel setFont:[UIFont PingFangSCBlod:15]];
        self.zhiboBiTextLabel.textAlignment = NSTextAlignmentCenter;
        self.zhiboBiTextLabel.textColor = [UIColor whiteColor];
        self.zhiboBiTextLabel.text = @"直播币";
        [self addSubview:self.zhiboBiTextLabel];
        
        self.zhiboDouLabel.text = @"0";
        self.zhiboBiLabel.text = @"0";
            
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 86+SYS_STATUSBAR_HEIGHT, 1, 60)];
        lineView.backgroundColor = [UIColor whiteColor];
        [self addSubview:lineView];
        lineView.centerX = self.width/2;
        
        
        
        self.zhiboDouTextLabel.text = @"直播豆";
        self.zhiboBiTextLabel.text = @"直播币";
//        self.balanceView = [[BalanceView alloc] initWithFrame:CGRectMake(15, 25, SCREEN_WIDTH-30, 124)];
//        [self addSubview:self.balanceView];
//
        _cashoutButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.zhiboBiTextLabel.bottom+54, 122, 46)];
        [_cashoutButton setTitle:@"提现" forState:UIControlStateNormal];
        [_cashoutButton setTitleColor:[UIColor hexColor:@"ffffff"] forState:UIControlStateNormal];
        _cashoutButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _cashoutButton.layer.cornerRadius = 23;
        [_cashoutButton borderWidth:1 color:[UIColor whiteColor]];
        [self addSubview:_cashoutButton];


        _rechargeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.zhiboBiTextLabel.bottom+54, 122, 46)];
        [_rechargeButton setTitle:@"充值" forState:UIControlStateNormal];
        _rechargeButton.backgroundColor = [UIColor hexColor:@"ffffff"];
        [_rechargeButton setTitleColor:[UIColor hexColor:@"#FF2A40"] forState:UIControlStateNormal];
        _rechargeButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _rechargeButton.layer.cornerRadius = 23;
        [self addSubview:_rechargeButton];
        
    }
    return self;
}

- (void)reload:(NSDictionary *)data {
//    [self.balanceView reload:data];
    self.zhiboDouLabel.text = [NSString stringWithFormat:@"%@", data[@"info"]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.cashoutButton.left = self.width/2-22-self.cashoutButton.width;
    self.rechargeButton.left = self.width/2+22;
    
//    self.cashoutButton.top = self.balanceView.bottom+30;
//    self.rechargeButton.top = self.balanceView.bottom+30;
}

@end
