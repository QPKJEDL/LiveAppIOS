//
//  RoomPushView.m
//  zhibo
//
//  Created by qp on 2020/7/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RoomPushView.h"
#import <AFNetworking/AFNetworking.h>
@import TXLiteAVSDK_Smart;
@interface RoomPushView ()<TXLivePushListener, INetData, IABMQSubscribe>
@property (nonatomic, strong) TXLivePush *pusher;
@end
@implementation RoomPushView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        TXLivePushConfig *_config = [[TXLivePushConfig alloc] init];  // 一般情况下不需要修改默认 config
        _config.pauseImg = [UIImage imageWithColor:[UIColor hexColor:@"161823"]];
        self.pusher = [[TXLivePush alloc] initWithConfig: _config]; // config 参数不能为空
        self.pusher.delegate = self;
        [self.pusher setMirror:true];
        self.beautyLevel = 0.2;
        self.whitenessLevel = 0.2;
        self.beautyLevel = 0.2;
        
        // 注册应用监听事件
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(willResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
        [center addObserver:self selector:@selector(didBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
        
        
        [[ABMQ shared] subscribe:self channel:CHANNEL_NET_REACHABLE autoAck:true];
    }
    return self;
}

- (void)preview {
    [self.pusher startPreview:self];
}

- (void)flip {
    [self.pusher switchCamera];
    [self.pusher setMirror:self.pusher.frontCamera];
}

- (void)abmq:(ABMQ *)abmq onReceiveMessage:(id)message channel:(NSString *)channel {
    if ([channel isEqualToString:CHANNEL_NET_REACHABLE]) {
        [self didBecomeActive:nil];
    }
}

- (void)push:(NSString *)address {
    [[UIApplication sharedApplication] setIdleTimerDisabled:true];
    [self.pusher startPush:address];
}

// 具体实现. _livePuser 为当前TXLivePush实例对象
#pragma mark - 前后台切换
- (void)willResignActive:(NSNotification *)notification {
    if ([[ABNet shared] isNetReachable]) {
        [self fetchPostUri:URI_ROOM_LEAVE params:@{@"room_id":@(RC.roomManager.roomid)}];
    }
    [self.pusher pausePush];
}

- (void)didBecomeActive:(NSNotification *)notification {
    if ([[ABNet shared] isNetReachable]) {
        [self imback];
        [self.pusher resumePush];
    }
}

- (void)onPushEvent:(int)evtID withParam:(NSDictionary *)param {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (evtID == WARNING_RTMP_READ_WRITE_FAIL) {

        }
        if (evtID == PUSH_EVT_ROOM_USER_ENTER) {
            NSLog(@"用户进入");
        }
        if (evtID == PUSH_EVT_PUSH_BEGIN) {
            NSLog(@"开始推流");
            [self imback];
        }
        if (evtID == PUSH_WARNING_RECONNECT) {
            NSLog(@"开始推流");
        }
        if (evtID == PUSH_ERR_NET_DISCONNECT || evtID == PUSH_ERR_INVALID_ADDRESS) {
            QMUIAlertAction *action2 = [QMUIAlertAction actionWithTitle:@"确定" style:QMUIAlertActionStyleDestructive handler:^(__kindof QMUIAlertController * _Nonnull aAlertController, QMUIAlertAction * _Nonnull action) {
                [[RoomContext shared].pushView stop];
                [self fetchPostUri:URI_ROOM_CLOSE params:@{@"room_id":@(RC.roomManager.roomid)}];
                [NSRouter dismiss];
            }];
            QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:@"直播已失联，请重新开播" message:nil preferredStyle:QMUIAlertControllerStyleAlert];
            [alertController addAction:action2];
            [alertController showWithAnimated:YES];
            
        } else if (evtID == PUSH_WARNING_NET_BUSY) {
            [ABUITips showError:@"您当前的网络环境不佳，请尽快更换网络保证正常直播"];
        }

    });
}

- (void)setBeautyLevel:(float)beautyLevel {
    _beautyLevel = beautyLevel;
    [[self.pusher getBeautyManager] setBeautyLevel:beautyLevel*10];
    
}

- (void)setWhitenessLevel:(float)whitenessLevel {
    _whitenessLevel = whitenessLevel;
    [[self.pusher getBeautyManager] setWhitenessLevel:whitenessLevel*10];
}

- (void)setRuddyLevel:(float)ruddyLevel {
    _ruddyLevel = ruddyLevel;
    [[self.pusher getBeautyManager] setRuddyLevel:ruddyLevel*10];
}

- (void)stop {
    [self.pusher stopPreview];
    [self.pusher stopPush];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)onNetStatus:(NSDictionary *)param {
    
}


- (void)onNetRequestFailure:(ABNetRequest *)req err:(ABNetError *)err {
    NSLog(@"%@", err.message);
}

- (void)imback {
    NSLog(@"imback");
    if (RC.roomManager.roomid == 0) {
        return;
    }
    [self fetchPostUri:URI_ROOM_RETURN params:@{@"room_id":@(RC.roomManager.roomid)}];
}

- (void)dealloc {
    NSLog(@"%@ dealloc", [[self class] description]);
}

@end
