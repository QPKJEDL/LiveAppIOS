//
//  RoomSocket.m
//  zhibo
//
//  Created by qp on 2020/7/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RoomSocket.h"

@interface RoomSocket ()<PeerMessageObserver, RoomMessageObserver>

@end
@implementation RoomSocket

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [[UIApplication sharedApplication] setIdleTimerDisabled:YES];

        self.imService = [[IMService alloc] init];
        self.imService.host = @"129.211.114.135";
        self.imService.port = 23002;
        self.imService.heartbeatHZ = 30;
        self.imService.deviceID = [Service shared].account.uidStr;
        self.imService.token = [Service shared].account.token;
        [self.imService addPeerMessageObserver:self];
        [self.imService addRoomMessageObserver:self];
        
        [self startListenAppStatus];
        
    }
    return self;
}

- (void)startListenAppStatus {
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground) name:UIApplicationWillResignActiveNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)applicationDidEnterBackground {
    NSLog(@"applicationDidEnterBackground");
    [self stopRoom];
}

- (void)applicationDidBecomeActive {
    NSLog(@"applicationDidBecomeActive");
    [self startRoomWithID:self.roomID];
}

- (void)startRoomWithID:(int64_t)roomID {
    self.roomID = roomID;
    [self.imService enterRoom:roomID];
    [self.imService start];
}

- (void)stopRoom {
//    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    
    [self.imService leaveRoom:self.roomID];
    [self.imService stop];

    [self.imService removePeerMessageObserver:self];
}

- (void)onRoomMessage:(RoomMessage *)rm {
    NSLog(@"%@", rm.content);
    [[ABMQ shared] publish:[rm.content toDictionary] channel:@"CHANNEL_ROOM_ROOM"];
}

- (void)onPeerMessage:(IMMessage *)msg {
    [[ABMQ shared] publish:[msg.content toDictionary] channel:@"CHANNEL_ROOM_PEER"];
}

- (void)sendText:(NSString *)text {
    if ([RoomContext shared].isForbidden) {
        [ABUITips showError:@"您已被禁言"];
        return;
    }
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
