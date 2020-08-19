//
//  ProfileViewController.m
//  zhibo
//
//  Created by qp on 2020/7/28.
//  Copyright © 2020 qp. All rights reserved.
//

#import "ProfileViewController.h"
#import "AnchorPresent.h"
#import "ProfileTopView.h"
@interface ProfileViewController ()<INetData, ABUIListViewDelegate, ABUIListViewDataSource, IABMQSubscribe>
@property (nonatomic, strong) ABUIListView *listView;

@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) ProfileTopView *topView;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.emptyViewInserts = UIEdgeInsetsMake(60, 0, 0, 0);
    
    self.topView = [[ProfileTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    [self.view addSubview:self.topView];
    
    self.listView = [[ABUIListView alloc] initWithFrame:self.view.bounds];
//    [self.listView setupPullRefresh];
    self.listView.delegate = self;
    self.listView.headerView = self.topView;
    self.listView.dataSource = self;
    [self.view addSubview:self.listView];
    
    [self reloadData];
    
    [[ABMQ shared] subscribe:self channels:@[CHANNEL_FOLLOW_CHANGED, CHANNEL_LIKE_CHANGED, CHANNEL_COMMENT_CHANGED] autoAck:true]; //关注，喜欢发生变化，刷新列表
    
    
}


- (void)abmq:(ABMQ *)abmq onReceiveMessage:(id)message channel:(NSString *)channel {
    if ([channel isEqualToString:CHANNEL_FOLLOW_CHANGED]) {
        [self fetchPostUri:URI_USER_INFO params:@{@"touid":self.props[@"uid"], @"room_id":@"0"}];
        [self fetchPostUri:URI_MOMENTS_LIST params:@{@"live_uid":self.props[@"uid"], @"lastid":@"0"}];
    }else{
        [self fetchPostUri:URI_MOMENTS_LIST params:@{@"live_uid":self.props[@"uid"], @"lastid":@"0"}];
    }
}


- (void)reloadData {
     [self fetchPostUri:URI_USER_INFO params:@{@"touid":self.props[@"uid"], @"room_id":@"0"}];
    [self fetchPostUri:URI_MOMENTS_LIST params:@{@"live_uid":self.props[@"uid"], @"lastid":@"0"}];
}

- (void)refreshData {
    [self fetchPostUri:URI_MOMENTS_LIST params:@{@"live_uid":self.props[@"uid"], @"lastid":@"0"}];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.listView.frame = self.view.bounds;
}

- (void)listViewOnHeaderPullRefresh:(ABUIListView *)listView {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self reloadData];
    });
    
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    if ([req.uri isEqualToString:URI_MOMENTS_LIST]) {
        self.dataList = obj[@"list"];
        [self.listView setDataList:self.dataList css:@{@"item.rowSpacing":@"5"}];
        if (self.dataList.count == 0) {
            [self showSeat];
        }else{
            [self hideSeat];
        }
    }
    if ([req.uri isEqualToString:URI_USER_INFO]) {
        [self.topView setData:obj];
    }
}


- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item {
//    [NSRouter gotoProfile];
}
- (void)listViewDidReload:(ABUIListView *)listView {
    [self.listView endPullRefreshing];
}

- (void)onNetRequestFailure:(ABNetRequest *)req err:(ABNetError *)err {\
    [self.listView endPullRefreshing];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
