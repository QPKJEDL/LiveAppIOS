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
#import "MoneyInPrompt.h"
@interface BetView()<BetCoinsViewDelegate, BetOptionsViewDelegate, IABMQSubscribe>
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) BetCoinsView *coinsView;
@property (nonatomic, strong) BetOptionsView *optionsView;
@property (nonatomic, strong) UIButton *okButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UILabel *balanceLabel;
@property (nonatomic, strong) NSArray *coins;
@property (nonatomic, strong) NSArray *options;

@property (nonatomic, strong) NSDictionary *sounds;

@property (nonatomic, strong) UIButton *wenluButton;
@property (nonatomic, strong) UIButton *zzButton;

@property (nonatomic, strong)NSString *tipStr;

@property (nonatomic, assign) BOOL isBetting;
@end

@implementation BetView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isBetting = false;
        self.mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, self.width, self.height-44)];
        self.mainView.backgroundColor = [UIColor redColor];
        self.mainView.backgroundColor = [[UIColor hexColor:@"#1B3F41"] colorWithAlphaComponent:0.4];
        [self addSubview:self.mainView];
        
        self.coinsView = [[BetCoinsView alloc] initWithFrame:CGRectMake(10, 2, SCREEN_WIDTH-20, 55)];
        self.coinsView.delegate = self;
        [self.mainView addSubview:self.coinsView];
        
        self.optionsView = [[BetOptionsView alloc] initWithFrame:CGRectMake(10, self.coinsView.bottom, SCREEN_WIDTH-70, 100)];
        self.optionsView.delegate = self;
        [self.mainView addSubview:self.optionsView];
        
        self.okButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 60, 40, 40)];
        [self.okButton setTitle:@"确定" forState:UIControlStateNormal];
        self.okButton.titleLabel.font = [UIFont systemFontOfSize:10];
        [self.okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.okButton setBackgroundColor:[UIColor hexColor:@"#FF2853"]];
        [self.mainView addSubview:self.okButton];
        self.okButton.left = self.width-10-self.okButton.width;
        self.okButton.layer.cornerRadius = 20;
//        self.okButton.clipsToBounds = true;
        [self.okButton addTarget:self action:@selector(onConfirm) forControlEvents:UIControlEventTouchUpInside];
        self.okButton.layer.shadowColor = [UIColor colorWithRed:94/255.0 green:124/255.0 blue:124/255.0 alpha:0.88].CGColor;
        self.okButton.layer.shadowOffset = CGSizeMake(0,1);
        self.okButton.layer.shadowOpacity = 1;
        self.okButton.layer.shadowRadius = 0;
        
        self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancelButton setBackgroundColor:[UIColor hexColor:@"#FFFFFF"]];
        self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:10];
        [self.cancelButton setTitleColor:[UIColor hexColor:@"#383733"] forState:UIControlStateNormal];
        [self.mainView addSubview:self.cancelButton];
        self.cancelButton.top = self.okButton.bottom+6;
        self.cancelButton.left = self.width-10-self.cancelButton.width;
        self.cancelButton.layer.cornerRadius = 20;
