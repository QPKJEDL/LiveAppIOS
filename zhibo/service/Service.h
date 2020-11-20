//
//  Service.h
//  zhibo
//
//  Created by qp on 2020/6/21.
//  Copyright © 2020 qp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"
NS_ASSUME_NONNULL_BEGIN

@interface Service : NSObject
@property (nonatomic, strong) Account *account;
@property (nonatomic, strong) NSString *gamewsurl;
@property (nonatomic, strong) NSString *gameurl;
@property (nonatomic, strong) NSMutableArray *historyList;
@property (nonatomic, strong) ABMQ *appEventMQ;
- (void)addHistory:(NSDictionary *)item;
- (NSArray *)getHistoryList;

+ (Service *)shared;
- (void)enterBackground;

- (void)saveHTTP:(NSDictionary *)dic;
- (void)refreshGameURL;

- (void)rememberAccount:(NSString *)account password:(NSString *)password;
- (NSString *)rememberAccount;
- (NSString *)rememberPassword;


- (void)followUserWithUid:(NSInteger)uid;
- (void)unfollowUserWithUid:(NSInteger)uid;

- (void)likeMomentWithUid:(NSInteger)uid zone_id:(NSInteger)zone_id;

- (void)applicationWillResignActive;
- (void)applicationDidBecomeActive;
@end

NS_ASSUME_NONNULL_END
