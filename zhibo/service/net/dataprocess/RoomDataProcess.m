//
//  LiveDataProcess.m
//  zhibo
//
//  Created by qp on 2020/6/23.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RoomDataProcess.h"

@implementation RoomDataProcess
/// Called to modify a request before sending.
- (ABNetRequest *)prepare:(ABNetRequest *)request {
    if ([request.uri isEqualToString:URI_ROOM_LIST]) {
        if ([request.params[@"channe_id"] intValue] == -1) {
            request.realUri = @"/FollowListRoom";
            request.realParams = @{@"lastid":@"0"};
        }else{
            request.realUri = @"/ChanneRoomList";
        }
//        request.realUri = @"/RoomList";
    }
    if ([request.uri isEqualToString:URI_ROOM_INFO]) {
        request.realUri = @"/RoomInfo";
//        request.realParams = @{@"room_id":request.params[@"RoomId"]};
    }
    if ([request.uri isEqualToString:URI_ROOM_SETCOVER]) {
        request.realUri = @"/SetCover";
    }
    if ([request.uri isEqualToString:URI_ROOM_LABELS]) {
        request.realUri = @"/GetLabel";
    }
    if ([request.uri isEqualToString:URI_ROOM_CHANNEL]) {
        request.realUri = @"/GetHasChannel";
    }
    if ([request.uri isEqualToString:URI_ROOM_GIFT]) {
        request.realUri = @"/GetGift";
    }
    if ([request.uri isEqualToString:URI_ROOM_GAME]) {
        request.realUri = @"/GetRoomGameInfo";
    }
    if ([request.uri isEqualToString:URI_ROOM_SETGAME]) {
        request.realUri = @"/RoomGameInfo";
    }
    if ([request.uri isEqualToString:URI_ROOM_CLOSE]) {
        request.realUri = @"/LiveOver";
    }
    if ([request.uri isEqualToString:URI_ROOM_MANAGER]) {
        request.realUri = @"/Manager";
    }
    if ([request.uri isEqualToString:URI_ROOM_SETMANAGER]) {
        request.realUri = @"/SetRoomManager";
    }
    if ([request.uri isEqualToString:URI_ROOM_RMMANAGER]) {
        request.realUri = @"/RelieveRoomManager";
    }
    if ([request.uri isEqualToString:URI_ROOM_BAN]) {
        request.realUri = @"/BanUser";
    }
    if ([request.uri isEqualToString:URI_ROOM_UNBAN]) {
        request.realUri = @"/RelieveBan";
    }
    if ([request.uri isEqualToString:URI_ROOM_BANSTATUS]) {
        request.realUri = @"/BanList";
    }
    if ([request.uri isEqualToString:URI_ROOM_GIFTRANK]) {
        request.realUri = @"/GetGiftRankList";
    }
    if ([request.uri isEqualToString:URI_ROOM_KICK]) {
        request.realUri = @"/KickRoom";
    }
    if ([request.uri isEqualToString:URI_ROOM_MANAGERLIST]) {
        request.realUri = @"/RoomLiveManager";
    }
    if ([request.uri isEqualToString:URI_ROOM_SEND_GIFT]) {
        request.realUri = @"/send_gift";
    }
    if ([request.uri isEqualToString:URI_ROOM_GIFTRECORD]) {
        request.realUri = @"/gift_record";
    }
    return request;
}

/// Called immediately before a request will sent
- (BOOL)canSend:(ABNetRequest *)request {
    
    NSArray *noLoadings = @[URI_ROOM_SEND_GIFT];
    
    if ([noLoadings containsObject:request.uri] == false) {
        [[UIApplication sharedApplication].keyWindow makeToastActivity:CSToastPositionCenter];
    }
        
    
    return true;
}

/// Called immediately before a request is sent over the network (or stubbed).
- (void)willSend:(ABNetRequest *)request {
    
}

/// Called to modify a result before completion.
- (void)didReceive:(ABNetRequest *)request response:(NSDictionary *)response {
    
}

