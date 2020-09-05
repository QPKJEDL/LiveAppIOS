//
//  GameSocket.m
//  zhibo
//
//  Created by qp on 2020/7/14.
//  Copyright © 2020 qp. All rights reserved.
//

#import "GameSocket.h"

@interface GameSocket ()<PeerMessageObserver, RoomMessageObserver>

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
        
        [self startListenAppStatus];
        
        self.roomID = -1;
        
    }
    return self;
}

- (void)startListenAppStatus {
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground) name:UIApplicationWillResignActiveNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)applicationDidEnterBackground {
    [self stopRoom];
}

- (void)applicationDidBecomeActive {
    [self startRoomWithID:self.roomID];
    
    [RC.gameManager refresh];
}

- (void)startRoomWithID:(int64_t)roomID {
//    if (self.roomID > 0) {
//        [self.imService leaveRoom:self.roomID];
//    }
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
    NSLog(@"%@", rm.content);
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
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self stopRoom];
}

@end
