//
//  NetProvidor.m
//  zhibo
//
//  Created by qp on 2020/6/17.
//  Copyright © 2020 qp. All rights reserved.
//

#import "NetProvidor.h"
#import "Service.h"
@implementation NetProvidor
- (NSString *)host:(NSString *)uri {
    
    if ([uri hasPrefix:@"/game"]) {
        return [Stack shared].game_url;
    }
    NSArray *baijiusansan = @[URI_ACCOUNT_DRAWPER, URI_MOMENTS_PUBLISH, URI_ACCOUNT_INFO_UPDATE_AVATAR, URI_ACCOUNT_CASHOUT, URI_TENCENT_COSSECRET, URI_ACCOUNT_BALANCE_RECHARGE, URI_ACCOUNT_RECHARGE_CHANNELS, URI_VERSION];
    
    if (ISENABLESSL == 1) {
        if ([baijiusansan containsObject:uri]) {
            return @"https://live.zbzx6088.com:8933";
        }
        return @"https://live.zbzx6088.com:8215";
    }else{
        if ([baijiusansan containsObject:uri]) {
            return @"http://119.28.78.169:8933";
        }
        return @"http://119.28.78.169:8212";
    }
}

- (NSDictionary *)headers:(NSString *)uri {
    if ([uri hasPrefix:@"/game"]) {
        return [[Service shared].account gmauth];
    }
    return [[Service shared].account auth];
}

- (NSString *)dataKey {
    return @"data";
}

- (NSString *)dataKey:(ABNetRequest *)request {
//    if ([request.uri isEqualToString:URI_TENCENT_COSSECRET]) {
//        return @"credentials";
//    }
    return @"data";
}
- (NSString *)contentType {
    return @"application/x-www-form-urlencoded";
}

- (NSString *)msgKey:(ABNetRequest *)request {
    return @"info";
}

- (NSString *)codeKey:(ABNetRequest *)request {
    return @"status";
}

- (NSInteger)successCode:(ABNetRequest *)request {
    return 1;
}

@end
