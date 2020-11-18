//
//  RoomSocket.m
//  zhibo
//
//  Created by qp on 2020/7/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RoomSocket.h"

@interface RoomSocket ()<PeerMessageObserver, RoomMessageObserver, TCPConnectionObserver>

@end
@implementation RoomSocket

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [[UIApplication sharedApplication] setIdleTimerDisabled:YES];

        self.imService = [[IMService alloc] init];
        if (ISENABLESSL) {
            self.imService.ssl = true;
            self.imService.host = @"live.zbzx6088.com";
            self.imService.port = 24430;
        }else{
            self.imService.ssl = false;
            self.imService.host = @"124.156.149.44";
            self.imService.port = 23002;
        }
        
        self.imService.heartbeatHZ = 30;
        self.imService.deviceID = [Service shared].account.uidStr;
        self.imService.token = [Service shared].account.token;
        [self startListenAppStatus];
        
    }
    return self;
}
- (void)onConnectState:(int)state {
    if (state == STATE_CONNECTED) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(roomSocketDidConnected)]) {
            [self.delegate roomSocketDidConnected];
        }
    }
    if (state == STATE_UNCONNECTED) {
        NSLog(@"STATE_UNCONNECTED");
    }
}

- (void)startListenAppStatus {
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive) name:UIApplicationWillEnterForegroundNotification object:nil];

}

- (void)applicationDidEnterBackground {
    NSLog(@"applicationDidEnterBackground");
    [self stopRoom];
}

- (void)applicationDidBecomeActive {
    NSLog(@"applicationDidBecomeActive");
    [self startRoomWithID:self.roomID];
     [UIApplication sharedApplication].idleTimerDisabled = true;
}

- (void)startRoomWithID:(int64_t)roomID {
    self.roomID = roomID;
    [self.imService enterRoom:roomID];
    [self.imService start];
    [self.imService addPeerMessageObserver:self];
    [self.imService addRoomMessageObserver:self];
    [self.imService addConnectionObserver:self];
}

- (void)stopRoom {
//    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    
    [self.imService leaveRoom:self.roomID];
    [self.imService stop];

    [self.imService removePeerMessageObserver:self];
    [self.imService removeRoomMessageObserver:self];
    [self.imService removeConnectionObserver:self];
    
}

- (void)onRoomMessage:(RoomMessage *)rm {
    NSLog(@"%@", rm.content);
    [[ABMQ shared] publish:[rm.content toDictionary] channel:CHANNEL_ROOM_MESSAGE];
}

- (void)onPeerMessage:(IMMessage *)msg {
    [[ABMQ shared] publish:[msg.content toDictionary] channel:CHANNEL_ROOM_PEER];
}

- (void)sendSysText:(NSString *)text {
    
}

- (void)sendText:(NSString *)text {
    if (self.imService.connectState != STATE_CONNECTED) {
        [ABUITips showError:@"聊天已断开"];
        return;
    }
    if ([RoomContext shared].isForbidden) {
        [ABUITips showError:@"您已被禁言"];
        return;
    }
    NSDictionary *dic = @{
        @"text":text,
        @"user":[Service shared].account.chatinfo
    };
    NSString *message = [dic toJSONString2];
    
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
    NSLog(@"room socket dealloc");
}

@end