//        self.cancelButton.clipsToBounds = true;
        [self.cancelButton addTarget:self action:@selector(onCancel) forControlEvents:UIControlEventTouchUpInside];
        self.cancelButton.layer.shadowColor = [UIColor colorWithRed:94/255.0 green:124/255.0 blue:124/255.0 alpha:0.88].CGColor;
        self.cancelButton.layer.shadowOffset = CGSizeMake(0,1);
        self.cancelButton.layer.shadowOpacity = 1;
        self.cancelButton.layer.shadowRadius = 0;
        
        
        self.tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 60, 24)];
        self.tipLabel.backgroundColor = [[UIColor hexColor:@"#3C3C3C"] colorWithAlphaComponent:0.6];
        self.tipLabel.textAlignment = NSTextAlignmentCenter;
        [self.tipLabel setTextColor:[UIColor whiteColor]];
        self.tipLabel.font = [UIFont systemFontOfSize:9];
        self.tipLabel.layer.cornerRadius = 24/2;
        self.tipLabel.numberOfLines = 2;
        self.tipLabel.clipsToBounds = true;
        [self addSubview:self.tipLabel];
        self.tipLabel.centerY = 22;
        [self.tipLabel addTarget:self action:@selector(onTipAction) forControlEvents:UIControlEventTouchUpInside];
        
        self.balanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.tipLabel.right+2, 0, 60, 24)];
        self.balanceLabel.backgroundColor = [[UIColor hexColor:@"#3C3C3C"] colorWithAlphaComponent:0.6];
        self.balanceLabel.textAlignment = NSTextAlignmentCenter;
        [self.balanceLabel setTextColor:[UIColor whiteColor]];
        self.balanceLabel.font = [UIFont systemFontOfSize:9];
        self.balanceLabel.layer.cornerRadius = 24/2;
        self.balanceLabel.numberOfLines = 2;
        self.balanceLabel.clipsToBounds = true;
        [self addSubview:self.balanceLabel];
        self.balanceLabel.centerY = 22;
        
        
        self.wenluButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
        self.wenluButton.backgroundColor = self.tipLabel.backgroundColor;
        self.wenluButton.layer.cornerRadius = 32/2;
        self.wenluButton.clipsToBounds = true;
        [self.wenluButton setImage:[UIImage imageNamed:@"wenlu"] forState:UIControlStateNormal];
        [self addSubview:self.wenluButton];
        [self.wenluButton addTarget:self action:@selector(onWenLuButton) forControlEvents:UIControlEventTouchUpInside];
        self.wenluButton.centerY = 22;
        self.wenluButton.left = self.balanceLabel.right+10;
    
        
        self.enabled = false;
//        [[ABMQ shared] subscribe:self channels:@[CHANNEL_GAME_BALANCE] autoAck:true];
        
    }
    return self;
}


- (void)onTipAction {
    QMUIAlertAction *action1 = [QMUIAlertAction actionWithTitle:@"关闭" style:QMUIAlertActionStyleCancel handler:NULL];
    QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:@"限红" message:[NSString stringWithFormat:@"%@%@", RC.gameManager.atipStr, RC.gameManager.tipStr] preferredStyle:QMUIAlertControllerStyleAlert];
    [alertController addAction:action1];
    [alertController showWithAnimated:YES];
}

- (void)onWenLuButton {
//    [[RoomContext shared].playControl.wenluWebView setHidden:![RoomContext shared].playControl.wenluWebView.isHidden];
    [RC.gameManager.control.wenluWebView setHidden:!RC.gameManager.control.wenluWebView.isHidden];
}

- (void)setEnabled:(BOOL)enabled {
    _enabled = enabled;
    if (enabled) {
        [self.okButton setHidden:false];
        [self.cancelButton setHidden:false];
    }else{
        [self.okButton setHidden:true];
        [self.cancelButton setHidden:true];
    }
}

