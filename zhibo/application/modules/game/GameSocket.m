//
//  GameSocket.m
//  zhibo
//
//  Created by qp on 2020/7/14.
//  Copyright © 2020 qp. All rights reserved.
//

#import "GameSocket.h"

@interface GameSocket ()<PeerMessageObserver, RoomMessageObserver, IABMQSubscribe>

@end
@implementation GameSocket

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
        self.imService = [[IMService alloc] init];
        self.imService.host = [Stack shared].game_wsurl;
        self.imService.port = [Stack shared].game_tcpport;
        self.imService.heartbeatHZ = 30;
        self.imService.deviceID = [Service shared].account.gmuid;
        self.imService.token = [Service shared].account.gmtoken;
        
//        [self.imService addPeerMessageObserver:self];
        if (self.imService.port == 23001) {
            self.imService.ssl = false;
        }
        
        self.roomID = -1;
        
        
        [[ABMQ shared] subscribe:self channel:CHANNEL_NET_REACHABLE autoAck:true];
        [[Service shared].appEventMQ subscribe:self channel:CHANNEL_APP_STATUS autoAck:true];
    }
    return self;
}

- (void)abmq:(ABMQ *)abmq onReceiveMessage:(id)message channel:(NSString *)channel {
    if ([channel isEqualToString:CHANNEL_NET_REACHABLE]) {
        [self applicationDidBecomeActive];
    }
    if ([channel isEqualToString:CHANNEL_APP_STATUS]) {
        if ([message isEqualToString:@"resign"]) {
            [self applicationDidEnterBackground];
        }else if ([message isEqualToString:@"active"]){
            [self applicationDidBecomeActive];
        }
    }
}

- (void)applicationDidEnterBackground {
    [self stopRoom];
}

- (void)applicationDidBecomeActive {
    if ([[RoomCenter shared] isFront] == false) {
        return;
    }
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    if ([[ABNet shared] isNetReachable]) {
        [self startRoomWithID:self.roomID];
        [RC.gameManager refresh];
    }
}

- (void)startRoomWithID:(int64_t)roomID {
    if (roomID <= 0) {
        NSLog(@"roomidd invalid ");
        return;
    }
    self.roomID = roomID;
    [self.imService enterRoom:roomID];
    [self.imService start];
    [self.imService addRoomMessageObserver:self];
    [self.imService addPeerMessageObserver:self];
}

- (void)leaveRoomWithID:(int64_t)roomID {
    [self.imService leaveRoom:self.roomID];
}


- (void)stopRoom {
    [self.imService leaveRoom:self.roomID];
    [self.imService stop];
    
//    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    

    [self.imService removeRoomMessageObserver:self];
    [self.imService removePeerMessageObserver:self];
}

- (void)onRoomMessage:(RoomMessage *)rm {
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[rm.content dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
//    {"Cmd":6,"DeskId":15,"Status":2,"Winner":"作废","Boot_num":1,"Pave_num":13}
    [[ABMQ shared] publish:dic channel:CHANNEL_ROOM_GAME];
}

- (void)onPeerMessage:(IMMessage *)msg { //游戏事件
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[msg.content dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
    if (dic[@"Cmd"] != nil && [dic[@"Cmd"] intValue] == 7) {
        [[ABMQ shared] publish:dic channel:CHANNEL_ROOM_GAME];
    }
}

- (void)sendText:(NSString *)text {
    NSDictionary *dic = @{
        @"text":text,
        @"user":[Service shared].account.chatinfo
    };
    
    NSString *message = [dic toJSONString];
    
    RoomMessage *m = [[RoomMessage alloc] init];
    m.sender = [Service shared].account.uid;
    m.receiver = self.roomID;
    m.content = message;
    [self.imService sendRoomMessage:m];
}

- (void)dealloc
{
    [[ABMQ shared] unsubscribe:self];
    [[Service shared].appEventMQ unsubscribe:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self stopRoom];
    NSLog(@"game socket dealloc");
}

@end
