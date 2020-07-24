//
//  MessageDataPrecess.m
//  zhibo
//
//  Created by qp on 2020/7/11.
//  Copyright © 2020 qp. All rights reserved.
//

#import "MessageDataPrecess.h"

@implementation MessageDataPrecess
/// Called to modify a request before sending.
- (ABNetRequest *)prepare:(ABNetRequest *)request {
    if ([request.uri isEqualToString:URI_MESSAGE_LIST]) {
        request.realUri = @"/notice_list";
    }
    return request;
}

/// Called immediately before a request will sent
- (BOOL)canSend:(ABNetRequest *)request {
    if ([request.uri isEqualToString:URI_MESSAGE_LIST]) {
        if ([request.params[@"type"] intValue] == 0) {
            return false;
        }
    }
    return true;
}

/// Called immediately before a request is sent over the network (or stubbed).
- (void)willSend:(ABNetRequest *)request {
    
}


- (void)endSend:(ABNetRequest *)request {
    
}
/// Called to modify a result before completion.
- (void)didReceive:(ABNetRequest *)request response:(NSDictionary *)response {
    
}

/// Called to modify a result before completion.
- (NSDictionary *)process:(ABNetRequest *)request response:(NSDictionary *)response {
    if ([request.uri isEqualToString:URI_MESSAGE_LIST]) {
        NSInteger type = [request.params[@"type"] intValue];
        if (type == 0) {
            return @{@"list":@[
                             @{
                                 @"title":@"系统公告",
                                 @"content":@"您有新的系统消息",
                                 @"time":@"12-19",
                                 @"native_id":@"message",
                                 @"icon":@"gonggao",
                                 @"h":@(50)
                             }
            ]};
        }else {
            NSArray *list = [ABIteration iterationList:response[@"list"] block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
                NSString *content = dic[@"content"];
                CGFloat h = [content sizeWithFont:[UIFont PingFangSC:12] constrainedToSize:CGSizeMake(SCREEN_WIDTH-26-26, MAXFLOAT)].height;
                NSString *creatime = dic[@"creatime"];
                dic[@"time"] = [ABTime timestampToTime:creatime format:nil];
                dic[@"native_id"] = @"notice";
                dic[@"h"] = @(h);
                return dic;
            }];
            
            return @{@"list":list};
        }
        
    }
    return response;
}
- (void)didReceiveError:(ABNetRequest *)request error:(ABNetError *)error {
   
}
@end
