//
//  MomentsViewController.m
//  zhibo
//
//  Created by qp on 2020/7/27.
//  Copyright © 2020 qp. All rights reserved.
//

#import "MomentsViewController.h"

@interface MomentsViewController ()<INetData, ABUIListViewDelegate, ABUIListViewDataSource, IABMQSubscribe>
@property (nonatomic, strong) ABUIListView *listView;

@property (nonatomic, strong) NSMutableArray *dataList;
@end

@implementation MomentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.listView = [[ABUIListView alloc] initWithFrame:self.view.bounds];
    [self.listView setupPullRefresh];
    [self.listView setupLoadMore];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    [self.view addSubview:self.listView];
    
    [self refreshData];
    
    [[ABMQ shared] subscribe:self channels:@[CHANNEL_FOLLOW_CHANGED, CHANNEL_LIKE_CHANGED, CHANNEL_COMMENT_CHANGED] autoAck:true]; //关注，喜欢发生变化，刷新列表
}

- (void)abmq:(ABMQ *)abmq onReceiveMessage:(id)message channel:(NSString *)channel {
    [self refreshData];
}

- (void)refreshData {
    [super refreshData];
    [self fetchPostUri:URI_MOMENTS_LIST params:@{@"lastid":@(0)}];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.listView.frame = self.view.bounds;
}


- (void)listViewOnHeaderPullRefresh:(ABUIListView *)listView {
    [self refreshData];
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    NSArray *newList = obj[@"list"];
    if (self.listView.isLoadMoreing) {
        [self.dataList addObjectsFromArray:newList];
    }else{
       self.dataList = [[NSMutableArray alloc] initWithArray:newList];
    }
    if (newList.count == 0) {
        [self.listView noMoreData];
    }
    
    [self hideEmptyView];
    if (self.dataList.count == 0) {
        [self showNoDataEmpty];
    }
    
    [self.listView endPullRefreshing];
    [self.listView endLoadMore];
    [self.listView setDataList:self.dataList css:@{@"item.rowSpacing":@"5"}];
}


- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item {
    if ([item[@"IsLive"] intValue] == 1) {
        [NSRouter gotoRoomPlayPage:[item[@"room_id"] intValue]];
    }else {
        [NSRouter gotoProfile:[item[@"live_uid"] intValue]];
    }
}
- (void)listViewDidReload:(ABUIListView *)listView {
    [self.listView endPullRefreshing];
}

- (void)listViewOnLoadMore:(ABUIListView *)listView {
    [self fetchPostUri:URI_MOMENTS_LIST params:@{@"lastid":self.dataList.lastObject[@"zone_id"]}];
}

- (void)onNetRequestFailure:(ABNetRequest *)req err:(ABNetError *)err {\
    [self.listView endPullRefreshing];
    [self showSeat];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
