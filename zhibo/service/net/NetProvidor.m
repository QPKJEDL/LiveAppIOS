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
    NSArray *baijiusansan = @[URI_ACCOUNT_DRAWPER, URI_MOMENTS_PUBLISH, URI_ACCOUNT_INFO_UPDATE_AVATAR, URI_ACCOUNT_CASHOUT, URI_TENCENT_COSSECRET, URI_ACCOUNT_BALANCE_RECHARGE, URI_ACCOUNT_RECHARGE_CHANNELS, URI_VERSION, URI_ROOM_SYSTEM];
    
    NSString *port = @"8212";
    if ([baijiusansan containsObject:uri]) {
        port = @"8933";
    }
    return [NSString stringWithFormat:@"%@:%@",self.host, port];
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

- (NSString *)responseContentType:(NSString *)uri {
    if ([uri isEqualToString:URI_ACCOUNT_DOMAIN]) {
        return @"text/plain";
    }
    return @"application/json";
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
