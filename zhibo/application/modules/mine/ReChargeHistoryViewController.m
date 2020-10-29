//
//  ReChargeHistoryViewController.m
//  zhibo
//
//  Created by qp on 2020/7/30.
//  Copyright © 2020 qp. All rights reserved.
//

#import "ReChargeHistoryViewController.h"
#import "DateItemView.h"
@interface ReChargeHistoryViewController ()<INetData, ABUIListViewDelegate>
@property (nonatomic, strong) ABUIListView *listView;
@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) DateItemView *dateItemView;
@end

@implementation ReChargeHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dateItemView = [[DateItemView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    [self.dateItemView.selectButton addTarget:self action:@selector(onDate) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.dateItemView];
    
    self.listView = [[ABUIListView alloc] initWithFrame:self.view.bounds];
    self.listView.delegate = self;
    [self.view addSubview:self.listView];
    [self.listView setupPullRefresh];
    
    
    
    [self refreshData];
}

- (void)onDate {
    [self refreshData];
}
- (void)refreshData {
    [self fetchPostUri:URI_ACCOUNT_CHANGER_LIST params:@{@"date":self.dateItemView.dateTitle, @"type":@(self.type), @"lastid":@"0"}];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.listView.frame = CGRectMake(0, 44, self.view.width, self.view.height);
}

- (void)listViewOnHeaderPullRefresh:(ABUIListView *)listView {
     [self fetchPostUri:URI_ACCOUNT_CHANGER_LIST params:@{@"date":self.dateItemView.dateTitle,@"type":@(self.type), @"lastid":@"0"}];
}

- (void)listViewOnLoadMore:(ABUIListView *)listView {
    [self fetchPostUri:URI_ACCOUNT_CHANGER_LIST params:@{@"date":self.dateItemView.dateTitle,@"type":@(self.type), @"lastid":self.dataList.lastObject[@"id"]}];
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
    
    if (self.dataList.count == 0) {
        [self showNoDataEmpty];
        [self.view bringSubviewToFront:self.dateItemView];
    }else{
        [self hideEmptyView];
    }
    
    [self.listView endPullRefreshing];
    [self.listView endLoadMore];
    
    [self.listView setDataList:self.dataList css:@{
        @"item.rowSpacing":@"1"
    }];
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
