//
//  TipSelectPromptView.m
//  zhibo
//
//  Created by qp on 2020/7/11.
//  Copyright © 2020 qp. All rights reserved.
//

#import "TopicsPromptView.h"
@interface TopicsPromptView ()<INetData, ABUIListViewDelegate>
@property (nonatomic, strong) ABUIListView *listView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSArray *list;
@end
@implementation TopicsPromptView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor hexColor:@"222222"] colorWithAlphaComponent:0.9];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        self.titleLabel.text = @"选择话题";
        self.titleLabel.font = [UIFont PingFangSCBlod:16];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        [self.titleLabel addLineDirection:LineDirectionBottom color:[UIColor blackColor] width:LINGDIANWU];
        
        self.listView = [[ABUIListView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, self.height-44-TI_HEIGHT)];
        [self addSubview:self.listView];
        self.listView.delegate = self;
        
        [self loadData];
    
    }
    return self;
}

- (void)loadData {
    [self showLoading];
    [self fetchPostUri:URI_ROOM_LABELS params:nil];
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    [self hideLoading];
    NSArray *list = obj[@"list"];
    self.list = list;
    if (list.count == 0) {
        [self showEmpty];
    }else{
        [self hideEmpty];
    }
    list = [ABIteration iterationList:list block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
       dic[@"native_id"] = @"topic";
       return dic;
    }];
    [self.listView setDataList:list css:@{@"item.size.height":@"60", @"item.size.width":@"100%", @"item.row.spacing":@"1"}];
}

- (void)onNetRequestFailure:(ABNetRequest *)req err:(ABNetError *)err {
    [self hideLoading];
    [self showEmpty];
}

- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item {
    [self.delegate topicsPromptView:self didSelectTopic:self.list[indexPath.row][@"label"]];
}

@end
