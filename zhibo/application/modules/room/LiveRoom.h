//
//  LiveRoom.h
//  zhibo
//
//  Created by qp on 2020/8/13.
//  Copyright © 2020 qp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class LiveRoom;

@protocol RoomControlProtocol <NSObject>

- (void)onReceiveRoomInfo:(NSDictionary *)roomInfo;

@end

@protocol LiveRoomDelegate <NSObject>
- (void)liveRoom:(LiveRoom *)liveRoom onRoomInfo:(NSDictionary *)roomInfo;
@end
@interface LiveRoom : NSObject
@property (nonatomic, weak) id<RoomControlProtocol> control;
//@property (nonatomic, weak) id<LiveRoomDelegate> delegate;
//请求房间信息
- (void)requestRoomInfo:(NSInteger)roomId;
//请求房间台桌信息
- (void)requestRoomDeskInfo:(NSInteger)roomId;
@end

NS_ASSUME_NONNULL_END
