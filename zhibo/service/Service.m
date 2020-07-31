//
//  Service.m
//  zhibo
//
//  Created by qp on 2020/6/21.
//  Copyright © 2020 qp. All rights reserved.
//

#import "Service.h"
#import "Dao.h"
@interface Service ()<INetData>
@property (nonatomic, strong) Dao *dao;

@end
@implementation Service
+ (Service *)shared {
    static Service *instance = nil;
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
        self.dao = [[Dao alloc] init];
        [self.dao load];
        
        self.account = [[Account alloc] init];
        
        self.historyList = [self.dao get:@"history"];
        if (self.historyList == nil) {
            self.historyList = [[NSMutableArray alloc] init];
        }
        
    }
    return self;
}

- (void)addHistory:(NSDictionary *)item {
    NSInteger roomid = [item[@"RoomId"] intValue];
    NSArray *list = [ABIteration filter:[[Service shared] getHistoryList] block:^BOOL(NSMutableDictionary * _Nonnull dic) {
        return [dic[@"RoomId"] intValue] != roomid;
    }];

    self.historyList = [[NSMutableArray alloc] initWithArray:list];
    [self.historyList insertObject:item atIndex:0];
}

- (NSArray *)getHistoryList {
    return self.historyList;
}

- (void)saveHTTP:(NSDictionary *)dic {
    [self.dao set:dic key:@"http"];
    [self.dao save];
}

- (NSString *)gamewsurl {
    return [self.dao get:@"http"][@"game_wsurl"];
}

- (NSString *)gameurl {
    return [self.dao get:@"http"][@"game_url"];
}

- (void)enterBackground {
    [self.dao set:self.historyList key:@"history"];
    [self.dao save];
}

//- (BOOL)isLogin {
//    NSDictionary *dic = [self.dao get:@"user"];
//    if (dic != nil) {
//        NSString *token = dic[@"token"];
//        return token != nil;
//    }
//    return false;
//}
//
//- (void)login:(NSDictionary *)dic {
//    if (dic == nil || [dic isKindOfClass:[NSNull class]]) {
//        return;
//    }
//    NSMutableDictionary *tmpdic = [[NSMutableDictionary alloc] initWithDictionary:dic];
////    [tmpdic setValue:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1587790448617&di=f14b92c18ecbadf438682d2534d7b094&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201707%2F06%2F20170706131313_M25Jr.jpeg" forKey:@"icon"];
//    [self.dao set:tmpdic key:@"user"];
//    [self.dao save];
//}
//
//
//- (void)logout {
//    [self.dao del:@"user"];
//    [self.dao save];
//}

- (NSDictionary *)userInfo {
    NSDictionary *user = [self.dao get:@"user"];
    if (user == nil) {
        return @{};
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if (user[@"username"] != nil) {
        dic[@"username"] = user[@"username"];
    }
    if (user[@"userid"] != nil) {
        dic[@"userid"] = user[@"userid"];
    }
    if (user[@"icon"] != nil) {
        dic[@"icon"] = user[@"icon"];
    }
    return dic;
}

- (NSDictionary *)authInfo {
    NSDictionary *user = [self.dao get:@"user"];
    return user;
}

- (NSDictionary *)httpHeaders {
    NSDictionary *dic = [self.dao get:@"user"];
    NSString *userid = dic[@"uid"];
    NSString *token = dic[@"token"];
    
    NSMutableDictionary *hh = [[NSMutableDictionary alloc] init];
    if (userid != nil) {
        [hh setValue:userid forKey:@"userid"];
        [hh setValue:userid forKey:@"uid"];
        [hh setValue:userid forKey:@"user_id"];
    }
    
    if (token != nil) {
        [hh setValue:token forKey:@"token"];
    }
    
    return hh;
}

- (int)uid {
    return [[self.dao get:@"user"][@"userid"] intValue];
}

- (NSString *)token {
    return [self.dao get:@"user"][@"token"];
}

- (void)refreshGameURL {
    [self fetchPostUri:@"/weburl" params:nil];
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    if ([req.uri isEqualToString:@"/weburl"]) {
        [Stack shared].game_tcpport = [obj[@"game_tcpport"] intValue];
        [Stack shared].game_url = obj[@"game_url"];
        [Stack shared].game_wsurl = obj[@"game_wsurl"];
    }
    if ([req.uri isEqualToString:URI_FOLLOW_FOLLOW]) {
        [ABUITips showSucceed:@"关注成功"];
        [[ABMQ shared] publish:@"" channel:CHANNEL_FOLLOW_CHANGED];
    }
    if ([req.uri isEqualToString:URI_FOLLOW_UNFOLLOW]) {
        [ABUITips showSucceed:@"取关成功"];
        [[ABMQ shared] publish:@"" channel:CHANNEL_FOLLOW_CHANGED];
    }
    if ([req.uri isEqualToString:URI_MOMENTS_LIKE]) {
        [ABUITips showSucceed:@"点赞成功"];
        [[ABMQ shared] publish:@"" channel:CHANNEL_LIKE_CHANGED];
    }
}

- (void)rememberAccount:(NSString *)account password:(NSString *)password {
    [self.dao set:account key:@"last_account"];
    [self.dao set:password key:@"last_password"];
    [self.dao save];
}


- (NSString *)rememberAccount {
    return [self.dao get:@"last_account"];
}

- (NSString *)rememberPassword {
    return [self.dao get:@"last_password"];
}

- (void)followUserWithUid:(NSInteger)uid {
    [self fetchPostUri:URI_FOLLOW_FOLLOW params:@{@"live_uid":@(uid)}];
}

- (void)unfollowUserWithUid:(NSInteger)uid {
    QMUIAlertAction *action1 = [QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:NULL];
    QMUIAlertAction *action2 = [QMUIAlertAction actionWithTitle:@"确定" style:QMUIAlertActionStyleDestructive handler:^(__kindof QMUIAlertController * _Nonnull aAlertController, QMUIAlertAction * _Nonnull action) {
        [self fetchPostUri:URI_FOLLOW_UNFOLLOW params:@{@"live_uid":@(uid)}];
    }];
    QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:@"确定不在关注此人？" message:nil preferredStyle:QMUIAlertControllerStyleAlert];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController showWithAnimated:YES];
    
}

- (void)likeMomentWithUid:(NSInteger)uid zone_id:(NSInteger)zone_id {
    [self fetchPostUri:URI_MOMENTS_LIKE params:@{@"live_uid":@(uid), @"zone_id":@(zone_id)}];
}
@end
