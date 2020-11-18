//
//  GameDataProcess.m
//  zhibo
//
//  Created by qp on 2020/6/29.
//  Copyright © 2020 qp. All rights reserved.
//

#import "GameDataProcess.h"
#import "GameDataHelper.h"
@interface GameDataProcess ()
@property (nonatomic, strong) GameDataHelper *dataHelper;
@end

@implementation GameDataProcess

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataHelper = [[GameDataHelper alloc] init];
    }
    return self;
}

/// Called to modify a request before sending.
- (ABNetRequest *)prepare:(ABNetRequest *)request {
    if ([request.uri isEqualToString:URI_GAME_BET]) {
        request.realUri = request.params[@"uri"];
    }
    else if ([request.uri isEqualToString:URI_GAME_UNBET]) {
        request.realUri = request.params[@"uri"];
    }
    else if ([request.uri isEqualToString:URI_GAME_LIST]) {
        request.realUri = @"/roomtypecount";
    }
    else if ([request.uri isEqualToString:URI_GAME_BET_FEE]) {
        request.realUri = @"/UserBetsFee";
//        request.realParams = @{@"game_id":request.params[@"game_type"]};
    }
    else if ([request.uri isEqualToString:URI_GAME_LOGIN]) {
        request.realUri = @"/login";
    }
    else if ([request.uri isEqualToString:URI_GAME_DESK]) {
        request.realUri = @"/RoomTypelistinfo";
    }
    else if ([request.uri isEqualToString:URI_GAME_DESKLIST]) {
        request.realUri = @"/RoomTypelist";
    }
    else if ([request.uri isEqualToString:URI_GAME_HISTORY]) {
        request.realUri = @"/user_bet_list";
    }
    else if ([request.uri isEqualToString:URI_GAME_RESULT_LIST]) {
        //        {
        //            "desk_id" = 16;
        //            "game_id" = 2;
        //            "room_id" = 60034;
        //        }
        NSInteger gameid = [request.params[@"game_id"] intValue];
        
        if (gameid == 1) {
            request.realUri = @"/bjl_game_list";
        }else if (gameid == 2) {
            request.realUri = @"/lh_game_list";
        }
        else if (gameid == 3) { //niuniu
            request.realUri = @"/nnGameRecord";
        }
        else if (gameid == 4) { //三公
            request.realUri = @"/SgGameRecord";
        }
        else if (gameid == 5) { //A89
            request.realUri = @"/A89GameRecord";
        }
    }
    return request;
}

/// Called immediately before a request will sent
- (BOOL)canSend:(ABNetRequest *)request {
    if ([request.uri isEqualToString:URI_GAME_BET_RULES]) {
        return false;
    }
    if ([request.uri isEqualToString:URI_GAME_RESULTS]) {
        return false;
    }
    if ([request.uri isEqualToString:URI_GAME_RULES]) {
        return false;
    }
//    if ([request.uri isEqualToString:URI_GAME_BET_FEE]) {
//        return false;
//    }
    return true;
}

/// Called immediately before a request is sent over the network (or stubbed).
- (void)willSend:(ABNetRequest *)request {
//    [[UIApplication sharedApplication].keyWindow makeToastActivity:CSToastPositionCenter];
}

/// Called to modify a result before completion.
- (void)didReceive:(ABNetRequest *)request response:(NSDictionary *)response {
//     [[UIApplication sharedApplication].keyWindow hideToastActivity];
}

