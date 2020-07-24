//
//  RoomMessageHandle.m
//  zhibo
//
//  Created by qp on 2020/7/14.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RoomMessageHandle.h"

@implementation RoomMessageHandle
- (void)onRoomMessage:(RoomMessage *)rm  { //聊天
    [[ABMQ shared] publish:[rm.content toDictionary] channel:@"CHANNEL_ROOM_CHAT"];
}

- (void)onPeerMessage:(IMMessage *)msg { //游戏事件
    [[ABMQ shared] publish:[msg.content toDictionary] channel:@"CHANNEL_ROOM_CHAT"];
}
@end
