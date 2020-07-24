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
        request.realUri = @"/ChanneRoomList";
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
    if ([request.uri isEqualToString:URI_ROOM_INFO]) {
//        NSDictionary *anchor = response[@"liveinfo"];
//        NSDictionary *video = response[@"list"];
//        NSDictionary *room = response[@"list"];
//        NSDictionary *rank = response[@"giftRankList"];
//        NSInteger *count =
        
        NSDictionary *video = @{@"push":response[@"list"][@"Push"], @"pull":response[@"list"][@"PullRtmp"]};
        NSDictionary *user = response[@"liveinfo"];
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
            @"status":response[@"list"][@"Status"]
        };
        
        return @{@"video":video, @"room":room, @"anchor":user, @"isFollowed":response[@"isFollowed"]};
        
//        NSDictionary *res = response[@"list"];
//        NSDictionary *video = @{@"hls":res[@"PullRtmp"]};
////        NSDictionary *video = @{@"hls":@"http://cctvalih5ca.v.myalicdn.com/live/cctv1_2/index.m3u8"};
//        NSDictionary *user = @{
//            @"name":res[@"LiveName"],
//            @"icon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1587790448617&di=f14b92c18ecbadf438682d2534d7b094&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201707%2F06%2F20170706131313_M25Jr.jpeg", @"fansCount":@"8924"};
//        NSDictionary *audience = @{
//            @"count":[NSString stringWithFormat:@"%@", res[@"RoomCount"]],
//            @"list":@[
//                @"http://cdn.duitang.com/uploads/item/201507/11/20150711140831_KLCfd.jpeg",
//                @"http://pic1.win4000.com/wallpaper/2018-11-17/5befba8de8144.jpg",
//                @"http://pic1.win4000.com/wallpaper/2018-08-03/5b63b40c86d3d.jpg",
//                @"http://img.ewebweb.com/uploads/20191127/13/1574832815-IAhzkoVxXw.jpg",
//                @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1813762643,1914315241&fm=26&gp=0.jpg"
//            ]
//        };
//        return @{@"user":user, @"desk":res, @"audience":audience, @"video":video, @"liveinfo":response[@"liveinfo"], @"isFollowed":response[@"isFollowed"]};
    }
    if ([request.uri isEqualToString:URI_ROOM_LIST]) {
        
        NSDictionary *mm = @{
            @"DeskName":@"DeskName",
            @"DeskId":@"desk_id",
            @"BootNum":@"boot_num",
            @"PaveNum":@"pave_num"
        };
        NSMutableArray *newList = [[NSMutableArray alloc] init];
        NSArray *list = response[@"list"];
//        NSArray *sss = @[
//            @"http://cdn.duitang.com/uploads/item/201507/11/20150711140831_KLCfd.jpeg",
//            @"http://pic1.win4000.com/wallpaper/2018-11-17/5befba8de8144.jpg",
//            @"http://pic1.win4000.com/wallpaper/2018-08-03/5b63b40c86d3d.jpg",
//            @"http://img.ewebweb.com/uploads/20191127/13/1574832815-IAhzkoVxXw.jpg",
//            @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1813762643,1914315241&fm=26&gp=0.jpg"
//        ];
        for (NSDictionary *item in list) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:item];
            NSMutableDictionary *submit = [[NSMutableDictionary alloc] init];
            for (NSString *key in mm.allKeys) {
                if (dic[key] != nil) {
                    [submit setValue:dic[key] forKey:mm[key]];
                }
            }
//            dic[@"CoverImg"] = sss[random()%sss.count];
            dic[@"submit"] = submit;
            [newList addObject:dic];
        }
        
        return @{@"list":newList};
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
    return response;
}

- (void)didReceiveError:(ABNetRequest *)request error:(ABNetError *)error {
    [[UIApplication sharedApplication].keyWindow hideToastActivity];
}
@end
