//
//  RoomManager.m
//  zhibo
//
//  Created by qp on 2020/8/14.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RoomManager.h"
#import "RoomSocket.h"
@interface RoomManager ()<INetData>
@property (nonatomic, strong) RoomSocket *roomSocket;
@end
@implementation RoomManager
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.roomSocket = [[RoomSocket alloc] init];
        self.isAnchor = false;
        [UIApplication sharedApplication].idleTimerDisabled = true;
        [[UIApplication sharedApplication] addObserver:self forKeyPath:@"idleTimerDisabled"options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)enterRoomId:(NSInteger)roomId {
    self.roomid = roomId;
    [self.roomSocket startRoomWithID:roomId];
    [self fetchPostUri:URI_ROOM_INFO params:@{@"room_id":@(roomId)}];
    if (self.isAnchor) {
        [RoomContext shared].isForbidden = false;
        [RoomContext shared].isManager = true;
    }else{
        [self fetchPostUri:URI_ROOM_MANAGER params:@{@"room_id":@(roomId)}];
        [self fetchPostUri:URI_ROOM_BANSTATUS params:@{@"room_id":@(roomId)}];
    }
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void*)context{
    if ([UIApplication sharedApplication].idleTimerDisabled == false) {
        [UIApplication sharedApplication].idleTimerDisabled = YES;
    }
    
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    if ([req.uri isEqualToString:URI_ROOM_INFO]) { //房间信息
        [[ABMQ shared] publish:obj channel:CHANNEL_ROOM_INFO];
        self.anchorid = [obj[@"anchor"][@"UserId"] intValue];
//        self.roomInfo = obj;
//        if ([obj[@"room"][@"status"] intValue] == 0) {
//            [self.delegate roomPlayPresent:self closeWithData:obj];
//            return;
//        }
        
//        [[RoomContext shared].playControl receiveRoomInfo:self.roomInfo];
//        [[RoomContext shared].playView playURL:self.roomInfo[@"video"][@"pull"]];
    }
    else if ([req.uri isEqualToString:URI_ROOM_MANAGER]) {
        [RoomContext shared].isManager = true;
    }
    else if ([req.uri isEqualToString:URI_ROOM_BANSTATUS]) {
        [RoomContext shared].isForbidden = true;
    }
}

- (void)onNetRequestFailure:(ABNetRequest *)req err:(ABNetError *)err {
    if ([req.uri isEqualToString:URI_GAME_BET] || [req.uri isEqualToString:URI_GAME_UNBET]) {
        [ABUITips showError:err.message];
    }
    if ([req.uri isEqualToString:URI_FOLLOW_FOLLOW]) {
        [ABUITips showError:err.message];
    }
    if ([req.uri isEqualToString:URI_ROOM_MANAGER]) {
        [RoomContext shared].isManager = false;
    }
    if ([req.uri isEqualToString:URI_ROOM_BANSTATUS]) {
        [RoomContext shared].isForbidden = false;
    }
}


- (void)sendText:(NSString *)text {
    if ([text isEqualToString:@":gamesocket"]) {
        [NSRouter gotoXXXX];
        return;
    }
    [self.roomSocket sendText:text];
}

- (void)dealloc
{
    [[UIApplication sharedApplication] removeObserver:self forKeyPath:@"idleTimerDisabled"];

    [UIApplication sharedApplication].idleTimerDisabled = NO;
}
@end

