//
//  AnchorListViewController.m
//  zhibo
//
//  Created by FaiWong on 2020/4/22.
//  Copyright © 2020 qp. All rights reserved.
//

#import "AnchorListViewController.h"
#import "AnchorPresent.h"
@interface AnchorListViewController ()<ABUIListViewDelegate, AnchorPresentDelegate>
@property (nonatomic, strong) ABUIListView *uilistView;
@property (nonatomic, strong) AnchorPresent *present;
@end

@implementation AnchorListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    _uilistView = [[ABUIListView alloc] initWithFrame:self.view.bounds];
    _uilistView.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    _uilistView.delegate = self;
    [self.view addSubview:_uilistView];
    [_uilistView setupPullRefresh];
    
    self.present = [[AnchorPresent alloc] init];
    self.present.delegate = self;
    [self refreshData];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _uilistView.frame = self.view.bounds;
}

- (void)onReceiveAnchorList{
    [self.uilistView endPullRefreshing];
    NSString *w = [NSString stringWithFormat:@"%f", ceil((SCREEN_WIDTH-3*12)/2.0)];
    [self.uilistView setDataList:self.present.anchorList css:@{@"item.size.width":w, @"item.size.height":@([ABDevice pixelWidth:195]), @"section.inset.right":@"12", @"section.inset.left":@"12", @"section.inset.top":@"12", @"item.rowSpacing":@"10"}];
    if (self.present.anchorList.count == 0) {
        [self showNoDataEmpty];
    }else{
        [self hideEmptyView];
    }
}
- (void)onReceiveAnchorListFailure {
    [self.uilistView endPullRefreshing];
    if (self.present.anchorList.count == 0) {
        [self showNoDataEmpty];
    }else{
        [self hideEmptyView];
    }
}

- (void)refreshData {
    [self hideEmptyView];
    [self.present getAnchorList:self.props];
}

- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item {
    if (self.present.anchorList.count == 0) {
        return;
    }

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:item];
    dic[@"addtime"] = [ABTime timestamp];
    [[Service shared] addHistory:dic];
    [NSRouter gotoRoomPlayPage:[self.present.anchorList[indexPath.row][@"RoomId"] intValue]];
}

- (void)listViewOnHeaderPullRefresh:(ABUIListView *)listView {
    self.present.isPullRefresh = true;
    [self.present getAnchorList:self.props];
}


@end
