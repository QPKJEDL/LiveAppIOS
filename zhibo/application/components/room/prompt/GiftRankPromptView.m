//
//  GiftRankPromptView.m
//  zhibo
//
//  Created by qp on 2020/7/13.
//  Copyright © 2020 qp. All rights reserved.
//

#import "GiftRankPromptView.h"
@interface GiftRankPromptView ()<INetData, ABUIListViewDelegate, ABUIListViewDataSource>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) ABUIListView *listView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *okButton;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSArray *dataList;
@end
@implementation GiftRankPromptView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 18;
        self.clipsToBounds = true;
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 44)];
        self.titleLabel.text = @"礼物排行榜";
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont PingFangSC:14];
        self.titleLabel.textColor = [UIColor hexColor:@"#313131"];
        [self addSubview:self.titleLabel];
        
        self.listView = [[ABUIListView alloc] initWithFrame:CGRectMake(0, 44, self.width, self.height-44)];
        self.listView.delegate = self;
        self.listView.dataSource = self;
        [self addSubview:self.listView];
        [self.listView addLineDirection:LineDirectionTop color:[UIColor hexColor:@"dedede"] width:1];
        
//        self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width/2-15-75, self.height-18-33, 75, 34)];
//        [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
//        self.cancelButton.titleLabel.font = [UIFont PingFangSC:14];
//        self.cancelButton.backgroundColor = [UIColor hexColor:@"#D9D9D9"];
//        [self.cancelButton setTitleColor:[UIColor hexColor:@"#313131"] forState:UIControlStateNormal];
//        [self addSubview:self.cancelButton];
//        self.cancelButton.layer.cornerRadius = 34/2;
//        self.cancelButton.clipsToBounds = true;
//        [self.cancelButton addTarget:self action:@selector(onCancel) forControlEvents:UIControlEventTouchUpInside];
//
//        self.okButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width/2+15, self.height-18-33, 75, 34)];
//        [self.okButton setTitle:@"确定" forState:UIControlStateNormal];
//        self.okButton.titleLabel.font = [UIFont PingFangSC:14];
//        self.okButton.backgroundColor = [UIColor hexColor:@"#2EE1EB"];
//        [self.okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [self addSubview:self.okButton];
//        self.okButton.layer.cornerRadius = 34/2;
//        self.okButton.clipsToBounds = true;
//        [self.okButton addTarget:self action:@selector(onOk) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)refreshWithRoomID:(NSInteger)roomid {
    [self fetchPostUri:URI_ROOM_GIFTRANK params:@{@"room_id":@(roomid)}];
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    if ([req.uri isEqualToString:URI_ROOM_GIFTRANK]) {
        self.index = -1;
        NSArray *list = [ABIteration iterationList:obj[@"list"] block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
            dic[@"native_id"] = @"giftrankitem";
            return dic;
        }];
        self.dataList = list;
        [self.listView setDataList:list css:@{@"item.size.width":@"100%", @"item.size.height":@"52"}];
    }
}

- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item {
//    if (self.delegate && [self.delegate respondsToSelector:@selector(desksPromptView:didSelectIndex:item:)]) {
//        [self.delegate desksPromptView:self didSelectIndex:indexPath.row item:item];
//    }
    self.index = indexPath.row;
    [listView reloadData];
}

- (NSDictionary *)listView:(ABUIListView *)listView extraDataAtIndexPath:(NSIndexPath *)indexPath {
    return @{@"selected":@(self.index == indexPath.row)};
}

- (void)onCancel {
    [[ABUIPopUp shared] remove];
}

- (void)onOk {
    if (self.index == -1 || self.index >= self.dataList.count) {
        [ABUITips showError:@"请选择台桌"];
        return;
    }
    NSDictionary *dic = self.dataList[self.index];
    [self fetchPostUri:URI_ROOM_SETGAME params:@{
        @"room_id":@([RoomContext shared].roomid),
        @"desk_id":dic[@"DeskId"],
        @"game_id":dic[@"GameId"],
    }
    ];
}

@end
