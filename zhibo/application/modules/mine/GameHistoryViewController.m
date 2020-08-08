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
@property (nonatomic, strong) ABUIListView *listView;
@property (nonatomic, strong) DateItemView *dateItemView;

@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, assign) BOOL isPullRefresh;
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
    
    self.listView = [[ABUIListView alloc] initWithFrame:self.view.bounds];
    self.listView.delegate = self;
    [self.view addSubview:self.listView];
    [self.listView adapterSafeArea];
    [self.listView setupLoadMore];
    [self refreshData];
}

- (void)onDateItemClick {
    self.isPullRefresh = true;
    [self.listView resetNoMoreData];
    self.dataList = [[NSMutableArray alloc] init];
    [self refreshData];
}

- (void)refreshData {
    if (self.dataList.count == 0) {
        [self fetchPostUri:URI_ACCOUNT_BET_HISTORY params:@{@"lastid":@(0),@"date":self.dateItemView.dateButton.titleLabel.text}];
    }else{
        [self fetchPostUri:URI_ACCOUNT_BET_HISTORY params:@{@"lastid": self.dataList.lastObject[@"id"],@"date":self.dateItemView.dateButton.titleLabel.text}];
    }
   
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.listView.frame = CGRectMake(0, 44, SCREEN_WIDTH, self.view.height-44);
}


- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    NSArray *newList = obj[@"list"];
    if (self.isPullRefresh == false) {
        [self.dataList addObjectsFromArray:newList];
    }else{
        self.dataList = [[NSMutableArray alloc] initWithArray:newList];
    }
    if (self.dataList.count > 0 && newList.count == 0) {
        [self.listView noMoreData];
    }
    self.isPullRefresh = false;
    [self.listView endLoadMore];
    [self.listView setDataList:self.dataList css:@{
        @"item.size.width":@"100%",
        @"item.size.height":@"175",
        @"item.rowSpacing":@"10",
        @"section.inset.top":@"10"
    }];
}

- (void)onNetRequestFailure:(ABNetRequest *)req err:(ABNetError *)err {
    [self.listView endLoadMore];
}

- (void)listViewOnLoadMore:(ABUIListView *)listView {
    [self refreshData];
}

@end
