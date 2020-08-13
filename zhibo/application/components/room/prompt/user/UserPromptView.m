//
//  UserPromptView.m
//  zhibo
//
//  Created by qp on 2020/7/11.
//  Copyright © 2020 qp. All rights reserved.
//

#import "UserPromptView.h"
@interface UserPromptView ()<INetData, ABUIListViewDelegate>
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *idLabel;
@property (nonatomic, strong) ABUIListView *listView;
@property (nonatomic, strong) ABUIListView *actionsView;
@property (nonatomic, assign) NSInteger uid;

@property (nonatomic, assign) BOOL isFollowed;
@property (nonatomic, assign) BOOL isManager;
@property (nonatomic, assign) BOOL isBan;
@property (nonatomic, assign) BOOL isTi;
@end
@implementation UserPromptView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.containView = [[UIView alloc] initWithFrame:CGRectMake(0, 72/2, self.width, self.height-72/2)];
        [self addSubview:self.containView];
        self.containView.backgroundColor = [UIColor whiteColor];
        [self.containView corner:UIRectCornerTopLeft|UIRectCornerTopRight radii:10];
        
        self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 72, 72)];
        self.avatarImageView.backgroundColor = [UIColor hexColor:@"dedede"];
        self.avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.avatarImageView.clipsToBounds = true;
        self.avatarImageView.layer.cornerRadius = 72/2;
        [self addSubview:self.avatarImageView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.nameLabel.textColor = [UIColor hexColor:@"#313131"];
        self.nameLabel.font = [UIFont PingFangSCBlod:22];
        [self addSubview:self.nameLabel];
        
        self.idLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.idLabel.textColor = [UIColor hexColor:@"#313131"];
        self.idLabel.font = [UIFont PingFangSCBlod:10];
        [self addSubview:self.idLabel];
        
        self.listView = [[ABUIListView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        self.listView.collectionView.bounces = false;
        [self addSubview:self.listView];
        
        self.actionsView = [[ABUIListView alloc] initWithFrame:CGRectMake(0, 171+72/2+1, SCREEN_WIDTH, 50)];
        self.actionsView.collectionView.bounces = false;
        self.actionsView.delegate = self;
        [self.actionsView addLineDirection:LineDirectionTop color:[UIColor hexColor:@"#E9E9E9"] width:1];
        [self addSubview:self.actionsView];
        
    }
    return self;
}

- (void)removeActionView {
    [self.actionsView removeFromSuperview];
}

- (void)refreshWith:(NSInteger)uid roomid:(NSInteger)roomid {
    self.uid = uid;
    [self fetchPostUri:URI_USER_INFO params:@{@"touid":@(uid), @"room_id":@([RoomContext shared].roomid)}];
}

- (void)reloadActionView {
    
    NSMutableArray *list = [[NSMutableArray alloc] init];
    if (self.uid != [Service shared].account.uid) {
        [list addObject:@{@"title":@"+关注", @"title_hl":@"已关注", @"color":@"#FF2A40", @"native_id":@"userpromptaction", @"selected":@(self.isFollowed), @"key":@"gz"}];
        BOOL isFangzhu = [RoomContext shared].anchorid == [Service shared].account.uid;
        if (([RoomContext shared].isManager && self.isManager == false) || isFangzhu) {//自己是管理，点击的用户非管理非房主
            [list addObject:@{@"title":@"踢人", @"title_hl":@"已踢",@"color":@"#313131", @"native_id":@"userpromptaction", @"selected":@(self.isTi), @"key":@"kick"}];
            [list addObject:@{@"title":@"禁言", @"title_hl":@"已禁言", @"color":@"#313131",@"native_id":@"userpromptaction", @"selected":@(self.isBan), @"key":@"jy"}];
        }
        if (isFangzhu) {
            [list addObject:@{@"title":@"设置管理", @"title_hl":@"移除管理",@"color":@"#313131", @"native_id":@"userpromptaction", @"selected":@(self.isManager), @"key":@"mm"}];
        }
    }

    CGFloat w = self.width/list.count;
    [self.actionsView setDataList:list css:@{
        @"item.size.width":@(w),
        @"item.size.height":@(50)
    }];
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    [[UIApplication sharedApplication].keyWindow hideToastActivity];
    NSString *toastMessage = @"";
    if ([req.uri isEqualToString:URI_USER_INFO]) {
        [self.avatarImageView loadImage:obj[@"Avater"]];
        self.nameLabel.text = obj[@"NickName"];
        [self.nameLabel sizeToFit];
        
        self.idLabel.text = [NSString stringWithFormat:@"ID%@", obj[@"UserId"]];
        [self.idLabel sizeToFit];
        
        NSArray *list = @[
            @{
                @"title":@"关注",
                @"content":[NSString stringWithFormat:@"%@", obj[@"Followed"]],
                @"native_id":@"usersub"
            },
            @{
                @"title":@"粉丝",
                @"content":[NSString stringWithFormat:@"%@", obj[@"Fans"]],
                @"native_id":@"usersub"
            }
        ];
        [self.listView setDataList:list css:@{
            @"item.size.width":@"50%",
            @"item.size.height":@"50"
        }];
        
        self.isManager = [obj[@"isManager"] boolValue];
        self.isBan = [obj[@"isBanUser"] boolValue];
        self.isFollowed = [obj[@"isFollowed"] boolValue];
        self.isTi = false;
    }
    else if ([req.uri isEqualToString:URI_FOLLOW_FOLLOW]) {
        toastMessage = @"关注成功";
        self.isFollowed = true;
    }
    else if ([req.uri isEqualToString:URI_FOLLOW_UNFOLLOW]) {
        toastMessage = @"取关成功";
        self.isFollowed = false;
    }
    else if ([req.uri isEqualToString:URI_ROOM_SETMANAGER]) {
        toastMessage = @"设置成功";
        self.isManager = true;
    }
    else if ([req.uri isEqualToString:URI_ROOM_RMMANAGER]) {
        toastMessage = @"取消成功";
        self.isManager = false;
    }
    else if ([req.uri isEqualToString:URI_ROOM_BAN]) {
        toastMessage = @"禁言成功";
        self.isBan = true;
    }
    else if ([req.uri isEqualToString:URI_ROOM_UNBAN]) {
        self.isBan = false;
        toastMessage = @"解禁成功";
    }
    else if ([req.uri isEqualToString:URI_ROOM_KICK]) {
        toastMessage = @"踢出成功";
        self.isTi = true;
    }
    
    if (toastMessage.length > 0) {
        [ABUITips showSucceed:toastMessage];
    }
    
    [self reloadActionView];
}

- (void)onNetRequestFailure:(ABNetRequest *)req err:(ABNetError *)err {
    [[UIApplication sharedApplication].keyWindow hideToastActivity];
    [ABUITips showError:err.message];
}

- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item {
    NSString *key = item[@"key"];
    BOOL selected = [item[@"selected"] boolValue];
    if ([key isEqualToString:@"gz"]) {
        [self follow:selected];
    }
    if ([key isEqualToString:@"mm"]) {
        [self manager:selected];
    }
    if ([key isEqualToString:@"jy"]) {
        [self forbidden:selected];
    }
    if ([key isEqualToString:@"kick"]) {
        [self onKickButton];
    }
}

- (void)follow:(BOOL)selected {
    if (selected) {
        QMUIAlertAction *action1 = [QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:NULL];
        QMUIAlertAction *action2 = [QMUIAlertAction actionWithTitle:@"确定" style:QMUIAlertActionStyleDestructive handler:^(__kindof QMUIAlertController * _Nonnull aAlertController, QMUIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication].keyWindow makeToastActivity:CSToastPositionCenter];
            [self fetchPostUri:URI_FOLLOW_UNFOLLOW params:@{@"live_uid":@(self.uid)}];
        }];
        QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:@"确定不在关注此人？" message:nil preferredStyle:QMUIAlertControllerStyleAlert];
        [alertController addAction:action1];
        [alertController addAction:action2];
        [alertController showWithAnimated:YES];
    }else{
        [[UIApplication sharedApplication].keyWindow makeToastActivity:CSToastPositionCenter];
        [self fetchPostUri:URI_FOLLOW_FOLLOW params:@{@"live_uid":@(self.uid)}];
    }
}

