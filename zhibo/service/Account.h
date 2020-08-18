//
//  Account.h
//  zhibo
//
//  Created by qp on 2020/7/7.
//  Copyright © 2020 qp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Account : NSObject
@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, strong) NSDictionary *auth;
@property (nonatomic, strong) NSDictionary *gmauth;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, strong) NSString *uidStr;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *gmuid;
@property (nonatomic, strong) NSString *gmtoken;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSDictionary *info;
@property (nonatomic, strong) NSDictionary *chatinfo;
@property (nonatomic, strong) NSDictionary *bank;
@property (nonatomic, assign) NSInteger shenfen;
- (void)login:(NSDictionary *)auth;
- (void)logingm:(NSDictionary *)auth;
- (void)logout;

- (void)setInfo:(NSDictionary *)info;
- (void)updateInfo:(NSDictionary *)info;
- (void)updateBank:(NSDictionary *)info;
@end

NS_ASSUME_NONNULL_END