/// Called to modify a result before completion.
- (NSDictionary *)process:(ABNetRequest *)request response:(NSDictionary *)response {
    if ([request.uri isEqualToString:URI_GAME_BET_FEE]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:response];
        dic[@"rules"] = [self.dataHelper getGameBetRuleWithParams:@{
            @"fee":response,
            @"minlimit":request.params[@"minlimit"],
            @"maxlimit":request.params[@"maxlimit"],
            @"game_id":request.params[@"game_id"],
            @"issuper":@(true)
        }];
        return dic;
    }
    if ([request.uri isEqualToString:URI_GAME_DESK]) {
        NSArray *list = response[@"list"];
        if (list.count == 0) {
            return response[@"list"];
        }
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:response[@"list"][0]];
        NSString *tip = @"";
        NSInteger game_id = [dic[@"GameId"] intValue];
        if (game_id == 1) {
            tip = [NSString stringWithFormat:@"庄闲:%@~%@\n和:%@~%@\n对子:%@~%@", dic[@"MinLimit"], dic[@"MaxLimit"], dic[@"TieMinLimit"], dic[@"TieMaxLimit"], dic[@"PairMinLimit"], dic[@"PairMaxLimit"]];
        }
        if (game_id == 2) {
            tip = [NSString stringWithFormat:@"龙/虎:%@~%@\n和:%@~%@", dic[@"MinLimit"], dic[@"MaxLimit"], dic[@"TieMinLimit"], dic[@"TieMaxLimit"]];
        }
        if (game_id == 3 || game_id == 4 || game_id == 5) {
            tip = [NSString stringWithFormat:@"平倍限红:%@~%@\n翻倍限红:%@~%@", dic[@"MinLimit"], dic[@"MaxLimit"], dic[@"TieMinLimit"], dic[@"TieMaxLimit"]];
        }
        [dic setValue:tip forKey:@"tip"];
        return dic;
    }
    if ([request.uri isEqualToString:URI_GAME_RESULTS]) {
        return [self.dataHelper getGameBetResultWithParams:request.params];
    }
    if ([request.uri isEqualToString:URI_GAME_HISTORY]) {
        NSMutableArray *list = [[NSMutableArray alloc] init];
        [list addObject:@{
            @"time":@"日期：2020-07-28",
            @"number":@"注单号：N20010202",
            @"detail":@"详细注单：A10 1靴 1铺",
            @"money":@"投注金额：闲三平 100",
            @"native_id":@"gamehistoryitem"
        }];
        
        return @{@"list":list};
    }
    if ([request.uri isEqualToString:URI_GAME_RULES]) {
        
        NSArray *list = @[
            @{
                @"title":@"百家乐游戏",
                @"src":@"https://live.zbzx6088.com:8933/game/baijiale.html",
                @"native_id":@"gameruleitem",
            },
            @{
                @"title":@"龙虎游戏",
                @"src":@"https://live.zbzx6088.com:8933/game/longhu.html",
                @"native_id":@"gameruleitem",
            },
            @{
                @"title":@"牛牛游戏",
                @"src":@"https://live.zbzx6088.com:8933/game/niuniu.html",
                @"native_id":@"gameruleitem",
            },
            @{
                @"title":@"三公游戏",
                @"src":@"https://live.zbzx6088.com:8933/game/sangong.html",
                @"native_id":@"gameruleitem",
            },
            @{
                @"title":@"A89游戏",
                @"src":@"https://live.zbzx6088.com:8933/game/A89.html",
                @"native_id":@"gameruleitem",
            }
        ];
        
        return @{@"list":list};
    }
    if ([request.uri isEqualToString:URI_GAME_RESULT_LIST]) {
//        NSLog(@"%lu", (unsigned long)[response[@"list"][0][@"list"] count]);
        NSArray *list = response[@"list"][0][@"list"];
        if (list.count == 0) {
            NSLog(@"no game result");
        }
        return @{@"list":list};
    }
    if ([request.uri isEqualToString:URI_GAME_DESKLIST]) {
        NSArray *list = response[@"list"];
        NSMutableArray *nlist = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in list) {
            if ([dic[@"GameId"] intValue] != 0) {
                [nlist addObject:dic];
            }
        }
        
        NSArray *listt = [ABIteration iterationList:nlist block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
            dic[@"native_id"] = @"deskitem";
            return dic;
        }];
        return @{@"list":listt};
    }
    return response;
}

@end