- (void)manager:(BOOL)selected {
    [[UIApplication sharedApplication].keyWindow makeToastActivity:CSToastPositionCenter];
    if (selected) {
        [self fetchPostUri:URI_ROOM_RMMANAGER params:@{@"room_id":@([RoomContext shared].roomid), @"manager_id":@(self.uid)}];
    }else{
        [self fetchPostUri:URI_ROOM_SETMANAGER params:@{@"room_id":@([RoomContext shared].roomid), @"manager_id":@(self.uid)}];
    }
}


- (void)onKickButton {
    QMUIAlertAction *action1 = [QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:NULL];
    QMUIAlertAction *action2 = [QMUIAlertAction actionWithTitle:@"确定" style:QMUIAlertActionStyleDestructive handler:^(__kindof QMUIAlertController * _Nonnull aAlertController, QMUIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication].keyWindow makeToastActivity:CSToastPositionCenter];
        [self fetchPostUri:URI_ROOM_KICK params:@{@"room_id":@([RoomContext shared].roomid), @"fans_id":@(self.uid)}];
    }];
    QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:@"确定踢出直播间吗？" message:nil preferredStyle:QMUIAlertControllerStyleAlert];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController showWithAnimated:YES];
    
}

- (void)forbidden:(BOOL)selected {
    [[UIApplication sharedApplication].keyWindow makeToastActivity:CSToastPositionCenter];
    if (selected) {
        [self fetchPostUri:URI_ROOM_UNBAN params:@{@"room_id":@([RoomContext shared].roomid), @"fans_id":@(self.uid)}];
    }else{
        [self fetchPostUri:URI_ROOM_BAN params:@{@"room_id":@([RoomContext shared].roomid), @"fans_id":@(self.uid)}];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.avatarImageView.centerX = self.width/2;
    self.nameLabel.centerX = self.width/2;
    self.nameLabel.top = self.avatarImageView.bottom+15;
    self.idLabel.centerX = self.width/2;
    self.idLabel.top = self.nameLabel.bottom+18;
    self.listView.top = self.idLabel.bottom+10;
    
}
@end
