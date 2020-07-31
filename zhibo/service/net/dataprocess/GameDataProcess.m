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
    if ([request.uri isEqualToString:URI_GAME_HISTORY]) {
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
        return response[@"list"][0];
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
                @"src":@"baijiale.html",
                @"native_id":@"gameruleitem",
            },
            @{
                @"title":@"龙虎游戏",
                @"src":@"longhu.html",
                @"native_id":@"gameruleitem",
            },
            @{
                @"title":@"牛牛游戏",
                @"src":@"niuniu.html",
                @"native_id":@"gameruleitem",
            },
            @{
                @"title":@"三公游戏",
                @"src":@"sangong.html",
                @"native_id":@"gameruleitem",
            },
            @{
                @"title":@"A89游戏",
                @"src":@"A89.html",
                @"native_id":@"gameruleitem",
            }
        ];
        
        return @{@"list":list};
    }
    return response;
}

@end
