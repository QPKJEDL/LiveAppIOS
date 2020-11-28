//
//  GameManager.m
//  zhibo
//
//  Created by qp on 2020/7/20.
//  Copyright © 2020 qp. All rights reserved.
//

#import "GameManager.h"
#import "GameSocket.h"
@interface GameManager ()<INetData, IABMQSubscribe>
@property (nonatomic, strong) GameSocket *socket;

@property (nonatomic, strong) NSDictionary *deskInfo;
@property (nonatomic, strong) NSDictionary *desksubmit;

@property (nonatomic, assign) NSInteger MaxLimit;
@property (nonatomic, assign) NSInteger MinLimit;

@property (nonatomic, strong) NSDictionary *tmpDic;//deskinfo

@end
@implementation GameManager
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.socket = [[GameSocket alloc] init];
        
        [[ABMQ shared] subscribe:self channels:@[CHANNEL_ROOM_GAME,@"refreshbalance"] autoAck:true];
        
    }
    return self;
}

- (void)enterRoomId:(NSInteger)roomId {
    self.room_id = roomId;
    [self fetchPostUri:URI_ROOM_GAME params:@{@"room_id":@(roomId)}];
}

- (void)refresh {
    if (self.room_id == 0) {
        return;
    }
    [self fetchPostUri:URI_ROOM_GAME params:@{@"room_id":@(self.room_id)}];
}

//- (void)enterDeskId:(NSInteger)deskId {
//    self.desk_id = deskId;
//    [self.socket startRoomWithID:deskId];
//}

- (void)refreshBalance {
    [self fetchPostUri:URI_ACCOUNT_SX_BANLANCE params:nil];
}

- (void)_refreshDeskInfo {
    [self.socket startRoomWithID:self.desk_id];
    [self fetchPostUri:URI_GAME_DESK params:@{@"desk_id":@(self.desk_id)}];
}



- (void)_refreshDeskBetInfo { //费率，问路
    [self fetchPostUri:URI_GAME_BET_FEE params:@{
        @"game_id":@(self.game_id),
        @"minlimit":@(self.MinLimit),
        @"maxlimit":@(self.MaxLimit),
        @"tip":self.tipStr,
    }];
    
//    if (self.game_id == 1 || self.game_id == 2) {
        [self fetchPostUri:URI_GAME_RESULT_LIST params:@{@"game_id":@(self.game_id), @"boot_num":@(self.boot_num), @"desk_id":@(self.desk_id)}];
//    }
}

- (void)refreshwenlu {
    [self fetchPostUri:URI_GAME_RESULT_LIST params:@{@"game_id":@(self.game_id), @"boot_num":@(self.boot_num), @"desk_id":@(self.desk_id)}];
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    if ([req.uri isEqualToString:URI_ROOM_GAME]) {
        if (obj == nil) {
            self.desk_id = 0;
            self.game_id = 0;
            [RC.gameManager.control rliveclose];
            return;
        }
        self.desk_id = [obj[@"desk_id"] intValue];
        self.game_id = [obj[@"game_id"] intValue];
        [self _refreshDeskInfo];
    }
    if ([req.uri isEqualToString:URI_GAME_DESK]) {
        self.boot_num = [obj[@"BootNum"] intValue];
        self.pave_num = [obj[@"PaveNum"] intValue];
        self.MaxLimit = [obj[@"MaxLimit"] intValue];
        self.MinLimit = [obj[@"MinLimit"] intValue];
        self.game_id = [obj[@"GameId"] intValue];
        self.DeskName = obj[@"DeskName"];
        self.tipStr = obj[@"tip"];
        [self _refreshDeskBetInfo];
        self.tmpDic = obj;
       
        self.shixunPlayAddress = obj[@"LeftPlay"];
    }
    if ([req.uri isEqualToString:URI_GAME_BET_FEE]) {

        self.rules = obj[@"rules"];
        self.deskInfo = self.tmpDic;
        [self refreshDesk:self.tmpDic];
        [[ABMQ shared] publish:self.rules channel:CHANNEL_GAME_RULES];
        
    }
    if ([req.uri isEqualToString:URI_ACCOUNT_SX_BANLANCE]) {
//        [[ABMQ shared] publish:obj channel:CHANNEL_GAME_BALANCE];
        [RC.gameManager.betView setBalance:[obj[@"balance"] floatValue]];
    }
    if ([req.uri isEqualToString:URI_GAME_BET]) {
        [ABUITips hideLoading];
        [RP.betView betSuccess];
        [ABUITips showError:@"下注成功"];
        [self refreshBalance];
    }
    if ([req.uri isEqualToString:URI_GAME_UNBET]) {
        CGFloat bb = [obj[@"balance"] floatValue];
        CGFloat cha = MAX(0, bb-RP.betView.bb);
        
        [[ABAudio shared] playBundleFileWithName:@"bet_cancel.mp3"];
        [ABUITips showSucceed:[NSString stringWithFormat:@"取消返还:%.2f", cha]];
        [RP.betView reset];
        [RC.gameManager.betView setBalance:[obj[@"balance"] floatValue]];
    }
    if ([req.uri isEqualToString:URI_GAME_RESULT_LIST]) {
        [RC.gameManager.control receiveWenLuData:obj];
    }
}

