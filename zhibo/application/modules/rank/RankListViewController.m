//
//  RankListViewController.m
//  zhibo
//
//  Created by qp on 2020/7/28.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RankListViewController.h"
#import "RankTopView.h"
#import "RankActionsView.h"
@interface RankListViewController ()<INetData, ABUIListViewDelegate>
@property (nonatomic, strong) ABUIListView *listView;
@property (nonatomic, strong) RankTopView *rankTopView;
@property (nonatomic, assign) NSInteger leftType;
@property (nonatomic, assign) NSInteger rightType;
@end

@implementation RankListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.rankTopView = [[RankTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 248)];
    NSInteger index = [self.props[@"index"] intValue];
    if (index == 0) {
        [self.rankTopView.rankActionsView setleft:@"当月冲榜" right:@"女神榜"];
        self.leftType = 1;
        self.rightType = 2;
    }
    if (index == 1) {
        [self.rankTopView.rankActionsView setleft:@"今日冲榜" right:@"宠爱榜"];
        self.leftType = 3;
        self.rightType = 4;
    }
    if (index == 2) {
        [self.rankTopView.rankActionsView setleft:@"今日冲榜" right:@"赌神榜"];
        self.leftType = 5;
        self.rightType = 6;
    }
    
    [self.rankTopView.rankActionsView.leftButton addTarget:self action:@selector(onLeft) forControlEvents:UIControlEventTouchUpInside];
    [self.rankTopView.rankActionsView.rightButton addTarget:self action:@selector(onRight) forControlEvents:UIControlEventTouchUpInside];
    
    self.listView = [[ABUIListView alloc] initWithFrame:self.view.bounds];
    self.listView.headerView = self.rankTopView;
    self.listView.delegate = self;
    [self.view addSubview:self.listView];
    
    [self fetchPostUri:URI_RANK_LIST params:@{@"type":@(self.leftType)}];
}

- (void)onLeft {
    [self fetchPostUri:URI_RANK_LIST params:@{@"type":@(self.leftType)}];
}

- (void)onRight {
    [self fetchPostUri:URI_RANK_LIST params:@{@"type":@(self.rightType)}];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.listView.frame = self.view.bounds;
}

- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item {
    NSInteger index = [self.props[@"index"] intValue];
    NSInteger live_uid = [item[@"live_uid"] intValue];
    if (index == 0) {
        [NSRouter gotoProfile:live_uid];
    }
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    NSMutableArray *dataList = obj[@"list"];
    NSMutableArray *topList = [[NSMutableArray alloc] init];
    NSMutableArray *bottomList = [[NSMutableArray alloc] init];
    for (int i=0;i<dataList.count;i++) {
        if (i<3) {
            [topList addObject:dataList[i]];
        }else{
            [bottomList addObject:dataList[i]];
        }
    }
    
    [self.rankTopView setRankList:topList];
    [self.listView setDataList:bottomList css:@{
        @"item.size.width":@"100%",
        @"item.size.height":@"60",
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
