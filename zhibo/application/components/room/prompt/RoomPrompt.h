//
//  RoomPromptView.h
//  zhibo
//
//  Created by qp on 2020/7/14.
//  Copyright © 2020 qp. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^TitleBlock)(NSString * _Nullable title);
typedef void (^GameBlock)(NSInteger gameid, NSInteger deskid, NSString *title);

NS_ASSUME_NONNULL_BEGIN
#define RP [RoomPrompt shared]
@interface RoomPrompt : NSObject
+ (RoomPrompt *)shared;
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
@end

NS_ASSUME_NONNULL_END
