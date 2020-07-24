//
//  RoomPresent.h
//  zhibo
//
//  Created by qp on 2020/7/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//@class RoomPresent;
//@protocol RoomPresentDelegate <NSObject>
//
//- (void)present:(RoomPresent *)present onReceiveRoomInfo:(NSDictionary *)info;
//- (void)present:(RoomPresent *)present onReceiveCommentList:(NSArray *)commentList;
//- (void)present:(RoomPresent *)present onBetGameInfo:(NSDictionary *)gameInfo;
//- (void)present:(RoomPresent *)present onBetSuccess:(NSDictionary *)info;

//@end
@interface RoomPresent : NSObject
//@property (nonatomic, weak) id<RoomPresentDelegate> delegate;
@property (nonatomic, strong) NSDictionary *roomInfo;
//- (void)requestRoomInfo;
//- (void)onReceiveRoomInfo;
//
//- (void)followLiveWithUID:(NSInteger)uid;
//- (void)unfollowLiveWithUID:(NSInteger)uid;
//- (void)doBet:(NSDictionary *)betInfo;
//- (void)doBetCancel:(NSDictionary *)info;
@end

NS_ASSUME_NONNULL_END

