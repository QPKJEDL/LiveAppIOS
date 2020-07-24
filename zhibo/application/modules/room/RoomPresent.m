//
//  RoomPresent.m
//  zhibo
//
//  Created by qp on 2020/7/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RoomPresent.h"

#define ROOMID 11

@interface RoomPresent ()
@property (nonatomic, strong) NSDictionary *gameRule;
@property (nonatomic, strong) NSDictionary *fee;

@property (nonatomic, strong) NSDictionary *roomGame;
@property (nonatomic, strong) NSDictionary *deskInfo;
@end

@implementation RoomPresent
//- (void)requestRoomInfo {
//    [self fetchPostUri:URI_ROOM_INFO params:@{@"room_id":@([RoomContext shared].roomid)}];
//    [self fetchPostUri:URI_ROOM_GIFT params:nil];
//}
//
//- (void)followLiveWithUID:(NSInteger)uid {
//    [self fetchPostUri:URI_FOLLOW_FOLLOW params:@{@"live_uid":@(uid)}];
//}
//
////#pragma mark --------- interface ----------
//- (void)doBet:(NSDictionary *)betInfo {
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:betInfo];
//    [dic setValue:self.gameRule[@"uris"][@"bet"] forKey:@"uri"];
//    [self fetchPostUri:URI_GAME_BET params:dic];
//}
//
//- (void)doBetCancel:(NSDictionary *)info {
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:info];
//    [dic setValue:self.gameRule[@"uris"][@"unbet"] forKey:@"uri"];
//    [self fetchPostUri:URI_GAME_UNBET params:dic];
//}
//
//#pragma mark ---------------- delegates ----------------
//- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
//    if ([req.uri isEqualToString:URI_ROOM_INFO]) { //房间信息
//        self.roomInfo = obj;
//        [RoomContext shared].anchorid = [obj[@"anchor"][@"UserId"] intValue];
//        [self onReceiveRoomInfo];
////        [self fetchPostUri:URI_ROOM_GAME params:@{@"room_id":@(self.roomid)}];
//    }
//    else if ([req.uri isEqualToString:URI_ROOM_GAME]) {
//        if ([obj isKindOfClass:[NSNull class]]) {
//            return;
//        }
//        self.roomGame = obj;
////        self.roomGame = @{@"game_id":@(2), @"desk_id":@(1)};
//        [self fetchPostUri:URI_GAME_DESK params:self.roomGame];
//    }
//    else if ([req.uri isEqualToString:URI_GAME_DESK]) {
//        self.deskInfo = obj;
//        [[RoomContext shared].playControl receiveDeskInfo:self.deskInfo];
//        [self fetchPostUri:URI_GAME_BET_FEE params:self.roomGame];
//    }
//    else if ([req.uri isEqualToString:URI_GAME_BET_FEE]) {
//        self.fee = obj;
//        [self fetchUri:URI_GAME_BET_RULES params:@{@"fee":self.fee, @"desk":self.deskInfo}];
//    }
//    else if ([req.uri isEqualToString:URI_GAME_BET_RULES]) {
//        self.gameRule = obj;
//        [[RoomContext shared].playControl receiveBetRules:self.self.gameRule];
//    }
//    else if ([req.uri isEqualToString:URI_GAME_BET]) {
//        [[RoomContext shared].playControl receiveBetSuccess];
//    }
//    else if ([req.uri isEqualToString:URI_GAME_UNBET]) {
//        [[UIApplication sharedApplication].keyWindow makeToast:@"取消成功" duration:1 position:CSToastPositionCenter];
//    }
//    else if ([req.uri isEqualToString:URI_FOLLOW_FOLLOW]) {
//        [[UIApplication sharedApplication].keyWindow makeToast:@"关注成功" duration:1 position:CSToastPositionCenter];
//    }
//
//}
//
//- (void)onNetRequestFailure:(ABNetRequest *)req err:(ABNetError *)err {
//    if ([req.uri isEqualToString:URI_GAME_BET] || [req.uri isEqualToString:URI_GAME_UNBET]) {
//        [[UIApplication sharedApplication].keyWindow makeToast:err.message duration:1 position:CSToastPositionCenter];
//    }
//    if ([req.uri isEqualToString:URI_FOLLOW_FOLLOW]) {
//       [[UIApplication sharedApplication].keyWindow makeToast:err.message duration:1 position:CSToastPositionCenter];
//    }
//}
//
//- (void)onReceiveRoomInfo {
//
//}
//
//
@end

