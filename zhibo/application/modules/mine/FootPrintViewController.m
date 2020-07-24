//
//  FootPrintViewController.m
//  zhibo
//
//  Created by qp on 2020/4/29.
//  Copyright © 2020 qp. All rights reserved.
//

#import "FootPrintViewController.h"
@interface FootPrintViewController ()<ABUIListViewDelegate>
@property (nonatomic, strong) ABUIListView *listView;
@end

@implementation FootPrintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.listView = [[ABUIListView alloc] initWithFrame:self.view.bounds];
    self.listView.delegate = self;
    [self.view addSubview:self.listView];
    
    NSArray *historyList = [[Service shared] getHistoryList];
    historyList = [ABIteration iterationList:historyList block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
        dic[@"title"] = dic[@"LiveName"];
        dic[@"icon"] = dic[@"CoverImg"];
        dic[@"content"] = @"123";
        dic[@"time"] = [ABTime timestampToTime:dic[@"addtime"] format:nil];
        dic[@"native_id"] = @"message";
        return dic;
    }];
    
    [self.listView setDataList:historyList css:@{
        @"item.size.width":@"100%",
        @"item.size.height":@"80",
    }];
    
    if (historyList.count == 0) {
        [self showNoDataEmpty];
    }
//    self.dataList = [ResourceUtil readDataWithFileName:@"footprint"][@"data"];
//    self.listView.lineSpacing = 1;
//
//    [self.listView reloadData];

}

- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item {
      [NSRouter gotoRoomPlayPage:[item[@"RoomId"] intValue]];
}

@end
