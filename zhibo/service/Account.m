//
//  Account.m
//  zhibo
//
//  Created by qp on 2020/7/7.
//  Copyright © 2020 qp. All rights reserved.
//

#import "Account.h"
#import "Dao.h"
@interface Account ()
@property (nonatomic, strong) Dao *dao;
@end
@implementation Account

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dao = [[Dao alloc] init];
        self.dao.fileName = @"account";
        [self.dao load];
    }
    return self;
}

- (void)login:(NSDictionary *)auth {
    if (auth == nil || [auth isKindOfClass:[NSNull class]]) {
        return;
    }
    [self.dao set:auth key:@"account_auth"];
    [self.dao save];
}

- (void)logingm:(NSDictionary *)auth {
    if (auth == nil || [auth isKindOfClass:[NSNull class]]) {
        return;
    }
    [self.dao set:auth key:@"account_auth_gm"];
    [self.dao save];
}

- (void)logout {
    [self.dao del:@"account_auth"];
    [self.dao del:@"account_info"];
    [self.dao del:@"account_bank"];
    [self.dao save];
}

- (BOOL)isLogin {
    NSDictionary *auth = [self.dao get:@"account_auth"];
    if (auth != nil) {
        NSString *token = auth[@"token"];
        return token != nil;
    }
    return false;
}

- (void)setInfo:(NSDictionary *)info {
    [self.dao set:info[@"info"] key:@"account_info"];
    NSMutableDictionary *bankInfo = [[NSMutableDictionary alloc] initWithDictionary:info[@"info"][@"Bank"]];
    NSString *bankcard = [bankInfo stringValueForKey:@"BankCard"];
    if ([bankcard isEqualToString:@"0"]) {
        bankcard = @"";
    }
    [bankInfo setValue:[ABTools returnBankCard:bankcard] forKey:@"bk"];
    [self.dao set:bankInfo key:@"account_bank"];
    [self.dao save];
}

- (void)updateInfo:(NSDictionary *)info {
    NSDictionary *tmp = [self.dao get:@"account_info"];
    if (tmp == nil) {
        return;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:tmp];
    [dic setValuesForKeysWithDictionary:info];
    [self.dao set:dic key:@"account_info"];
    [self.dao save];
}

- (void)updateBank:(NSDictionary *)info{
    NSDictionary *tmp = [self.dao get:@"account_bank"];
    if (tmp == nil) {
        return;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:tmp];
    [dic setValuesForKeysWithDictionary:info];
    [self.dao set:dic key:@"account_bank"];
    [self.dao save];
}

- (NSDictionary *)gmauth {
    return [self.dao get:@"account_auth_gm"];
}


- (NSDictionary *)auth {
    return [self.dao get:@"account_auth"];
}

- (NSInteger)uid {
    return [[self.dao get:@"account_auth"][@"uid"] intValue];
}

- (NSString *)uidStr {
    return [NSString stringWithFormat:@"%@", [self.dao get:@"account_auth"][@"uid"]];
}

- (NSString *)token {
    return [self.dao get:@"account_auth"][@"token"];
}

- (NSString *)gmuid {
    return [NSString stringWithFormat:@"%@", [self.dao get:@"account_auth_gm"][@"userid"]];
}

- (NSString *)gmtoken {
    return [self.dao get:@"account_auth_gm"][@"token"];
}

- (NSDictionary *)info {
    return [self.dao get:@"account_info"];
}

- (NSDictionary *)chatinfo {
    NSDictionary *cc = [self.dao get:@"account_info"];
    if (cc == nil) {
        return @{};
    }
    return @{@"username":cc[@"NickName"], @"userid":cc[@"UserId"], @"icon":@""};
}

- (NSDictionary *)bank {
    return [self.dao get:@"account_bank"];
}
- (NSString *)avatar {
    return [self.dao get:@"account_info"][@"Avater"];
}

- (NSInteger)shenfen {
    NSDictionary *account_info = [self.dao get:@"account_info"];
    return [account_info[@"ShenFen"] integerValue];
}
@end
