//
//  GameHistoryViewController.m
//  zhibo
//
//  Created by qp on 2020/7/28.
//  Copyright © 2020 qp. All rights reserved.
//

#import "GameHistoryViewController.h"

@interface GameHistoryViewController ()<INetData>
@property (nonatomic, strong) ABUIListView *listView;
@end

@implementation GameHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"游戏记录";
    self.listView = [[ABUIListView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.listView];
    
    
    [self fetchPostUri:URI_GAME_HISTORY params:nil];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.listView.frame = self.view.bounds;
}


- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    [self.listView setDataList:obj[@"list"] css:@{
        @"item.size.width":@"100%",
        @"item.size.height":@"175",
        @"item.rowSpacing":@"10",
        @"section.inset.top":@"10"
    }];
}

- (void)onNetRequestFailure:(ABNetRequest *)req err:(ABNetError *)err {
    
}

@end
