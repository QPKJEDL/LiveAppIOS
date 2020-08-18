//
//  LiveRoom.m
//  zhibo
//
//  Created by qp on 2020/8/13.
//  Copyright © 2020 qp. All rights reserved.
//

#import "LiveRoom.h"
@interface LiveRoom ()<INetData>
@property (nonatomic, strong) NSMutableDictionary *roomInfo;
@end
@implementation LiveRoom
- (void)requestRoomInfo:(NSInteger)roomId {
    [self fetchPostUri:URI_ROOM_INFO params:@{@"room_id":@(roomId)}];
    [self fetchPostUri:URI_ROOM_MANAGER params:@{@"room_id":@(roomId)}];
    [self fetchPostUri:URI_ROOM_BANSTATUS params:@{@"room_id":@(roomId)}];
}

- (void)requestRoomDeskInfo:(NSInteger)roomId {
    [self fetchPostUri:URI_ROOM_GAME params:@{@"room_id":@(roomId)}];
    [self fetchPostUri:URI_ACCOUNT_SX_BANLANCE params:nil];
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    if ([req.uri isEqualToString:URI_ROOM_INFO]) { //房间信息
        [self.control onReceiveRoomInfo:obj];
//        self.roomInfo = obj;
//        if ([obj[@"room"][@"status"] intValue] == 0) {
//            [self.delegate roomPlayPresent:self closeWithData:obj];
//            return;
//        }
//        [RoomContext shared].anchorid = [obj[@"anchor"][@"UserId"] intValue];
//        [[RoomContext shared].playControl receiveRoomInfo:self.roomInfo];
//        [[RoomContext shared].playView playURL:self.roomInfo[@"video"][@"pull"]];
    }
    else if ([req.uri isEqualToString:URI_ROOM_MANAGER]) {
        [RoomContext shared].isManager = true;
    }
    else if ([req.uri isEqualToString:URI_ROOM_BANSTATUS]) {
        [RoomContext shared].isForbidden = true;
    }
//    else if ([req.uri isEqualToString:URI_ROOM_GAME]) {
//        if ([obj isKindOfClass:[NSNull class]]) {
//            return;
//        }
//        [self requestDeskInfo:obj];
//    }
//    else if ([req.uri isEqualToString:URI_GAME_DESK]) {
//        self.deskInfo = obj;
//        [[RoomContext shared].playControl receiveDeskInfo:obj];
//        self.MaxLimit = [obj[@"MaxLimit"] intValue];
//        self.MinLimit = [obj[@"MinLimit"] intValue];
//        [self fetchPostUri:URI_GAME_BET_FEE params:@{
//            @"game_id":obj[@"GameId"],
//            @"minlimit":@(self.MinLimit),
//            @"maxlimit":@(self.MaxLimit)
//        }];
//
//        NSInteger game_id = [obj[@"GameId"] intValue];
//        [[RoomContext shared].playControl.wenluWebView setHidden:true];
//        if (game_id == 1 || game_id == 2) {
//            [[RoomContext shared].playControl.wenluWebView setHidden:false];
//            [self fetchPostUri:URI_GAME_RESULT_LIST params:@{@"game_id":@(game_id), @"boot_num":obj[@"BootNum"], @"desk_id":obj[@"DeskId"]}];
//        }
//    }
//    else if ([req.uri isEqualToString:URI_GAME_BET_FEE]) {
//        self.rules = obj[@"rules"];
//        [[RoomContext shared].playControl receiveBetRules:obj[@"rules"]];
//    }
//    else if ([req.uri isEqualToString:URI_GAME_BET]) {
//        [[RoomContext shared].playControl receiveBetSuccess];
//    }
//    else if ([req.uri isEqualToString:URI_GAME_UNBET]) {
//        [ABUITips showSucceed:@"取消成功"];
//    }
//    else if ([req.uri isEqualToString:URI_FOLLOW_FOLLOW]) {
//        [ABUITips showSucceed:@"关注成功"];
//    }
//    else if ([req.uri isEqualToString:URI_GAME_RESULT_LIST]) {
//        [[RoomContext shared].playControl receiveWenLu:obj[@"list"]];
//    }
//    else if ([req.uri isEqualToString:URI_ACCOUNT_SX_BANLANCE]) {
//        [RoomContext shared].balance = [obj[@"balance"] intValue];
//        [[RoomContext shared].playControl receiveBalance:[obj[@"balance"] intValue]];
//    }
}

@end
