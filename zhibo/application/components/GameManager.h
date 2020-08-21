//
//  GameManager.h
//  zhibo
//
//  Created by qp on 2020/7/20.
//  Copyright © 2020 qp. All rights reserved.
//  监听消息做处理

#import <Foundation/Foundation.h>
#import "RoomControl.h"
#import "BetView.h"
#import "RoomPlayView.h"
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

@protocol GameManagerProtocol <NSObject>


@end

@interface GameManager : NSObject
@property (nonatomic, strong) NSDictionary *rules;//游戏规则视图
@property (nonatomic, assign) NSInteger desk_id;
@property (nonatomic, assign) NSInteger game_id;
@property (nonatomic, assign) NSInteger room_id;
@property (nonatomic, assign) NSInteger boot_num;
@property (nonatomic, strong) NSString *DeskName;
@property (nonatomic, weak) RoomControl *control;
@property (nonatomic, weak) BetView *betView;
@property (nonatomic, weak) RoomPlayView *shixunPlayerView;
@property (nonatomic, strong) NSString *shixunPlayAddress;

@property (nonatomic, strong) NSString *tipStr;
@property (nonatomic, strong) NSString *atipStr;
// 设置游戏
- (void)enterRoomId:(NSInteger)roomId;

- (void)refreshBalance;

- (void)_refreshDeskInfo;
- (void)refresh;

- (void)doBet:(NSDictionary *)data;
- (void)doBetCancel;
@end

NS_ASSUME_NONNULL_END
