//
//  MinePresent.m
//  zhibo
//
//  Created by FaiWong on 2020/4/25.
//  Copyright © 2020 qp. All rights reserved.
//

#import "MinePresent.h"
@interface MinePresent ()<INetData>
@end
@implementation MinePresent
- (void)refreshTopInfo {
    [self receiveInfo];
    
    [self fetchPostUri:URI_ACCOUNT_INFO params:nil];
}

- (void)receiveInfo {
    NSDictionary *info = [Service shared].account.info;
    [self.delegate minePresent:self onReceiveTopInfo:info];
}
- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    if ([req.uri isEqualToString:URI_ACCOUNT_INFO]){
        [[UIApplication sharedApplication].keyWindow hideToastActivity];
        [[Service shared].account setInfo:obj];
        
        [self receiveInfo];
    }
}

@end
