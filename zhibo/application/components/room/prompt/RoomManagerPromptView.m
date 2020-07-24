//
//  RoomManagerPromptView.m
//  zhibo
//
//  Created by qp on 2020/7/14.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RoomManagerPromptView.h"
@interface RoomManagerPromptView ()<INetData, ABUIListViewDelegate, ABUIListViewDataSource>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) ABUIListView *listView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *okButton;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, assign) NSInteger roomid;
@end
@implementation RoomManagerPromptView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 18;
        self.clipsToBounds = true;
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 44)];
        self.titleLabel.text = @"超级管理员";
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont PingFangSC:14];
        self.titleLabel.textColor = [UIColor hexColor:@"#313131"];
        [self addSubview:self.titleLabel];
        
        self.listView = [[ABUIListView alloc] initWithFrame:CGRectMake(0, 44, self.width, self.height-88)];
        self.listView.delegate = self;
        self.listView.dataSource = self;
        [self addSubview:self.listView];
        [self.listView addLineDirection:LineDirectionTop color:[UIColor hexColor:@"dedede"] width:1];
        
        self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(20, self.height-18-33, self.width-40, 34)];
        [self.cancelButton setTitle:@"关闭" forState:UIControlStateNormal];
        self.cancelButton.titleLabel.font = [UIFont PingFangSC:14];
        self.cancelButton.backgroundColor = [UIColor hexColor:@"#D9D9D9"];
        [self.cancelButton setTitleColor:[UIColor hexColor:@"#313131"] forState:UIControlStateNormal];
        [self addSubview:self.cancelButton];
        self.cancelButton.layer.cornerRadius = 34/2;
        self.cancelButton.clipsToBounds = true;
        [self.cancelButton addTarget:self action:@selector(onCancel) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)refreshWithRoomID:(NSInteger)roomid {
    self.roomid = roomid;
    [self fetchPostUri:URI_ROOM_MANAGERLIST params:@{@"room_id":@(roomid)}];
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    if ([req.uri isEqualToString:URI_ROOM_MANAGERLIST]) {
        self.index = -1;
        NSArray *list = [ABIteration iterationList:obj[@"ManagerList"] block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
            dic[@"native_id"] = @"manageritem";
            return dic;
        }];
        self.dataList = list;
        [self.listView setDataList:list css:@{@"item.size.width":@"100%", @"item.size.height":@"60"}];
        if (list.count == 0) {
            [self showEmpty];
        }
    }
    if ([req.uri isEqualToString:URI_ROOM_RMMANAGER]) {
        [ABUITips showSucceed:@"解除成功"];
        [self refreshWithRoomID:self.roomid];
    }
}

- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item {
    QMUIAlertAction *action1 = [QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:NULL];
    QMUIAlertAction *action2 = [QMUIAlertAction actionWithTitle:@"确定" style:QMUIAlertActionStyleDestructive handler:^(__kindof QMUIAlertController * _Nonnull aAlertController, QMUIAlertAction * _Nonnull action) {
        [self fetchPostUri:URI_ROOM_RMMANAGER params:@{@"room_id":@(self.roomid), @"manager_id":item[@"UserId"]}];
    }];
    QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:@"确定解除?" message:nil preferredStyle:QMUIAlertControllerStyleAlert];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController showWithAnimated:YES];
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
