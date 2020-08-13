//
//  BetView.h
//  zhifu
//
//  Created by qp on 2020/6/22.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class BetView;
@protocol BetViewDelegate <NSObject>

- (void)betView:(BetView *)betView onConfirmWithData:(NSDictionary *)data;
- (void)betViewOnCancel:(BetView *)betView;
@end

//0洗牌中1倒计时(开始下注)2开牌中(停止下注)3结算完成

typedef enum : NSInteger {
    PhaseStatusWatch,
    PhaseStatusStart,
    PhaseStatusWait,
    PhaseStatusFinish
} PhaseStatus;

@interface BetView : UIView

@property (nonatomic, weak) id<BetViewDelegate> delegate;
@property (nonatomic, assign) BOOL enabled; //是否可以下注
@property (nonatomic, assign) BOOL isBet; //是否已经下注
- (void)setCoins:(NSArray *)coins options:(NSArray *)options sounds:(NSDictionary *)sounds limit:(NSString *)limit;
- (void)resetUnBet;
- (void)reset;
- (void)winner:(id)data;
- (void)setBalance:(NSInteger)balnace;

@end

NS_ASSUME_NONNULL_END
