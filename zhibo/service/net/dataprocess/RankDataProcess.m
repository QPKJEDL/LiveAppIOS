//
//  RankDataProcess.m
//  zhibo
//
//  Created by qp on 2020/7/28.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RankDataProcess.h"

@implementation RankDataProcess

/// Called to modify a request before sending.
- (ABNetRequest *)prepare:(ABNetRequest *)request {
    if ([request.uri isEqualToString:URI_RANK_LIST]) {
        request.realUri = @"/ChanneRoomList";
    }
    return request;
}

/// Called immediately before a request will sent
- (BOOL)canSend:(ABNetRequest *)request {
    NSArray *noLoadings = @[URI_RANK_LIST];
    if ([noLoadings containsObject:request.uri] == false) {
        [[UIApplication sharedApplication].keyWindow makeToastActivity:CSToastPositionCenter];
    }
    
    if ([request.uri isEqualToString:URI_RANK_LIST]) {
        return false;
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
    if ([request.uri isEqualToString:URI_RANK_LIST]) {
        NSMutableArray *list = [[NSMutableArray alloc] init];
        
        NSArray *medias = @[
            @{
                @"src":@"https://t9.baidu.com/it/u=1307125826,3433407105&fm=79&app=86&size=h300&n=0&g=4n&f=jpeg?sec=1596502890&t=7ab16257accaa3889c12cdf50928ac61",
                @"native_id":@"imageitem"
            },
            @{
                @"src":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1595911329814&di=34d5d8ca38f96f8ba2b0be34730e81e7&imgtype=0&src=http%3A%2F%2Ft9.baidu.com%2Fit%2Fu%3D2268908537%2C2815455140%26fm%3D79%26app%3D86%26f%3DJPEG%3Fw%3D1280%26h%3D719",
                @"native_id":@"imageitem"
            }
        
        ];
        
        [list addObject:@{
            @"avatar":@"http://img4.imgtn.bdimg.com/it/u=4115908174,1099783141&fm=214&gp=0.jpg",
            @"nickname":@"还好",
            @"content":@"你们还好吗",
            @"time":@"3分钟前",
            @"content_height":@"50",
            @"like_count":@"89",
            @"comment_count":@"20",
            @"medias":medias,
            @"native_id":@"rankitem",
            @"num":@"1",
        }];
        [list addObject:@{
            @"avatar":@"http://img.tupianzj.com/uploads/allimg/151222/9-151222215T0.jpg",
            @"nickname":@"还好",
            @"content":@"你们还好吗",
            @"time":@"3分钟前",
            @"content_height":@"50",
            @"like_count":@"89",
            @"comment_count":@"20",
            @"medias":medias,
            @"native_id":@"rankitem",
            @"num":@"2",
        }];
        [list addObject:@{
            @"avatar":@"http://img.tupianzj.com/uploads/allimg/151222/9-151222215T0.jpg",
            @"nickname":@"还好",
            @"content":@"你们还好吗",
            @"time":@"3分钟前",
            @"content_height":@"50",
            @"like_count":@"89",
            @"comment_count":@"20",
            @"medias":medias,
            @"native_id":@"rankitem",
            @"num":@"3",
        }];
        [list addObject:@{
            @"avatar":@"http://img.tupianzj.com/uploads/allimg/151222/9-151222215T0.jpg",
            @"nickname":@"还好",
            @"content":@"你们还好吗",
            @"time":@"3分钟前",
            @"content_height":@"50",
            @"like_count":@"89",
            @"comment_count":@"20",
            @"medias":medias,
            @"native_id":@"rankitem",
            @"num":@"4",
        }];
        [list addObject:@{
            @"avatar":@"http://img.tupianzj.com/uploads/allimg/151222/9-151222215T0.jpg",
            @"nickname":@"还好",
            @"content":@"你们还好吗",
            @"time":@"3分钟前",
            @"content_height":@"50",
            @"like_count":@"89",
            @"comment_count":@"20",
            @"medias":medias,
            @"native_id":@"rankitem",
            @"num":@"5",
        }];
        [list addObject:@{
            @"avatar":@"http://img.tupianzj.com/uploads/allimg/151222/9-151222215T0.jpg",
            @"nickname":@"还好",
            @"content":@"你们还好吗",
            @"time":@"3分钟前",
            @"content_height":@"50",
            @"like_count":@"89",
            @"comment_count":@"20",
            @"medias":medias,
            @"native_id":@"rankitem",
            @"num":@"6",
        }];
        
        return @{@"list":list};
    }
    return response;
}

- (void)didReceiveError:(ABNetRequest *)request error:(ABNetError *)error {
    [[UIApplication sharedApplication].keyWindow hideToastActivity];
}
@end
