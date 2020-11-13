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
//    NSArray *noLoadings = @[URI_RANK_LIST];
//    if ([noLoadings containsObject:request.uri] == false) {
//        [[UIApplication sharedApplication].keyWindow makeToastActivity:CSToastPositionCenter];
//    }
    

    return true;
}

/// Called immediately before a request is sent over the network (or stubbed).
- (void)willSend:(ABNetRequest *)request {
    [ABUITips showLoading];
}

- (void)endSend:(ABNetRequest *)request {
    [ABUITips hideLoading];
}

/// Called to modify a result before completion.
- (void)didReceive:(ABNetRequest *)request response:(NSDictionary *)response {
    
}

/// Called to modify a result before completion.
- (NSDictionary *)process:(ABNetRequest *)request response:(NSDictionary *)response {
    [[UIApplication sharedApplication].keyWindow hideToastActivity];
    if ([request.uri isEqualToString:URI_RANK_LIST]) {
        NSArray *olist = response[@"list"];
        if (olist == nil || [olist isKindOfClass:[NSNull class]]) {
            olist = @[];
        }
        NSMutableArray *list = [[NSMutableArray alloc] initWithArray:olist];
        NSInteger cha = 3-list.count;
        if (cha > 0) {
            for (int i=0; i<cha; i++) {
                [list addObject:@{
                    @"avater":@"",
                    @"nickname":@"暂无席位",
                    @"all_get":@"0",
                }];
            }
        }
        
        list = [ABIteration iterationList:list block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
            dic[@"avatar"] = dic[@"avater"];
            dic[@"num"] = @(idx+1);
            NSString *money = [NSString stringWithFormat:@"%@", [dic valueInKeys:@[@"month_get",@"all_get", @"day_send",@"all_send",@"win_rate",@"all_rate"]]];
            money = [money componentsSeparatedByString:@"."][0];
            if ([[dic allKeys] containsObject:@"win_rate"] || [[dic allKeys] containsObject:@"all_rate"]) {
                money = [NSString stringWithFormat:@"%@%%", money];
            }
            dic[@"money"] = money;
            CGFloat cmoney = [money floatValue]/100;
            dic[@"cmoney"] = [NSString stringWithFormat:@"%.2f", cmoney];
            dic[@"native_id"] = @"rankitem";
            return dic;
        }];
        return @{@"list":list};
    }
    return response;
}

- (void)didReceiveError:(ABNetRequest *)request error:(ABNetError *)error {
    [[UIApplication sharedApplication].keyWindow hideToastActivity];
    [ABUITips showError:error.message];
}
@end
