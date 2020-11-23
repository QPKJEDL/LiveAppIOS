//
//  AnchorPresent.m
//  zhibo
//
//  Created by FaiWong on 2020/4/24.
//  Copyright © 2020 qp. All rights reserved.
//

#import "AnchorPresent.h"
@interface AnchorPresent ()<INetData>
@property (nonatomic, strong) NSString *lastTime;
@end
@implementation AnchorPresent
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.anchorList = [[NSMutableArray alloc] init];
        self.isPullRefresh = true;
    }
    return self;
}
- (void)getAnchorList:(NSDictionary *)props {
    if (self.anchorList.count == 0) {
        [ABUITips showLoading];
    }
    if (self.anchorList.count == 0 || self.isPullRefresh == true) {
        [self fetchPostUri:URI_ROOM_LIST params:@{@"channe_id":props[@"id"], @"last_id":@"0"}];
    }else{
        NSInteger last_id = [[self.anchorList lastObject][@"last_id"] intValue];
        [self fetchPostUri:URI_ROOM_LIST params:@{@"channe_id":props[@"id"], @"last_id":@(last_id+1)}];
    }
}


- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
   [[UIApplication sharedApplication].keyWindow hideToastActivity];
    NSMutableArray *list = obj[@"list"];
    if (self.isPullRefresh) {
        self.anchorList = list;
    }else{
        [self.anchorList addObjectsFromArray:list];
    }
    self.isPullRefresh = false;
    
    [self.delegate onReceiveAnchorList:[obj[@"ismore"] boolValue]];
}

- (void)onNetRequestFailure:(ABNetRequest *)req err:(ABNetError *)err {
     [[UIApplication sharedApplication].keyWindow hideToastActivity];
    [self.delegate onReceiveAnchorListFailure];
}

@end
