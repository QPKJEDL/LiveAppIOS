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
@interface RankListViewController ()<INetData>
@property (nonatomic, strong) ABUIListView *listView;
@property (nonatomic, strong) RankTopView *rankTopView;
@end

@implementation RankListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.rankTopView = [[RankTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 248)];
    NSInteger index = [self.props[@"index"] intValue];
    if (index == 0) {
        [self.rankTopView.rankActionsView setleft:@"当月冲榜" right:@"女神榜"];
    }
    if (index == 1) {
        [self.rankTopView.rankActionsView setleft:@"今日冲榜" right:@"宠爱榜"];
    }
    if (index == 2) {
        [self.rankTopView.rankActionsView setleft:@"今日冲榜" right:@"赌神榜"];
    }
    
    self.listView = [[ABUIListView alloc] initWithFrame:self.view.bounds];
    self.listView.headerView = self.rankTopView;
    [self.view addSubview:self.listView];
    
    [self fetchPostUri:URI_RANK_LIST params:nil];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.listView.frame = self.view.bounds;
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
