//
//  RoomContext.h
//  zhibo
//
//  Created by qp on 2020/7/11.
//  Copyright © 2020 qp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RoomPlayView.h"
#import "RoomPlayControl.h"
#import "RoomSocket.h"
#import "RoomPlayPresent.h"
#import "RoomPushView.h"
#import "RoomPushControl.h"
#import "RoomPushPresent.h"
#import "RoomPushReadyControl.h"
#import "GameSocket.h"

#import "GameManager.h"
#import "RoomManager.h"
#import "RoomAnchorBriefView.h"
NS_ASSUME_NONNULL_BEGIN

#define RC  [RoomContext shared]

@interface RoomContext : NSObject
+ (RoomContext *)shared;
@property (nonatomic, assign) NSInteger roomid;
@property (nonatomic, assign) NSInteger anchorid;
@property (nonatomic, weak) RoomSocket *socket;
@property (nonatomic, weak) GameSocket *gamesocket;

@property (nonatomic, assign) BOOL isPush;
//@property (nonatomic, weak) RoomPlayPresent *playPresent;
@property (nonatomic, weak) RoomPushPresent *pushPresent;

@property (nonatomic, weak) RoomPlayView *playView;
@property (nonatomic, weak) RoomPlayView *shixunPlayView;
//@property (nonatomic, weak) RoomPlayControl *playControl;


@property (nonatomic, weak) RoomPushView *pushView;
@property (nonatomic, weak) RoomPushControl *pushControl;
@property (nonatomic, weak) RoomPushReadyControl *readyControl;

@property (nonatomic, assign) BOOL isManager;
@property (nonatomic, assign) BOOL isForbidden;

@property (nonatomic, assign) NSInteger balance;

@property (nonatomic, strong) NSMutableArray *banlist;
@property (nonatomic, assign) NSInteger gameid;

@property (nonatomic, weak) GameManager *gameManager;
@property (nonatomic, weak) RoomManager *roomManager;

@property (nonatomic, weak) RoomAnchorBriefView *briefView;
@end

NS_ASSUME_NONNULL_END
