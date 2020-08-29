//
//  Stack.m
//  zhibo
//
//  Created by qp on 2020/7/8.
//  Copyright © 2020 qp. All rights reserved.
//

#import "Stack.h"
@interface Stack ()
@property (nonatomic, strong) NSDictionary *dic;
@end
@implementation Stack
+ (Stack *)shared {
    static Stack *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dic = [[NSMutableDictionary alloc] init];
        self.commentCountMap = [[NSMutableDictionary alloc] init];
        self.likeCountMap = [[NSMutableDictionary alloc] init];
        self.likeZoneMap = [[NSMutableDictionary alloc] init];
        self.followUserMap = [[NSMutableDictionary alloc] init];
    }
    return self;
}
- (void)set:(id)value key:(NSString *)key {
    [self.dic setValue:value forKey:key];
}
- (id)get:(NSString *)key {
    return self.dic[key];
}

- (NSString *)game_wsurl {
    if (_game_wsurl == nil) {
        return @"hqgame.zbzx6088.com";
    }
    return _game_wsurl;
}

- (NSString *)game_url {
    if (_game_url == nil) {
        return @"https://hqgame.zbzx6088.com:8215";
    }
    return _game_url;
}

- (int)game_tcpport {
    if (_game_tcpport == 0) {
        return 24430;
    }
    return _game_tcpport;
}
@end
