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
        [[UIApplication sharedApplication].keyWindow makeToastActivity:CSToastPositionCenter];
    }
    if (self.anchorList.count == 0 || self.isPullRefresh == true) {
        [self fetchPostUri:URI_ROOM_LIST params:@{@"channe_id":props[@"id"], @"last_time":@"0"}];
    }else{
        [self fetchPostUri:URI_ROOM_LIST params:@{@"channe_id":props[@"id"], @"last_time":[self.anchorList lastObject][@"StartTime"]}];
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
    [self.delegate onReceiveAnchorList];
}

- (void)onNetRequestFailure:(ABNetRequest *)req err:(ABNetError *)err {
     [[UIApplication sharedApplication].keyWindow hideToastActivity];
    [self.delegate onReceiveAnchorListFailure];
}

@end
