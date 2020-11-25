//
//  GameHistoryViewController.m
//  zhibo
//
//  Created by qp on 2020/7/28.
//  Copyright © 2020 qp. All rights reserved.
//

#import "GameHistoryViewController.h"
#import "DateItemView.h"
@interface GameHistoryViewController ()<INetData, ABUIListViewDelegate>
@property (nonatomic, strong) ABUIRefreshListView *listView;
@property (nonatomic, strong) DateItemView *dateItemView;

@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, assign) BOOL isPullRefresh;
@property (nonatomic, strong) UILabel *shuyingLabel;
@property (nonatomic, assign) NSInteger lastid;
@end

@implementation GameHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"游戏记录";
    
    self.dataList = [[NSMutableArray alloc] init];
    
    self.dateItemView = [[DateItemView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    [self.dateItemView.selectButton addTarget:self action:@selector(onDateItemClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.dateItemView];
    
    self.shuyingLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 44, SCREEN_WIDTH-30, 30)];
    self.shuyingLabel.text = @"总输赢: 0";
    self.shuyingLabel.textColor = [UIColor hexColor:@"666666"];
    self.shuyingLabel.font = [UIFont PingFangSCBlod:15];
    [self.view addSubview:self.shuyingLabel];
    
    
    self.listView = [[ABUIRefreshListView alloc] initWithFrame:self.view.bounds];
    self.listView.delegate = self;
    [self.view addSubview:self.listView];
    [self.listView adapterSafeArea];
    [self refreshData];
}

- (void)onDateItemClick {
    self.isPullRefresh = true;
    [self.listView resetNoMoreData];
    self.dataList = [[NSMutableArray alloc] init];
    self.lastid = 0;
    [self refreshData];
}

- (void)refreshData {
    [self fetchPostUri:URI_ACCOUNT_BET_HISTORY params:@{@"lastid":@(self.lastid),@"date":self.dateItemView.dateTitle}];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.listView.frame = CGRectMake(0, self.shuyingLabel.bottom, SCREEN_WIDTH, self.view.height-self.shuyingLabel.bottom);
}


- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    NSArray *newList = obj[@"list"];
    if (newList.count > 0) {
        self.lastid = [newList.lastObject[@"id"] intValue];
    }
    [self.listView setDataList:newList css:@{
        @"item.size.width":@"100%",
        @"item.size.height":@"175",
        @"item.rowSpacing":@"10",
        @"section.inset.top":@"10"
    }];
    self.shuyingLabel.text = [NSString stringWithFormat:@"总输赢:%@", obj[@"sum"]];
//    if (self.listView.isLoadMoreing) {
//        [self.dataList addObjectsFromArray:newList];
//    }else{
//        self.dataList = [[NSMutableArray alloc] initWithArray:newList];
//    }
//    if (self.dataList.count > 0 && newList.count == 0) {
//        [self.listView noMoreData];
//    }
//    self.isPullRefresh = false;
//    [self.listView endLoadMore];
//    [self.listView endPullRefreshing];

}

- (void)onNetRequestFailure:(ABNetRequest *)req err:(ABNetError *)err {
    [self.listView endLoadMore];
}

- (void)listViewOnLoadMore:(ABUIListView *)listView {
    [self refreshData];
}

- (void)listViewOnHeaderPullRefresh:(ABUIListView *)listView {
    self.lastid = 0;
    [self refreshData];
}
@end
