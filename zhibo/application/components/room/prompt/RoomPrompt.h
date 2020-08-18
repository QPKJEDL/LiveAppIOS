//
//  RoomPromptView.h
//  zhibo
//
//  Created by qp on 2020/7/14.
//  Copyright © 2020 qp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BetView.h"
NS_ASSUME_NONNULL_BEGIN
typedef void (^IndexBlock)(NSInteger index);
typedef void (^TitleBlock)(NSString *title);
typedef void (^GameBlock)(NSInteger gameid, NSInteger deskid, NSString *title);

#define RP [RoomPrompt shared]
@interface RoomPrompt : NSObject
+ (RoomPrompt *)shared;
@property (nonatomic, strong) BetView *betView;
/// 主播用户视图
- (void)promptAnchor;
/// 用户视图
- (void)promptUserWithUid:(NSInteger)uid;
/// 美颜
- (void)promptBeauty;
/// 话题
- (void)promptTopic:(TitleBlock)block;
/// 频道
- (void)promptChannels:(TitleBlock)block;
/// 礼物排行榜
- (void)promptGiftRank;
/// 游戏结果
- (void)promptGameResultWithGameId:(NSInteger)gameid winner:(id)winner;
- (void)promptGameBlock:(GameBlock)block;
/// 多功能
- (void)promptMoreActions:(IndexBlock)block;
/// 下注盘
- (void)promptBetView:(NSDictionary *)rules hideBlock:(nonnull ABUIPopupBlock)hideBlock showBlock:(nonnull ABUIPopupBlock)showBlock;
@end

NS_ASSUME_NONNULL_END
