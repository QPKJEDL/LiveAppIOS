//
//  FollowViewController.m
//  zhibo
//
//  Created by FaiWong on 2020/4/22.
//  Copyright © 2020 qp. All rights reserved.
//

#import "FollowViewController.h"
#import "FollowPresent.h"
@interface FollowViewController ()<FollowPresentDelegate, ABUIListViewDelegate>
@property (nonatomic, strong) ABUIListView *listView;
@property (nonatomic, strong) FollowPresent *present;
@property (nonatomic, strong) UIView *headerView;

@end

@implementation FollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor hexColor:@"F7F9FD"];
    // Do any additional setup after loading the view.
    self.listView = [[ABUIListView alloc] initWithFrame:self.view.bounds];
    self.listView.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    [self.view addSubview:self.listView];
    self.listView.delegate = self;
    [self.listView setupPullRefresh];
    
    self.present = [[FollowPresent alloc] init];
    self.present.delegate = self;
    
    self.title = @"关注";
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadData];
}

- (void)reloadData {
    [self hideEmptyView];
    [self.present requestFollowList];
}

#pragma mark --- receive data from present
- (void)present:(FollowPresent *)present onReceiveFollowList:(NSArray *)followList {
    [self.listView endPullRefreshing];
    if (followList.count == 0) {
        [self showEmptyViewWithImage:[UIImage imageNamed:@"shuju"] text:@"暂无数据" detailText:nil buttonTitle:@"刷新" buttonAction:@selector(reloadData)];
    }else{
        [self.listView setDataList:followList css:@{@"item.size.width":@"100%", @"item.size.height":@"78", @"item.rowSpacing":@"6", @"section.inset.top":@"6"}];
    }
}
- (void)present:(FollowPresent *)present onReceiveFailure:(ABNetError *)error {
    [self.listView endPullRefreshing];
    if (error.isNetReachable) {
        [self showEmptyViewWithImage:[UIImage imageNamed:@"wuwang"] text:@"暂无网络" detailText:nil buttonTitle:@"刷新" buttonAction:@selector(reloadData)];
    }else{
        [self showEmptyViewWithImage:[UIImage imageNamed:@"shuju"] text:@"暂无数据" detailText:nil buttonTitle:@"刷新" buttonAction:@selector(reloadData)];
    }
}

- (void)listViewOnHeaderPullRefresh:(ABUIListView *)listView {
    [self reloadData];
}

- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item {
//    if ([item[@"status"] intValue] == 1) {
//        [NSRouter gotoRoomPlayPage:[item[@"room_id"] intValue]];
//    }
    [NSRouter gotoRoomPlayPage:[item[@"room_id"] intValue]];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
