//
//  RoomPushControl.m
//  zhibo
//
//  Created by qp on 2020/7/11.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RoomPushControl.h"
#import "GamesPromptView.h"
#import "DesksPromptView.h"
#import "AnchorFuncPromptView.h"
#import "RoomManagerPromptView.h"
@interface RoomPushControl ()<ABUIListViewDelegate, AnchorFuncPromptViewDelegate, GamesPromptViewDelegate, DesksPromptViewDelegate, IABMQSubscribe>
@property (nonatomic, strong) AnchorFuncPromptView *anchorFuncPromptView;
@property (nonatomic, strong) DesksPromptView *desksPromptView;
@property (nonatomic, strong) GamesPromptView *gamesPrompView;

@property (nonatomic, strong) RoomManagerPromptView *roomMangerPromptView;
@end

@implementation RoomPushControl
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.anchorFuncPromptView = [[AnchorFuncPromptView alloc] initWithFrame:CGRectMake(0, 0, self.width, 200)];
        self.anchorFuncPromptView.delegate = self;

        self.desksPromptView = [[DesksPromptView alloc] initWithFrame:CGRectMake(0, 0, 331, 262)];
        self.desksPromptView.delegate = self;
        
        self.gamesPrompView = [[GamesPromptView alloc] initWithFrame:CGRectMake(0, 0, self.width, 144)];
        self.gamesPrompView.delegate = self;
        
        self.roomMangerPromptView = [[RoomManagerPromptView alloc] initWithFrame:CGRectMake(20, 0, self.width-40, self.height/2)];
//        self.roomMangerPromptView.delegate = self;
        
//        [[ABMQ shared] subscribe:self channels:@[@"CHANNEL_ROOM_ROOM", @"CHANNEL_ROOM_PEER"] autoAck:true];
        [[ABMQ shared] subscribe:self channels:@[@"CHANNEL_ROOM_GAME", @"CHANNEL_ROOM_ROOM", @"CHANNEL_ROOM_PEER"] autoAck:true];
    }
    return self;
}
- (void)onClose {
    QMUIAlertAction *action1 = [QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:NULL];
    QMUIAlertAction *action2 = [QMUIAlertAction actionWithTitle:@"确定" style:QMUIAlertActionStyleDestructive handler:^(__kindof QMUIAlertController * _Nonnull aAlertController, QMUIAlertAction * _Nonnull action) {
        [self didClose];
    }];
      QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:@"确定关闭直播？" message:nil preferredStyle:QMUIAlertControllerStyleAlert];
      [alertController addAction:action1];
      [alertController addAction:action2];
      [alertController showWithAnimated:YES];
}

- (void)didClose {
    [[RoomContext shared].pushView stop];
    [self fetchPostUri:URI_ROOM_CLOSE params:@{@"room_id":@(RC.roomid)}];
    [NSRouter dismiss];
}

- (void)abmq:(ABMQ *)abmq onReceiveMessage:(id)message channel:(NSString *)channel {
    if ([channel isEqualToString:@"CHANNEL_ROOM_GAME"]) {
        [self refreshDesk:message];
        return;
    }
    if (![message isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    if ([channel isEqualToString:@"CHANNEL_ROOM_ROOM"]) {
        [self onReceiveRoomMessage:message];
    }
    else if ([channel isEqualToString:@"CHANNEL_ROOM_PEER"]) {
        [self onReceivePeerMessage:message];
    }
}

- (void)refreshDesk:(NSDictionary *)desk {
    if (desk == nil) {
        return;
    }

    //获取台桌状态，执行相应UI更新
    //Phase:0洗牌中1倒计时(开始下注)2开牌中(停止下注)3结算完成
    //cmd: 10 下注成功
    int phase = -1;
    if (desk[@"Phase"] != nil) {
        phase = [desk[@"Phase"] intValue];
    }
    
    int cmd = [desk[@"Cmd"] intValue];
    if (cmd == 6) {
        phase = 4;
    }
    
    switch (phase) {
        case 4://结算完成(有结果)
            [RP promptGameResultWithGameId:[RoomContext shared].gameid winner:desk[@"Winner"]];
            break;
        default:
            break;
    }
}

- (void)onMore {
    [[ABUIPopUp shared] show:self.anchorFuncPromptView from:ABPopUpDirectionBottom];
}

- (void)anchorFuncPromptView:(AnchorFuncPromptView *)anchorFuncPromptView didSelectIndex:(NSInteger)index item:(NSDictionary *)item {
    [[ABUIPopUp shared] remove:0];
    if (index == 3) { //翻转镜头
        [[RoomContext shared].pushView flip];
    }
    if (index == 2) { //美颜
        [RP promptBeauty];
    }
    if (index == 1) {
        [self.roomMangerPromptView refreshWithRoomID:[RoomContext shared].roomid];
        [[ABUIPopUp shared] show:self.roomMangerPromptView from:ABPopUpDirectionCenter];
    }
    if (index == 0) { // 游戏选择
        [[ABUIPopUp shared] show:self.gamesPrompView from:ABPopUpDirectionBottom];
    }
    
}

- (void)gamesPromptView:(GamesPromptView *)gamesPromptView didSelectIndex:(NSInteger)index item:(NSDictionary *)item {
    [[ABUIPopUp shared] remove:0];
    [self.desksPromptView refreshWithGameID:[item[@"id"] intValue]];
    [[ABUIPopUp shared] show:self.desksPromptView from:ABPopUpDirectionCenter];
}


- (void)desksPromptView:(DesksPromptView *)desksPromptView didSelectIndex:(NSInteger)index item:(NSDictionary *)item {
    
}

@end
