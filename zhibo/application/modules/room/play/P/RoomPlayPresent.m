//
//  RoomPlayPresent.m
//  zhibo
//
//  Created by qp on 2020/7/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RoomPlayPresent.h"
@interface RoomPlayPresent ()
@property (nonatomic, strong) NSDictionary *deskInfo;
@property (nonatomic, strong) NSDictionary *desksubmit;
@property (nonatomic, strong) NSDictionary *rules;
@property (nonatomic, assign) NSInteger MaxLimit;
@property (nonatomic, assign) NSInteger MinLimit;
@end
@implementation RoomPlayPresent

- (void)requestRoomInfo {
    [self fetchPostUri:URI_ROOM_INFO params:@{@"room_id":@([RoomContext shared].roomid)}];
    [self fetchPostUri:URI_ROOM_GIFT params:nil];
    [self fetchPostUri:URI_ROOM_GAME params:@{@"room_id":@([RoomContext shared].roomid)}];
    [self fetchPostUri:URI_ROOM_MANAGER params:@{@"room_id":@([RoomContext shared].roomid)}];
    [self fetchPostUri:URI_ROOM_BANSTATUS params:@{@"room_id":@([RoomContext shared].roomid)}];
    [self fetchPostUri:URI_ACCOUNT_SX_BANLANCE params:nil];
}

- (void)requestDeskInfo:(NSDictionary *)dic {
    if (dic[@"desk_id"] == nil) {
        [self fetchPostUri:URI_GAME_DESK params:@{@"desk_id":dic[@"DeskId"]}];
    }else{
        [self fetchPostUri:URI_GAME_DESK params:@{@"desk_id":dic[@"desk_id"]}];
    }
    
}


//#pragma mark --------- interface ----------
- (void)doBet:(NSDictionary *)betInfo {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:betInfo];
    [dic setValue:self.rules[@"uris"][@"bet"] forKey:@"uri"];
    [self fetchPostUri:URI_GAME_BET params:dic];
}

- (void)doBetCancel:(NSDictionary *)info {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:info];
    [dic setValue:self.rules[@"uris"][@"unbet"] forKey:@"uri"];
    [self fetchPostUri:URI_GAME_UNBET params:dic];
}

#pragma mark ---------------- delegates ----------------
- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    if ([req.uri isEqualToString:URI_ROOM_INFO]) { //房间信息
        self.roomInfo = obj;
        if ([obj[@"room"][@"status"] intValue] == 0) {
            [self.delegate roomPlayPresent:self closeWithData:obj];
            return;
        }
        [RoomContext shared].anchorid = [obj[@"anchor"][@"UserId"] intValue];
        [[RoomContext shared].playControl receiveRoomInfo:self.roomInfo];
        [[RoomContext shared].playView playURL:self.roomInfo[@"video"][@"pull"]];
    }
    else if ([req.uri isEqualToString:URI_ROOM_MANAGER]) {
        [RoomContext shared].isManager = true;
    }
    else if ([req.uri isEqualToString:URI_ROOM_BANSTATUS]) {
        [RoomContext shared].isForbidden = true;
    }
    else if ([req.uri isEqualToString:URI_ROOM_GAME]) {
        if ([obj isKindOfClass:[NSNull class]]) {
            return;
        }
        [self requestDeskInfo:obj];
    }
    else if ([req.uri isEqualToString:URI_GAME_DESK]) {
        self.deskInfo = obj;
        [[RoomContext shared].playControl receiveDeskInfo:obj];
        self.MaxLimit = [obj[@"MaxLimit"] intValue];
        self.MinLimit = [obj[@"MinLimit"] intValue];
        [self fetchPostUri:URI_GAME_BET_FEE params:@{
            @"game_id":obj[@"GameId"],
            @"minlimit":@(self.MinLimit),
            @"maxlimit":@(self.MaxLimit)
        }];
        
        NSInteger game_id = [obj[@"GameId"] intValue];
        [[RoomContext shared].playControl.wenluWebView setHidden:true];
        if (game_id == 1 || game_id == 2) {
            [[RoomContext shared].playControl.wenluWebView setHidden:false];
            [self fetchPostUri:URI_GAME_RESULT_LIST params:@{@"game_id":@(game_id), @"boot_num":obj[@"BootNum"], @"desk_id":obj[@"DeskId"]}];
        }
    }
    else if ([req.uri isEqualToString:URI_GAME_BET_FEE]) {
        self.rules = obj[@"rules"];
        [[RoomContext shared].playControl receiveBetRules:obj[@"rules"]];
    }
    else if ([req.uri isEqualToString:URI_GAME_BET]) {
        [[RoomContext shared].playControl receiveBetSuccess];
    }
    else if ([req.uri isEqualToString:URI_GAME_UNBET]) {
        [ABUITips showSucceed:@"取消成功"];
    }
    else if ([req.uri isEqualToString:URI_FOLLOW_FOLLOW]) {
        [ABUITips showSucceed:@"关注成功"];
    }
    else if ([req.uri isEqualToString:URI_GAME_RESULT_LIST]) {
        [[RoomContext shared].playControl receiveWenLu:obj[@"list"]];
    }
    else if ([req.uri isEqualToString:URI_ACCOUNT_SX_BANLANCE]) {
        [RoomContext shared].balance = [obj[@"balance"] intValue];
        [[RoomContext shared].playControl receiveBalance:[obj[@"balance"] intValue]];
    }
    
}

- (void)onNetRequestFailure:(ABNetRequest *)req err:(ABNetError *)err {
    if ([req.uri isEqualToString:URI_GAME_BET] || [req.uri isEqualToString:URI_GAME_UNBET]) {
        [ABUITips showError:err.message];
    }
    if ([req.uri isEqualToString:URI_FOLLOW_FOLLOW]) {
        [ABUITips showError:err.message];
    }
    if ([req.uri isEqualToString:URI_ROOM_MANAGER]) {
        [RoomContext shared].isManager = false;
    }
    if ([req.uri isEqualToString:URI_ROOM_BANSTATUS]) {
        [RoomContext shared].isForbidden = false;
    }
}

@end
