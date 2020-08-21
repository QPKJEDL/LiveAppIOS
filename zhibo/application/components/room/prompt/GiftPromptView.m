//
//  GiftView.m
//  zhibo
//
//  Created by qp on 2020/7/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import "GiftPromptView.h"
#import "GiftEffectsPlayView.h"
@interface GiftPromptView ()<INetData, ABUIListViewDelegate>
@property (nonatomic, strong) ABUIListView *listView;
@property (nonatomic, strong) GiftEffectsPlayView *giftPlayView;

@property (nonatomic, assign) NSInteger roomid;
@property (nonatomic, assign) NSInteger liveuid;
@property (nonatomic, strong) NSArray *giftList;
@end
@implementation GiftPromptView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor hexColor:@"#232828"] colorWithAlphaComponent:0.88];
        
        self.listView = [[ABUIListView alloc] initWithFrame:self.bounds];
        self.listView.delegate = self;
        [self addSubview:self.listView];
        
        self.giftPlayView = [[GiftEffectsPlayView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return self;
}

- (void)refreshWithRoomID:(NSInteger)roomid liveuid:(NSInteger)liveuid {
    self.roomid = roomid;
    self.liveuid = liveuid;
    if (self.giftList.count > 0) {
        [self reload];
        return;
    }
    [self fetchPostUri:URI_ROOM_GIFT params:nil];
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    if ([req.uri isEqualToString:URI_ROOM_GIFT]) {
        self.giftList = obj[@"list"];
        [self reload];
    }
    if ([req.uri isEqualToString:URI_ROOM_SEND_GIFT]) {
        if ([req.params[@"gift_id"] intValue] == 1) {
            [[GiftEffectsPlayView shared] showWithVideoFile:@""];
        }
    }
}

- (void)reload {
    NSArray *list = [ABIteration iterationList:self.giftList block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
//        dic[@""]
        dic[@"price"] = [NSString stringWithFormat:@"%.2f", [dic[@"price"] floatValue]/100.0];
        dic[@"native_id"] = @"giftitem";
        return dic;
    }];
    [self.listView setDataList:list css:@{@"item.size.width":@"20%", @"item.size.height":@"73", @"item.row.spacing":@"0"}];
}

- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item {
    [self fetchPostUri:URI_ROOM_SEND_GIFT params:@{
        @"room_id":@(self.roomid),
        @"live_id":@(self.liveuid),
        @"gift_type":item[@"id"],
        @"one_price":item[@"price"],
        @"gift_num":@(1)
    }];
}


- (void)onNetRequestFailure:(ABNetRequest *)req err:(ABNetError *)err {
    if ([req.uri isEqualToString:URI_ROOM_SEND_GIFT]) {
        [ABUITips showError:err.message];
    }
}
@end
