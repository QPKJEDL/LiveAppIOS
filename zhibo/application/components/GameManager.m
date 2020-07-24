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
@property (nonatomic, assign) NSInteger desk_id;
@end
@implementation GameManager
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.socket = [[GameSocket alloc] init];
        
        [[ABMQ shared] subscribe:self channel:@"CHANNEL_ROOM_GAME" autoAck:true];
    }
    return self;
}

- (void)enterDeskId:(NSInteger)deskId {
    self.desk_id = deskId;
    [self.socket startRoomWithID:deskId];
}

- (void)_refreshDeskInfo {
    [self fetchPostUri:URI_GAME_DESK params:@{@"desk_id":@(self.desk_id)}];
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    
}

//- (void)refreshDesk:(NSDictionary *)desk {
//    if (desk == nil) {
//        return;
//    }
//    self.deskId = [desk[@"DeskId"] integerValue]; //刷新台桌ID
//
//    //下注时传递的台桌信息准备
//    NSDictionary *mm = @{
//        @"DeskName":@"DeskName",
//        @"DeskId":@"desk_id",
//        @"Boot_num":@"boot_num",
//        @"Pave_num":@"pave_num",
//        @"BootNum":@"boot_num",
//        @"PaveNum":@"pave_num"
//    };
//    self.deskInfo = [ABIteration pickKeysAndReplaceWithMapping:mm fromDictionary:desk];
//    self.desk = desk;
//    //获取台桌状态，执行相应UI更新
//    //Phase:0洗牌中1倒计时(开始下注)2开牌中(停止下注)3结算完成
//    //cmd: 10 下注成功
//    int phase = -1;
//    if (desk[@"Phase"] != nil) {
//        phase = [desk[@"Phase"] intValue];
//    }
//
//    int cmd = [desk[@"Cmd"] intValue];
//    if (cmd == 6) {
//        phase = 4;
//    }
//
//    switch (phase) {
//        case 0: //洗牌中
//            [self.plateView watch]; //变更洗牌中
//
//            self.betView.enabled = false; //禁止下注
//            [self.betView reset]; //重置下注盘
//            break;
//        case 1://开始下注
//            [self.plateView please:desk]; //开启下注倒计时
//
//            self.betView.enabled = true; //开启下注
//            [self showBetView]; //弹出下注UI
//            [self.betView reset]; //重置下注盘
//            break;
//        case 2://开牌中(停止下注)
//            [self.plateView wait]; //变更待开牌
//
//            self.betView.enabled = false;//禁止下注
//            if (self.betView.isBet == false) {
//                [self.betView reset];
//            }
//            break;
//        case 3://结算完成
//            [self.plateView finish];
//
//            self.betView.enabled = false;//禁止下注
//            break;
//        case 4://结算完成(有结果)
//            [self.plateView finish];
//
//            self.betView.enabled = false;//禁止下注
//            [self.jiesuanButton setHidden:false];
//            [RP promptGameResultWithGameId:self.gameid winner:desk[@"Winner"]];
//            [self showBetView];
//
//            break;
//        default:
//            break;
//    }
//}

- (void)abmq:(ABMQ *)abmq onReceiveMessage:(id)message channel:(NSString *)channel {
    
}
@end
