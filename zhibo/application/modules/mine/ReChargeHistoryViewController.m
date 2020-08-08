//
//  ReChargeHistoryViewController.m
//  zhibo
//
//  Created by qp on 2020/7/30.
//  Copyright © 2020 qp. All rights reserved.
//

#import "ReChargeHistoryViewController.h"

@interface ReChargeHistoryViewController ()<INetData, ABUIListViewDelegate>
@property (nonatomic, strong) ABUIListView *listView;
@end

@implementation ReChargeHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.listView = [[ABUIListView alloc] initWithFrame:self.view.bounds];
    self.listView.delegate = self;
    [self.view addSubview:self.listView];
    [self.listView setupPullRefresh];
    
    
    
    [self fetchPostUri:URI_ACCOUNT_CHANGER_LIST params:@{@"type":@(self.type), @"lastid":@"0"}];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.listView.frame = self.view.bounds;
}

- (void)listViewOnHeaderPullRefresh:(ABUIListView *)listView {
     [self fetchPostUri:URI_ACCOUNT_CHANGER_LIST params:@{@"type":@(self.type), @"lastid":@"0"}];
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    [self.listView endPullRefreshing];
    [self.listView setDataList:obj[@"list"] css:@{
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
