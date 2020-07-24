//
//  AnchorPromptView.m
//  zhibo
//
//  Created by qp on 2020/7/12.
//  Copyright © 2020 qp. All rights reserved.
//

#import "AnchorPromptView.h"
#import "UserPromptActionView.h"
@interface AnchorPromptView ()<INetData>
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *idLabel;
@property (nonatomic, strong) ABUIListView *listView;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, strong) UIButton *followButton;

@end
@implementation AnchorPromptView

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
        
        self.followButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 171+72/2, self.width-20, 44)];
        self.followButton.layer.cornerRadius = 44/2;
        self.followButton.clipsToBounds = true;
        [self.followButton setTitle:@"关注" forState:UIControlStateNormal];
        [self.followButton setBackgroundColor:[UIColor hexColor:@"#00BFCB"]];
        [self.followButton setTitleColor:[UIColor hexColor:@"#FFFFFF"] forState:UIControlStateNormal];
        self.followButton.titleLabel.font = [UIFont PingFangSC:12];
        [self addSubview:self.followButton];
        self.followButton.centerX = self.width/2;
        [self.followButton addTarget:self action:@selector(onFollow) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)refreshWith:(NSInteger)uid {
    self.uid = uid;
    [self fetchPostUri:URI_USER_INFO params:@{@"touid":@(uid), @"room_id":@([RoomContext shared].roomid)}];
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    if ([req.uri isEqualToString:URI_USER_INFO]) {
        self.isFollow = [obj[@"isFollowed"] boolValue];
        [self.avatarImageView loadImage:obj[@"Avater"]];
        self.nameLabel.text = obj[@"NickName"];
        [self.nameLabel sizeToFit];
        
        self.idLabel.text = [NSString stringWithFormat:@"ID%@", obj[@"UserId"]];
        [self.idLabel sizeToFit];
        
        NSArray *list = @[
            @{
                @"title":@"直播",
                @"content":@"0",
                @"native_id":@"usersub"
            },
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
            @"item.size.width":@"25%",
            @"item.size.height":@"50"
        }];
    }
    else if ([req.uri isEqualToString:URI_FOLLOW_FOLLOW]) {
        self.isFollow = true;
    }
    else if ([req.uri isEqualToString:URI_FOLLOW_UNFOLLOW]) {
        self.isFollow = false;
    }
    
}

- (void)setIsFollow:(BOOL)isFollow {
    _isFollow = isFollow;
    if (isFollow) {
        [self.followButton setTitle:@"已关注" forState:UIControlStateNormal];
        [self.followButton setBackgroundColor:[UIColor hexColor:@"#dedede"]];
    }else{
        [self.followButton setTitle:@"关注" forState:UIControlStateNormal];
        [self.followButton setBackgroundColor:[UIColor hexColor:@"#00BFCB"]];
    }
}

- (void)onNetRequestFailure:(ABNetRequest *)req err:(ABNetError *)err {
    if ([req.uri isEqualToString:URI_FOLLOW_FOLLOW]) {
        self.isFollow = true;
    }
}
- (void)onFollow {
    if (self.isFollow == false) {
        [self fetchPostUri:URI_FOLLOW_FOLLOW params:@{@"live_uid":@(self.uid)}];
    }else{
        [QMUIAlertController appearance].sheetTitleAttributes = @{NSForegroundColorAttributeName:[UIColor hexColor:@"3dc2d5"],NSFontAttributeName:UIFontBoldMake(20),NSKernAttributeName:@(0)};
        QMUIAlertAction *action1 = [QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {

        }];
        QMUIAlertAction *action2 = [QMUIAlertAction actionWithTitle:@"确定" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {
            [self fetchPostUri:URI_FOLLOW_UNFOLLOW params:@{@"live_uid":@(self.uid)}];
        }];

        QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:@"确定不在关注此人?" message:nil preferredStyle:QMUIAlertControllerStyleActionSheet];
        alertController.alertTextFieldTextColor = [UIColor redColor];
        [alertController addAction:action1];
        [alertController addAction:action2];
        [alertController showWithAnimated:YES];

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
//    self.actionView.top = self.listView.bottom;
    
}
@end
