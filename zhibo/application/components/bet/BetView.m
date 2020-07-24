//
//  BetView.m
//  zhifu
//
//  Created by qp on 2020/6/22.
//  Copyright © 2020 qp. All rights reserved.
//

#import "BetView.h"
#import "BetCoinsView.h"
#import "BetOptionsView.h"
@interface BetView()<BetCoinsViewDelegate, BetOptionsViewDelegate>
@property (nonatomic, strong) BetCoinsView *coinsView;
@property (nonatomic, strong) BetOptionsView *optionsView;
@property (nonatomic, strong) UIButton *okButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) NSArray *coins;
@property (nonatomic, strong) NSArray *options;

@property (nonatomic, strong) NSDictionary *sounds;
@end

@implementation BetView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.coinsView = [[BetCoinsView alloc] initWithFrame:CGRectMake(10, 2, SCREEN_WIDTH-20, 55)];
        self.coinsView.delegate = self;
        [self addSubview:self.coinsView];
        
        self.optionsView = [[BetOptionsView alloc] initWithFrame:CGRectMake(10, self.coinsView.bottom, SCREEN_WIDTH-70, 100)];
        self.optionsView.delegate = self;
        [self addSubview:self.optionsView];
        
        self.okButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [self.okButton setTitle:@"确定" forState:UIControlStateNormal];
        self.okButton.titleLabel.font = [UIFont systemFontOfSize:10];
        [self.okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.okButton setBackgroundColor:[UIColor hexColor:@"11605C"]];
        [self addSubview:self.okButton];
        self.okButton.top = self.optionsView.top;
        self.okButton.left = self.width-10-self.okButton.width;
        self.okButton.layer.cornerRadius = 15;
        self.okButton.clipsToBounds = true;
        [self.okButton addTarget:self action:@selector(onConfirm) forControlEvents:UIControlEventTouchUpInside];
        
        
        self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancelButton setBackgroundColor:[UIColor hexColor:@"11605C"]];
        self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:10];
        [self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:self.cancelButton];
        self.cancelButton.top = self.okButton.bottom+6;
        self.cancelButton.left = self.width-10-self.cancelButton.width;
        self.cancelButton.layer.cornerRadius = 15;
        self.cancelButton.clipsToBounds = true;
        [self.cancelButton addTarget:self action:@selector(onCancel) forControlEvents:UIControlEventTouchUpInside];
        
        self.tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 54, 23)];
        self.tipLabel.layer.borderColor = [UIColor whiteColor].CGColor;
        self.tipLabel.textAlignment = NSTextAlignmentCenter;
        [self.tipLabel setTextColor:[UIColor whiteColor]];
        self.tipLabel.font = [UIFont systemFontOfSize:8];
        self.tipLabel.layer.borderWidth = 1;
        self.tipLabel.layer.cornerRadius = 23/2;
        self.tipLabel.numberOfLines = 2;
        [self addSubview:self.tipLabel];
        self.tipLabel.top = self.cancelButton.bottom+6;
        self.tipLabel.left = self.width-self.tipLabel.width;
        
        self.enabled = false;
        
    }
    return self;
}

- (void)setEnabled:(BOOL)enabled {
    _enabled = enabled;
    if (enabled) {
        [self.okButton setHidden:false];
        [self.cancelButton setHidden:false];
        [self.tipLabel setHidden:false];
    }else{
        [self.okButton setHidden:true];
        [self.cancelButton setHidden:true];
        [self.tipLabel setHidden:true];
        
    }
}

#pragma mark --------- loc action ----------
- (void)onConfirm {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (int i=0; i<self.options.count; i++) {
        NSString *opid = self.options[i][@"id"];
        if (self.options[i][@"num"] == nil) {
            params[opid] = @"0";
        }else{
            
            NSString *betNum = [NSString stringWithFormat:@"%@", self.options[i][@"num"]];
            params[opid] = betNum;
        }
    }
//    [self.delegate ]
    if ([self.delegate respondsToSelector:@selector(betView:onConfirmWithData:)]) {
        [self.delegate betView:self onConfirmWithData:params];
    }
    
}

