//
//  FollowPresent.m
//  zhibo
//
//  Created by FaiWong on 2020/4/24.
//  Copyright © 2020 qp. All rights reserved.
//

#import "FollowPresent.h"
@interface FollowPresent ()<INetData>
@property (nonatomic, strong) NSArray *dataList;;
@end
@implementation FollowPresent

- (void)requestFollowList {
    if (self.dataList.count == 0) {
        [[UIApplication sharedApplication].keyWindow makeToastActivity:CSToastPositionCenter];
    }
    [self fetchPostUri:URI_FOLLOW_LIST params:nil];
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    [[UIApplication sharedApplication].keyWindow hideToastActivity];
    NSArray *list = [ABIteration iterationList:obj[@"list"] block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
        dic[@"native_id"] = @"user";
        return dic;
    }];
    self.dataList = list;
    [self.delegate present:self onReceiveFollowList:list];
}

- (void)onNetRequestFailure:(ABNetRequest *)req err:(ABNetError *)err {
    [self.delegate present:self onReceiveFailure:err];
    [[UIApplication sharedApplication].keyWindow hideToastActivity];
}

@end
