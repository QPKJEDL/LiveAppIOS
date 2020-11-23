//
//  GiftHistoryViewController.m
//  zhibo
//
//  Created by qp on 2020/7/20.
//  Copyright © 2020 qp. All rights reserved.
//

#import "GiftHistoryViewController.h"
#import "DateItemView.h"
@interface GiftHistoryViewController ()<INetData>
@property (nonatomic, strong) DateItemView *dateItemView;
@property (nonatomic, strong) ABUIListView *listView;

@end

@implementation GiftHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dateItemView = [[DateItemView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    [self.dateItemView.selectButton addTarget:self action:@selector(onDateItemClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.dateItemView];
    
    self.listView = [[ABUIListView alloc] initWithFrame:self.view.bounds];
    [self.listView adapterSafeArea];
    [self.view addSubview:self.listView];
    
    [self refreshData];
    
}

- (void)onDateItemClick {
    [self refreshData];
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    [[UIApplication sharedApplication].keyWindow hideToastActivity];
    NSArray *list = obj[@"list"];
    NSString *tt = @"你收了";
    if (self.type == 2) {
        tt = @"你送了";
    }
    list = [ABIteration iterationList:list block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
        
        NSString *giftid = [NSString stringWithFormat:@"%@", dic[@"gift_id"]];
        dic[@"gift"] = [Stack shared].giftMap[giftid];
        
        NSString *text = [NSString stringWithFormat:@"%@ %@ %@ 个", tt, dic[@"nickname"], dic[@"num"]];
        dic[@"text"] = text;
        
        NSString *time = dic[@"creatime"];
        dic[@"time"] = [ABTime timestampToTime:time format:nil];
        
        dic[@"native_id"] = @"gifthistory";
        return dic;
    }];
    
    [self.listView setDataList:list css:@{@"item.size.height":@"60", @"item.size.width":@"100%",@"item.rowSpacing":@"1"}];
    if (list.count == 0) {
        [self showNoDataEmpty];
        [self.view bringSubviewToFront:self.dateItemView];
    }else{
        
        [self hideEmptyView];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.listView.frame = CGRectMake(0, self.dateItemView.height, SCREEN_WIDTH, self.view.height-self.dateItemView.height);
}

- (void)onNetRequestFailure:(ABNetRequest *)req err:(ABNetError *)err {
    [[UIApplication sharedApplication].keyWindow hideToastActivity];
    [self showNoDataEmpty];
}

- (void)refreshData {
    [ABUITips showLoading];
    [self fetchPostUri:URI_ROOM_GIFTRECORD params:@{@"type":@(self.type), @"lastid":@"0", @"date":self.dateItemView.dateButton.titleLabel.text}];
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