- (void)onCancel {
    //有筹码选中，说明存在筹码，清除之，否则请求服务器尝试取消最后一次下注
    if ([self selectCoin]) {
        [ABUITips showSucceed:@"取消下注成功"];
        [self reset];
    }else{
        [self.delegate betViewOnCancel:self];
    }
    
}

#pragma mark --------- reveice data ---------

- (void)setCoins:(NSArray *)coins options:(NSArray *)options sounds:(NSDictionary *)sounds limit:(NSString *)limit {
    self.coins = coins;
    self.options = options;
    self.sounds = sounds;
    [self.tipLabel setText:limit];
    
    [self _reload];
}

//重置未下注选择
- (void)resetUnBet {
    self.isBet = true;
    self.coins = [ABIteration iterationList:self.coins block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
        dic[@"selected"] = @(0);
        return dic;
    }];
    
    self.options = [ABIteration iterationList:self.options block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
        dic[@"selected"] = @(0);
        return dic;
    }];
    
    [self _reload];
}

//重置所有选择
- (void)reset {
    self.isBet = false;
    self.coins = [ABIteration iterationList:self.coins block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
        dic[@"selected"] = @(0);
        return dic;
    }];
    
    self.options = [ABIteration iterationList:self.options block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
        dic[@"num"] = @(0);
        dic[@"selected"] = @(0);
        return dic;
    }];
    
    [self _reload];
}

#pragma mark ----------- local action ----------
- (void)_reload {
    [self.coinsView reload:self.coins];
    [self.optionsView reload:self.options];
}

- (NSDictionary *)selectCoin {
    for (NSDictionary *item in self.coins) {
        if ([item[@"selected"] intValue] == 1) {
            return item;
        }
    }
    return nil;
}


#pragma mark ------------ delegates -----------
- (void)betCoinsView:(BetCoinsView *)betCoinsView didSelectItemAtIndex:(NSInteger)index {
    if (self.enabled == false) {
        [ABUITips showError:@"下注时间已过"];
        [[ABAudio shared] playBundleFileWithName:@"bet_failed.mp3"];
        return;
    }
    
    self.coins = [ABIteration iterationList:self.coins block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
        dic[@"selected"] = @(0);
        if (index == idx) {
            dic[@"selected"] = @(1);
        }
        return dic;
    }];
    
    [self.coinsView reload:self.coins];
}

- (void)betOptionsView:(BetOptionsView *)betOptionsView didSelectItemAtIndex:(NSInteger)index {
    if (self.enabled == false) {
        [ABUITips showError:@"下注时间已过"];
        [[ABAudio shared] playBundleFileWithName:@"bet_failed.mp3"];
        return;
    }
    
    NSDictionary *coinDic = [self selectCoin];
    if (coinDic == nil) {
        [ABUITips showError:@"请选择筹码"];
        return;
    }
    
    NSInteger selectCoinNum = [coinDic[@"num"] integerValue];
    self.options = [ABIteration iterationList:self.options block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
        if (index == idx) {
            dic[@"num"] = dic[@"num"]?@(selectCoinNum+[dic[@"num"] integerValue]):@(selectCoinNum);
            dic[@"selected"] = @(1);
        }else{
            dic[@"selected"] = @(0);
        }
        return dic;
    }];

    [self.optionsView reload:self.options];
}

- (void)winner:(id)data {
    NSInteger n = 0;
    if ([data isKindOfClass:[NSNumber class]]) {
        n = [data integerValue];
    }
    if ([data isKindOfClass:[NSString class]]) {
        n = [[(NSString *)data toDictionary][@"game"] integerValue];
    }
    
    NSString *fileName = self.sounds[[NSString stringWithFormat:@"%li", (long)n]];
    [[ABAudio shared] playBundleFileWithName:fileName];
    self.options = [ABIteration iterationList:self.options block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
        NSInteger r = [dic[@"r"] integerValue];
        dic[@"selected"] = @(0);
        if (r == n) {
            dic[@"selected"] = @(1);
        }
        return dic;
    }];
    
    [self.optionsView reload:self.options];
}

@end
