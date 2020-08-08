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
    if ([uri isEqualToString:URI_MOMENTS_PUBLISH]) {
        return @"http://129.211.114.135:8933";
    }
    return @"http://129.211.114.135:8212";
//    return @"http://192.168.0.114:8212";
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
