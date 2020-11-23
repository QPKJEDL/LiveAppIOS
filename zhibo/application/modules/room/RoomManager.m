//
//  RoomManager.m
//  zhibo
//
//  Created by qp on 2020/8/14.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RoomManager.h"
#import "RoomSocket.h"
@interface RoomManager ()<INetData, RoomSocketDelegate>
@property (nonatomic, strong) RoomSocket *roomSocket;
@property (nonatomic, assign) int type;
@end
@implementation RoomManager
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.roomSocket = [[RoomSocket alloc] init];
        self.roomSocket.delegate = self;
        self.isAnchor = false;
        [UIApplication sharedApplication].idleTimerDisabled = true;
        [[UIApplication sharedApplication] addObserver:self forKeyPath:@"idleTimerDisabled"options:NSKeyValueObservingOptionNew context:nil];
        
       
    }
    return self;
}


- (void)roomSocketDidConnected {
    [self fetchPostUri:URI_ROOM_INFO params:@{@"room_id":@(self.roomid), @"type":@(self.type)}];

    self.type = 1;
}

- (void)enterRoomId:(NSInteger)roomId {
    self.roomid = roomId;
    self.type = 0;
    [self.roomSocket startRoomWithID:roomId];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void*)context{
    if ([UIApplication sharedApplication].idleTimerDisabled == false) {
        [UIApplication sharedApplication].idleTimerDisabled = YES;
    }
    
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    [ABUITips hideLoading];
    if ([req.uri isEqualToString:URI_ROOM_INFO]) { //房间信息
        int status = [obj[@"room"][@"status"] intValue];
        self.isOnline = (status == 1);
        if (status == 0) {
            [RC.gameManager.control rliveclose];
            return;
        }
        [[ABMQ shared] publish:obj channel:CHANNEL_ROOM_INFO];
        self.anchorid = [obj[@"anchor"][@"UserId"] intValue];
        
        
        if (self.isAnchor) {
            [RoomContext shared].isForbidden = false;
            [RoomContext shared].isManager = true;
        }else{
            [self fetchPostUri:URI_ROOM_MANAGER params:@{@"room_id":@(self.roomid)}];
            [self fetchPostUri:URI_ROOM_BANSTATUS params:@{@"room_id":@(self.roomid)}];
        }
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
    if ([text isEqualToString:@":recovery"]) {
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

- (void)finish {
    QMUIAlertAction *action2 = [QMUIAlertAction actionWithTitle:@"确定" style:QMUIAlertActionStyleDestructive handler:^(__kindof QMUIAlertController * _Nonnull aAlertController, QMUIAlertAction * _Nonnull action) {
        [[RoomContext shared].pushView stop];
        [self fetchPostUri:URI_ROOM_CLOSE params:@{@"room_id":@(RC.roomManager.roomid)}];
        [NSRouter dismiss];
    }];
    QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:@"直播已失联，请重新开播" message:nil preferredStyle:QMUIAlertControllerStyleAlert];
    [alertController addAction:action2];
    [alertController showWithAnimated:YES];
}
@end