#pragma mark --------- loc action ----------
- (void)onConfirm {
    if (self.isBetting) {
        [ABUITips showError:@"正在下注"];
        return;
    }
    
    NSDictionary *coinDic = [self selectCoin];
    if (coinDic == nil) {
        [ABUITips showError:@"请选择筹码"];
        return;
    }
    
    BOOL isNoMoney = true;
    for (int i=0; i<self.options.count; i++) {
        NSDictionary *obj = self.options[i];
        if ([obj[@"cnum"] intValue] > 0) {
            isNoMoney = false;
            break;
        }
    }
    
    
    if (isNoMoney) {
        [ABUITips showError:@"请选择下注选项"];
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (int i=0; i<self.options.count; i++) {
        NSString *opid = self.options[i][@"id"];
        if (self.options[i][@"cnum"] == nil) {
            params[opid] = @"0";
        }else{
            
            NSString *betNum = [NSString stringWithFormat:@"%@", self.options[i][@"cnum"]];
            params[opid] = betNum;
        }
    }
    
    [self resetUnBet];

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
    self.isBetting = false;
    self.tipStr = limit;
    self.coins = coins;
    self.options = options;
    self.sounds = sounds;
    [self.tipLabel setText:@"限红 >"];
    
    [self _reload];
    
    [self.wenluButton setHidden:true];
    if (RC.gameManager.game_id == 1 || RC.gameManager.game_id == 2) {
        [self.wenluButton setHidden:false];
    }
    
    [[RoomContext shared].gameManager refreshBalance];
}

- (void)setBalance:(CGFloat)balnace {
    self.bb = balnace;
    self.balanceLabel.text = [NSString stringWithFormat:@"余额\n%.2f", balnace];
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

//重置未下注选择
- (void)timeEnd {
    self.isBet = true;
    self.coins = [ABIteration iterationList:self.coins block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
        dic[@"selected"] = @(0);
        return dic;
    }];
    
    self.options = [ABIteration iterationList:self.options block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
        NSInteger num = [dic[@"num"] intValue]-[dic[@"cnum"] intValue];
        if (num < 0) {
            num = 0;
        }
        dic[@"cnum"] = @(0);
        dic[@"num"] = @(num);
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
        dic[@"cnum"] = @(0);
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

- (void)betSuccess {
    [[ABAudio shared] playBundleFileWithName:@"bet_succeed.mp3"];
    self.isBet = true;
    self.isBetting = false;
    
    self.options = [ABIteration iterationList:self.options block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
        dic[@"cnum"] = @(0);
        dic[@"selected"] = @(0);
        return dic;
    }];
    
    [self _reload];
}

- (void)betFailure {
    self.isBetting = false;
    [[ABAudio shared] playBundleFileWithName:@"bet_failed.mp3"];
    self.options = [ABIteration iterationList:self.options block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
        NSInteger num = [dic[@"num"] intValue]-[dic[@"cnum"] intValue];
        if (num < 0) {
            num = 0;
        }
        dic[@"cnum"] = @(0);
        dic[@"num"] = @(num);
        dic[@"selected"] = @(0);
        return dic;
    }];
    
    [self _reload];
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
    
    [[ABAudio shared] playBundleFileWithName:@"raise.mp3"];
    
    NSInteger selectCoinNum = [coinDic[@"num"] integerValue];
    self.options = [ABIteration iterationList:self.options block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
        if (index == idx) {
            dic[@"num"] = dic[@"num"]?@(selectCoinNum+[dic[@"num"] integerValue]):@(selectCoinNum);
            dic[@"cnum"] = dic[@"cnum"]?@(selectCoinNum+[dic[@"cnum"] integerValue]):@(selectCoinNum);
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


- (void)abmq:(ABMQ *)abmq onReceiveMessage:(id)message channel:(NSString *)channel {
    if ([channel isEqualToString:CHANNEL_GAME_BALANCE]) {
        [self setBalance:[message[@"balance"] floatValue]];
    }
    if ([channel isEqualToString:CHANNEL_GAME_STATUS]) {
        NSDictionary *dic = (NSDictionary *)message;
        NSInteger status = [dic[@"status"] integerValue];
        NSDictionary *data = (NSDictionary *)message[@"data"];
        
        switch (status) {
            case 0: //洗牌中
                self.enabled = false; //禁止下注
                [self reset]; //重置下注盘
                break;
            case 1://开始下注
                self.enabled = true; //开启下注
//                [self showBetView]; //弹出下注UI
                [self reset]; //重置下注盘
                break;
            case 2://开牌中(停止下注)
                self.enabled = false;//禁止下注
                if (self.isBet == false) {
                    [self reset];
                }
                break;
            case 3://结算完成
                self.enabled = false;//禁止下注
                break;
            case 4://结算完成(有结果)
                self.enabled = false;//禁止下注
                
//                [RP promptGameResultWithGameId:self.gameid winner:desk[@"Winner"]];
//                [self showBetView];
//                [[RoomContext shared].playControl receiveWenLuItem:desk];
                
                break;
            default:
                break;
        }
        
    }
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
    self.isopen = false;
}


@end
