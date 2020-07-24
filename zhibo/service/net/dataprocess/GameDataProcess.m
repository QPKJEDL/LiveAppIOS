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
    return response;
}

@end
