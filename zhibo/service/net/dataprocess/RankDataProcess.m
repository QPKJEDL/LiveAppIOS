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
        request.realUri = @"/all_rank";
    }
    return request;
}

/// Called immediately before a request will sent
- (BOOL)canSend:(ABNetRequest *)request {
    NSArray *noLoadings = @[URI_RANK_LIST];
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
    if ([request.uri isEqualToString:URI_RANK_LIST]) {
        NSMutableArray *list = [[NSMutableArray alloc] init];
        
        list = [ABIteration iterationList:response[@"list"] block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
            dic[@"avatar"] = dic[@"avater"];
            dic[@"num"] = @(idx+1);
            dic[@"money"] = [NSString stringWithFormat:@"%@", [dic valueInKeys:@[@"month_get", @"day_send"]]];
            dic[@"native_id"] = @"rankitem";
            return dic;
        }];
        return @{@"list":list};
    }
    return response;
}

- (void)didReceiveError:(ABNetRequest *)request error:(ABNetError *)error {
    [[UIApplication sharedApplication].keyWindow hideToastActivity];
}
@end
