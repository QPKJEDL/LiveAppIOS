//
//  LoginRegPresent.h
//  zhibo
//
//  Created by qp on 2020/6/21.
//  Copyright © 2020 qp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class LoginRegPresent;
@protocol LoginRegPresentDelegate <NSObject>

- (void)loginReqPresent:(LoginRegPresent *)loginReqPresent onLoginSuccess:(NSDictionary *)data;
- (void)loginReqPresent:(LoginRegPresent *)loginReqPresent onRegisterSuccess:(NSDictionary *)data;
@end

@interface LoginRegPresent : NSObject<INetData>
@property (nonatomic, weak) id<LoginRegPresentDelegate> delegate;
- (void)login:(NSString *)username passsword:(NSString *)password;
- (void)reg:(NSString *)username nickname:(NSString *)nickname passsword:(NSString *)password;
@end

NS_ASSUME_NONNULL_END
