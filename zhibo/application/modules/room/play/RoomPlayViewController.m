//
//  RoomPlayViewController.m
//  zhibo
//
//  Created by qp on 2020/7/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RoomPlayViewController.h"
#import "RoomPlayPresent.h"
#import "RoomPlayControl.h"
#import "RoomPlayView.h"
#import "RoomPresent.h"
#import "RoomSocket.h"
#import "GameSocket.h"
#import "RoomPlayEndControl.h"
#import "RoomPlayPresent.h"
@interface RoomPlayViewController ()<RoomPlayControlDelegate, RoomPlayPresentDelegate>
@property (nonatomic, strong) RoomPlayView *playView;
@property (nonatomic, strong) RoomPlayControl *controlView;
@property (nonatomic, strong) RoomPlayPresent *present;
@property (nonatomic, strong) RoomSocket *roomSocket;
@property (nonatomic, strong) GameSocket *gameSocket;
@property (nonatomic, strong) RoomPlayEndControl *endControl;
@end

@implementation RoomPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isVisableNavigationBar = false;
    
    self.playView = [[RoomPlayView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.playView];
    
    self.controlView = [[RoomPlayControl alloc] initWithFrame:self.view.bounds];
    self.controlView.delegate = self;
    [self.view addSubview:self.controlView];
    
    self.roomSocket = [[RoomSocket alloc] init];
    [self.roomSocket startRoomWithID:self.roomid];
    
    self.gameSocket = [[GameSocket alloc] init];
    
    self.present = [[RoomPlayPresent alloc] init];
    self.present.delegate = self;
    
    [RoomContext shared].playControl = self.controlView;
    [RoomContext shared].playView = self.playView;
    [RoomContext shared].socket = self.roomSocket;
    [RoomContext shared].playPresent = self.present;
    [RoomContext shared].roomid = self.roomid;
    [RoomContext shared].gamesocket = self.gameSocket;
    
    [self.present requestRoomInfo];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.playView viewWillAppear];
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.endControl != nil) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.playView viewDisAppear];
}

- (void)roomPlayControl:(RoomPlayControl *)roomPlayControl closeWithData:(NSDictionary *)data {
    [self close:data];
}

- (void)roomPlayPresent:(RoomPlayPresent *)roomPlayPresent closeWithData:(NSDictionary *)data {
    [self close:data];
}

- (void)close:(NSDictionary *)data {
    [self.controlView removeFromSuperview];
    [self.playView free];

    self.endControl = [[RoomPlayEndControl alloc] initWithFrame:self.view.bounds];
    [self.endControl setData:data];
    [self.view addSubview:self.endControl];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)dealloc
{
    [self.playView free];
}

@end
