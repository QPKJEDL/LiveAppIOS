//
//  RoomPushViewController.m
//  zhibo
//
//  Created by qp on 2020/7/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RoomPushViewController.h"
#import "RoomPushView.h"
#import "RoomPushPresent.h"
#import "RoomPushReadyControl.h"
#import "RoomPushLoadControl.h"
#import "RoomPushControl.h"
#import "RoomPushSocket.h"
#import "GameSocket.h"
#import <ABDevice.h>
//#import "RoomPushReadyControl.h"
//#import "KaiBoLoadingControl.h"
//#import "KaiBoRoomControl.h"
@import TXLiteAVSDK_Smart;
@interface RoomPushViewController ()<RoomPushLoadControlDelegate, RoomPushPresentDelegate>

@property (nonatomic, strong) RoomPushView *pushView;
@property (nonatomic, strong) RoomPushReadyControl *readyControl;
@property (nonatomic, strong) RoomPushLoadControl *loadControl;
@property (nonatomic, strong) RoomPushControl *roomControl;

@property (nonatomic, strong) RoomPushPresent *present;
@property (nonatomic, strong) RoomPushSocket *socket;
@property (nonatomic, strong) GameSocket *gameSocket;

@end

@implementation RoomPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.pushView = [[RoomPushView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.pushView];
    
    self.readyControl = [[RoomPushReadyControl alloc] initWithFrame:self.view.bounds];
    self.readyControl.vc = self;
    [self.view addSubview:self.readyControl];
    
    self.socket = [[RoomPushSocket alloc] init];
    
    self.gameSocket = [[GameSocket alloc] init];
    
    self.present = [[RoomPushPresent alloc] init];
    self.present.delegate = self;
    [self.pushView preview];
    
    [RoomContext shared].pushPresent = self.present;
    [RoomContext shared].pushView = self.pushView;
    [RoomContext shared].socket = self.socket;
    [RoomContext shared].readyControl = self.readyControl;
    [RoomContext shared].gamesocket = self.gameSocket;
    
    if ([ABDevice isAvailableCamera] == false) {
        QMUIAlertAction *action1 = [QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:NULL];
        QMUIAlertAction *action2 = [QMUIAlertAction actionWithTitle:@"去授权" style:QMUIAlertActionStyleDestructive handler:^(__kindof QMUIAlertController * _Nonnull aAlertController, QMUIAlertAction * _Nonnull action) {
            [ABDevice gotoAppSetting];
        }];
        QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:@"无法使用相机，需要您的授权" message:nil preferredStyle:QMUIAlertControllerStyleAlert];
        [alertController addAction:action1];
        [alertController addAction:action2];
        [alertController showWithAnimated:YES];
    }
}

- (BOOL)prefersStatusBarHidden {
    if (self.roomControl == nil) {
        return true;
    }
    return false;
}

- (void)present:(RoomPushPresent *)present startLive:(NSDictionary *)info {
    [self.readyControl removeFromSuperview];
//    [self controlOnFinish:nil];
    
    self.loadControl = [[RoomPushLoadControl alloc] initWithFrame:self.view.bounds];
    self.loadControl.delegate = self;
    [self.view addSubview:self.loadControl];
}

- (void)controlOnFinish:(RoomPushLoadControl *)control {
    [self.loadControl removeFromSuperview];
    self.roomControl = [[RoomPushControl alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.roomControl];
    [self setNeedsStatusBarAppearanceUpdate];

    [RoomContext shared].pushControl = self.roomControl;
    [self.pushView push:self.present.address];
    [self.present requestRoomInfo];
    
}

@end
