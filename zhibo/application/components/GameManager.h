//
//  GameManager.h
//  zhibo
//
//  Created by qp on 2020/7/20.
//  Copyright © 2020 qp. All rights reserved.
//  监听消息做处理

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    GAMESTAUTS_READY = 1, /// 洗牌中
    GAMESTAUTS_START = 2, /// 开始下注
    GAMESTAUTS_STOP  = 3, /// 停止下注，待开牌
    GAMESTAUTS_SETTLE  = 4, ///  结算完成
    GAMESTAUTS_RESULT  = 5, /// 游戏结果
} GAMESTATUS;

@class GameManager;
@protocol GameManagerPlugin <NSObject>

- (void)gameStatusChanged:(GAMESTATUS)status;

@end

@interface GameManager : NSObject
// 设置游戏
- (void)enterDeskId:(NSInteger)deskId;
@end

NS_ASSUME_NONNULL_END