- (void)onNetRequestFailure:(ABNetRequest *)req err:(ABNetError *)err {
    [ABUITips showError:err.message];
    if ([req.uri isEqualToString:URI_GAME_BET]) {
        [ABUITips hideLoading];
        [[ABAudio shared] playBundleFileWithName:@"bet_failed.mp3"];
        [RP.betView timeEnd];
    }
}

- (void)doBet:(NSDictionary *)data {
    NSInteger total = 0;
    for (NSString *item in [data allValues]) {
        total+=[item integerValue];
    }
//    if (total >= self.MinLimit && total <= self.MaxLimit) {
        NSDictionary *info = [[NSMutableDictionary alloc] initWithDictionary:data];
        [info setValuesForKeysWithDictionary:self.deskInfo];
        [info setValue:self.DeskName forKey:@"DeskName"];
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:info];
        [dic setValue:self.rules[@"uris"][@"bet"] forKey:@"uri"];
        [ABUITips showLoading];
        [self fetchPostUri:URI_GAME_BET params:dic];
        
//    }else{
//        [ABUITips showError:@"下注超出限红"];
//    }
}

- (void)doBetCancel {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:self.deskInfo];
    [dic setValue:self.rules[@"uris"][@"unbet"] forKey:@"uri"];
    [self fetchPostUri:URI_GAME_UNBET params:dic];
}

- (void)extractDeskDynamicInfo {
    
}

- (void)refreshDesk:(NSDictionary *)desk {
    NSLog(@"refreshDesk");
    if (desk == nil) {
        return;
    }
    self.desk_id = [desk[@"DeskId"] integerValue]; //刷新台桌ID

    //下注时传递的台桌信息准备
    NSDictionary *mm = @{
        @"DeskName":@"DeskName",
        @"DeskId":@"desk_id",
        @"Boot_num":@"boot_num",
        @"Pave_num":@"pave_num",
        @"BootNum":@"boot_num",
        @"PaveNum":@"pave_num"
    };
    
    NSDictionary *cc = [ABIteration pickKeysAndReplaceWithMapping:mm fromDictionary:desk];
    self.deskInfo = [ABIteration setAndReaplceKeyTo:self.deskInfo with:cc];
//    self.deskInfo = [ABIteration pickKeysAndReplaceWithMapping:mm fromDictionary:desk];
    if ([self.deskInfo[@"boot_num"] intValue] > 0 && [self.deskInfo[@"pave_num"] intValue] > 0) {
        self.boot_num = [self.deskInfo[@"boot_num"] intValue];
        self.pave_num = [self.deskInfo[@"pave_num"] intValue];
        self.atipStr = [NSString stringWithFormat:@"桌号:%@\n靴次:%@\n铺次:%@\n", self.DeskName, self.deskInfo[@"boot_num"], self.deskInfo[@"pave_num"]];
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
    if (cmd == 7) {
        phase = 7;
    }
    
    if (cmd == 2) {
        phase = 8;
    }

    [[ABMQ shared] publish:@{@"status":@(phase), @"data":desk} channel:CHANNEL_GAME_STATUS];
}

- (BOOL)isSelf:(NSDictionary *)dic {
    NSInteger curDeskId = [dic[@"DeskId"] integerValue];
    if (self.desk_id != curDeskId) {
        return false;
    }
    return true;
}


- (void)abmq:(ABMQ *)abmq onReceiveMessage:(id)message channel:(NSString *)channel {
    if ([channel isEqualToString:CHANNEL_ROOM_GAME]) {
        NSDictionary *dic = (NSDictionary *)message;
        if ([dic isKindOfClass:[NSDictionary class]] && dic[@"Cmd"] != nil) {
            int cmd = [dic[@"Cmd"] intValue];
            if (cmd == 7) {
                [self refreshDesk:dic];
                return;
            }
            if ([self isSelf:dic] == false) {
                NSLog(@"不是本台");
                return;
            }
            [self refreshDesk:dic];
        }
    }
    if ([channel isEqualToString:@"refreshbalance"]) {
        [self refreshBalance];
    }
}

- (void)pause {
    [self.socket stopRoom];
}

- (void)resume {
    [self enterRoomId:RC.roomManager.roomid];
}

- (void)dealloc
{
    NSLog(@"gamemanager dealloc");
    RP.betView = nil;
}

@end