/// Called to modify a result before completion.
- (NSDictionary *)process:(ABNetRequest *)request response:(NSDictionary *)response {
    [[UIApplication sharedApplication].keyWindow hideToastActivity];
//    if ([request.uri isEqualToString:URI_ROOM_LIST]) {
//        NSMutableArray *list = [[NSMutableArray alloc] init];
//        [list addObject:@{
//            @"LiveName":@"小白",
//            @"CoverImg":@"",
//            @"RoomCount":@(400)
//        }];
//        [list addObject:@{
//            @"LiveName":@"小紫",
//            @"CoverImg":@"",
//            @"RoomCount":@(2000)
//        }];
//        [list addObject:@{
//            @"LiveName":@"小绿",
//            @"CoverImg":@"",
//            @"RoomCount":@(2200)
//        }];
//        [list addObject:@{
//            @"LiveName":@"小粉",
//            @"CoverImg":@"",
//            @"RoomCount":@(3000)
//        }];
//
//        return @{@"list":list};
//    }
    if ([request.uri isEqualToString:URI_ROOM_INFO]) {
//        NSDictionary *anchor = response[@"liveinfo"];
//        NSDictionary *video = response[@"list"];
//        NSDictionary *room = response[@"list"];
//        NSDictionary *rank = response[@"giftRankList"];
//        NSInteger *count =
        
        NSDictionary *video = @{@"push":response[@"list"][@"Push"], @"pull":response[@"list"][@"PullRtmp"]};
        NSDictionary *user = response[@"liveinfo"];
        NSInteger status = [response[@"list"][@"Status"] intValue];
        NSDictionary *room = @{
            @"room_id":response[@"list"][@"RoomId"],
            @"roomcount":response[@"list"][@"RoomCount"],
            @"label":response[@"list"][@"Label"],
            @"channel":response[@"list"][@"Channel"],
            @"coverimg":response[@"list"][@"CoverImg"],
            @"covername":response[@"list"][@"CoverName"],
            @"starttime":response[@"list"][@"StartTime"],
            @"systime":response[@"list"][@"SysTime"],
            @"endtime":response[@"list"][@"EndTime"],
            @"rank":response[@"giftRankList"],
            @"status":@(status)
        };
        
        
        return @{@"video":video, @"room":room, @"anchor":user, @"isFollowed":response[@"isFollowed"]};
    }
    if ([request.uri isEqualToString:URI_ROOM_LIST]) {
        NSDictionary *nResponse = response;
        if ([request.realUri isEqualToString:@"/FollowListRoom"]) {
            nResponse = @{@"is_more":@(false), @"RoomList":response[@"list"]};
        }
        
        NSDictionary *map = @{
            @"百家乐":@"icon_baijiale",
            @"龙虎":@"icon_longhu",
            @"牛牛":@"icon_niuniu",
            @"三公":@"icon_sangong",
            @"A89":@"icon_a89"
        };
        NSArray *list = nResponse[@"RoomList"];
        list = [ABIteration iterationList:list block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
            dic[@"native_id"] = @"anchoritem";
            if (dic[@"LiveName"] != nil) {
                dic[@"nickname"] = dic[@"LiveName"];
            }
            dic[@"avatar"] = [dic valueInKeys:@[@"CoverImg", @"avater"]];
            if (dic[@"RoomCount"] != nil) {
                dic[@"roomcount"] = dic[@"RoomCount"];
            }
            dic[@"uid"] = [dic valueInKeys:@[@"LiveUid", @"live_uid"]];
            NSString *channel = dic[@"Channel"];
            if (map[channel] != nil && [dic[@"Status"] intValue] == 1) {
                dic[@"game_icon"] = map[channel];
            }
            dic[@"last_id"] = request.params[@"last_id"];
            NSString *roomName = dic[@"CoverName"];
            if (roomName.length == 0) {
                roomName = dic[@"nickname"];
            }
            dic[@"roomname"] = roomName;
            return dic;
        }];
        
        return @{@"list":list, @"ismore":nResponse[@"is_more"]};
        
//        NSDictionary *mm = @{
//            @"DeskName":@"DeskName",
//            @"DeskId":@"desk_id",
//            @"BootNum":@"boot_num",
//            @"PaveNum":@"pave_num"
//        };
//        NSMutableArray *newList = [[NSMutableArray alloc] init];
//        NSArray *list = response[@"list"];
//
//        for (NSDictionary *item in list) {
//            NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:item];
//            NSMutableDictionary *submit = [[NSMutableDictionary alloc] init];
//            for (NSString *key in mm.allKeys) {
//                if (dic[key] != nil) {
//                    [submit setValue:dic[key] forKey:mm[key]];
//                }
//            }
////            dic[@"CoverImg"] = sss[random()%sss.count];
//            dic[@"submit"] = submit;
//            [newList addObject:dic];
//        }
//
//        return @{@"list":newList};
    }
    if ([request.uri isEqualToString:URI_ROOM_GIFT]) {
        NSArray *giftList = response[@"list"];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [giftList enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [dic setValue:obj forKey:[NSString stringWithFormat:@"%@", obj[@"id"]]];
        }];
        [Stack shared].giftMap = dic;
        [Stack shared].giftList = giftList;
    }
    
    if ([request.uri isEqualToString:URI_ROOM_GAME]) {
//        return @{
//            @"desk_id": @"2",
//            @"game_type": @"3",
//            @"room_id": @"10000"
//        };
    }
    if ([request.uri isEqualToString:URI_ROOM_GIFTRECORD]) {
        
    }
    
    return response;
}

- (void)didReceiveError:(ABNetRequest *)request error:(ABNetError *)error {
    [[UIApplication sharedApplication].keyWindow hideToastActivity];
}
@end
