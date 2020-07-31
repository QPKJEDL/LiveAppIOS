//
//  RoomPushPresent.m
//  zhibo
//
//  Created by qp on 2020/7/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RoomPushPresent.h"
@interface RoomPushPresent ()<INetData>
@end
@implementation RoomPushPresent

- (void)requestRoomInfo {
    [self fetchPostUri:URI_ROOM_INFO params:@{@"room_id":@([RoomContext shared].roomid)}];
    [self fetchPostUri:URI_ROOM_GIFT params:nil];
    [self fetchPostUri:URI_ROOM_GAME params:@{@"room_id":@([RoomContext shared].roomid)}];
    [RoomContext shared].isManager = true;
    [RoomContext shared].isForbidden = false;
}

- (void)setcover:(NSString *)covername gameid:(NSInteger)gameid deskid:(NSInteger)deskid channel:(NSString *)channel {
    [self fetchPostUri:URI_ROOM_SETCOVER params:@{@"covername":covername, @"game_id":@(gameid), @"desk_id":@(deskid), @"channel":channel, @"label":channel}];
}

- (void)onNetRequestFailure:(ABNetRequest *)req err:(ABNetError *)err {
    [ABUITips showError:err.message];
}

- (void)onReceiveRoomInfo {
    
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    if ([req.uri isEqualToString:URI_ROOM_INFO]) { //房间信息
        self.roomInfo = obj;
        [RoomContext shared].anchorid = [obj[@"anchor"][@"UserId"] intValue];
        [[RoomContext shared].socket startRoomWithID:[RoomContext shared].roomid];
        [[RoomContext shared].pushControl receiveRoomInfo:self.roomInfo];
    }
    if ([req.uri isEqualToString:URI_ROOM_SETCOVER]){
        [RoomContext shared].roomid = [obj[@"list"][@"RoomId"] intValue];
        self.address = obj[@"list"][@"Push"];
        [self.delegate present:self startLive:self.address];
    }
    if ([req.uri isEqualToString:URI_ROOM_GAME]) {
        
    }
}

@end
