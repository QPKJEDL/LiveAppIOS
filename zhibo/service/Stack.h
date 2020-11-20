//
//  Stack.h
//  zhibo
//
//  Created by qp on 2020/7/8.
//  Copyright © 2020 qp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Stack : NSObject
+ (Stack *)shared;
- (void)set:(id)value key:(NSString *)key;
- (id)get:(NSString *)key;

@property (nonatomic, strong) NSDictionary *giftMap;
@property (nonatomic, strong) NSArray *giftList;

@property (nonatomic, assign) int game_tcpport;
@property (nonatomic, strong) NSString *game_url;
@property (nonatomic, strong) NSString *game_wsurl;

@property (nonatomic, strong) NSMutableDictionary<NSString *, NSNumber *> *commentCountMap;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSNumber *> *likeCountMap;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSNumber *> *followUserMap;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSNumber *> *likeZoneMap;

@property (nonatomic, strong) NSMutableArray *gslogs;
@property (nonatomic, strong) NSMutableArray *httplogs;
- (void)addgslogs:(NSDictionary *)logs;
- (void)addgshttplog:(NSString *)log;
@end

NS_ASSUME_NONNULL_END
