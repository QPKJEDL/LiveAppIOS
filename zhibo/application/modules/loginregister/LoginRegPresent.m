//
//  LoginRegPresent.m
//  zhibo
//
//  Created by qp on 2020/6/21.
//  Copyright © 2020 qp. All rights reserved.
//

#import "LoginRegPresent.h"
@interface LoginRegPresent ()

@end
@implementation LoginRegPresent

- (void)login:(NSString *)username passsword:(NSString *)password {
    [ABUITips showLoading];
    [self fetchPostUri:URI_ACCOUNT_LOGIN params:@{@"account":username, @"password":password}];
    [[Service shared] rememberAccount:username password:password];
}

- (void)login:(NSString *)phone code:(NSString *)code {
    [ABUITips showLoading];
    [self fetchPostUri:URI_ACCOUNT_LOGIN params:@{@"mobile":phone, @"code":code, @"type":@"phone"}];
}

- (void)reg:(NSString *)username nickname:(NSString *)nickname passsword:(NSString *)password {
    [ABUITips showLoading];
    [self fetchPostUri:URI_ACCOUNT_REGISTER params:@{@"nickname":nickname ,@"account":username, @"password":password}];
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    if ([req.uri isEqualToString:URI_ACCOUNT_LOGIN]) {
        [[Service shared].account login:@{@"uid":obj[@"uid"], @"token":obj[@"token"]}];
        [[Service shared].account logingm:@{@"userid":obj[@"game_uid"], @"token":obj[@"game_token"]}];
        [[Service shared] saveHTTP:obj];
        [self fetchPostUri:URI_ACCOUNT_INFO params:nil];
    }
    else if ([req.uri isEqualToString:URI_ACCOUNT_INFO]){
        [[UIApplication sharedApplication].keyWindow hideToastActivity];
        [[Service shared].account setInfo:obj];
        if (self.delegate && [self.delegate respondsToSelector:@selector(loginReqPresent:onLoginSuccess:)]) {
            [self.delegate loginReqPresent:self onLoginSuccess:obj];
        }
        
//        [self fetchPostUri:URI_GAME_LOGIN params:@{@"account":@"13111111144", @"password":@"123456"}];
    }
    else if ([req.uri isEqualToString:URI_ACCOUNT_REGISTER]) {
        [ABUITips showSucceed:@"注册成功,登录中..."];
        [self fetchPostUri:URI_ACCOUNT_LOGIN params:req.params];
    }
    else if ([req.uri isEqualToString:URI_GAME_LOGIN]) {
        [[Service shared].account logingm:obj];
    }
    
}

- (void)onNetRequestFailure:(ABNetRequest *)req err:(ABNetError *)err {
    [[UIApplication sharedApplication].keyWindow hideToastActivity];
    [ABUITips showError:err.message];
    NSLog(@"%@", [err des]);
}
@end
