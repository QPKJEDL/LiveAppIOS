//
//  RoomControl.m
//  zhibo
//
//  Created by qp on 2020/7/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RoomControl.h"
#import "RoomAnchorBriefView.h"
#import "RoomBottomBar.h"
#import "GiftPromptView.h"
#import "RoomAudienceView.h"
#import "RoomChatView.h"
#import "AnchorPromptView.h"
#import "RoomGiftView.h"
#import "GiftEffectsPlayView.h"
@interface RoomControl ()<RoomBottomBarDelegate, RoomChatViewDelegate, INetData, RoomAnchorBriefViewDelegate>
@property (nonatomic, strong) UIView *bbbView;
@property (nonatomic, strong) RoomAnchorBriefView *briefView;
@property (nonatomic, strong) RoomBottomBar *bottomBar;
@property (nonatomic, strong) RoomAudienceView *audienceView;
@property (nonatomic, strong) RoomChatView *chatView;
@property (nonatomic, strong) GiftPromptView *giftControl;

@property (nonatomic, strong) AnchorPromptView *anchorPromptView;
@property (nonatomic, strong) RoomGiftView *roomGiftView;

@property (nonatomic, strong) ABUIAnimateBanner *comeAnimateBanner;

@property (nonatomic, strong) UIButton *sceneButton;
@property (nonatomic, strong) UIImageView *sceneImageView;
@property (nonatomic, strong) ABUIWebView *wenluWebView;
@end

@implementation RoomControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.bbbView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:self.bbbView];
        
        self.briefView = [[RoomAnchorBriefView alloc] initWithFrame:CGRectMake(6, SYS_STATUSBAR_HEIGHT+10, 147, 36)];
        self.briefView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        self.briefView.layer.cornerRadius = self.briefView.height/2;
        self.briefView.delegate = self;
        [self addSubview:self.briefView];
        [self.briefView addTarget:self action:@selector(onBriefView) forControlEvents:UIControlEventTouchUpInside];
        [self.briefView setHidden:true];
        
        _bottomBar = [[RoomBottomBar alloc] initWithFrame:CGRectMake(0, self.height-TI_HEIGHT-44, SCREEN_WIDTH, 44+TI_HEIGHT)];
        _bottomBar.delegate = self;
        _bottomBar.backgroundColor = [[UIColor hexColor:@"#5B9399"] colorWithAlphaComponent:0.5];
        [self addSubview:_bottomBar];
        
        _audienceView = [[RoomAudienceView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-164-16,SYS_STATUSBAR_HEIGHT+10, 164, 30)];
        _audienceView.layer.cornerRadius = 15;
        [self addSubview:_audienceView];
        [_audienceView.countLabel addTarget:self action:@selector(onAuDienceView) forControlEvents:UIControlEventTouchUpInside];
        [_audienceView setHidden:true];
        
        _chatView = [[RoomChatView alloc] initWithFrame:CGRectMake(10, self.bottomBar.top-270, (SCREEN_WIDTH/3)*2+28, 270-10)];
        _chatView.delegate = self;
        [self.bbbView addSubview:_chatView];
        _bottomBar.commentView = _bbbView;
        
        self.comeAnimateBanner = [[ABUIAnimateBanner alloc] initWithFrame:CGRectMake(0, _chatView.top-30-5, SCREEN_WIDTH, 30)];
//        self.comeAnimateBanner.backgroundColor = [UIColor redColor];
        [self.bbbView addSubview:self.comeAnimateBanner];
        
        self.roomGiftView = [[RoomGiftView alloc] initWithFrame:CGRectMake(0, _comeAnimateBanner.top-100-5, self.width, 100)];
//        self.roomGiftView.backgroundColor = [UIColor purpleColor];
        [self.bbbView addSubview:self.roomGiftView];
        
        self.giftControl = [[GiftPromptView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    
        NSString *tip = @"欢迎来到直播间！严禁未成年人进行直播或打赏，清大家共同遵守，监督。直播间内严禁出现违法违规、低俗色情、吸烟酗酒等内容。若有违规内容请及时举报。如主播直播过程中以陪玩、送礼等方式进行诱导打赏、私下交易，清谨慎判断、以防人身或财产损失。清大家注意财产安全，谨防网络诈骗";
        [self.chatView receiveNewMessage:[self chatItem:@"" content:tip uid:@"0" nativeid:@"livecomment"]];
//        NSString *name = [Service shared].account.info[@"NickName"];
//        [self.chatView receiveNewNotice:@{@"name":name, @"uid":@([Service shared].account.uid)}];
        
        self.anchorPromptView = [[AnchorPromptView alloc] initWithFrame:CGRectMake(50, 0, self.width-100, 262)];
        self.anchorPromptView.layer.cornerRadius = 10;
        self.anchorPromptView.clipsToBounds = true;
        
        self.sceneButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 56, 30)];
        self.sceneButton.layer.cornerRadius = 15;
        self.sceneButton.clipsToBounds = true;
        [self.sceneButton setTitle:@"现场" forState:UIControlStateNormal];
        [self.sceneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.sceneButton.backgroundColor = [[UIColor hexColor:@"#3C3C3C"] colorWithAlphaComponent:0.6];
        self.sceneButton.titleLabel.font = [UIFont PingFangSC:12];
        [self addSubview:self.sceneButton];
        self.sceneButton.centerY = self.briefView.centerY;
        self.sceneButton.left = self.briefView.right+38;
        [self.sceneButton addTarget:self action:@selector(onScene) forControlEvents:UIControlEventTouchUpInside];
        
        self.sceneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [self.sceneImageView setImage:[UIImage imageNamed:@"gd_scene_down"]];
        [self.sceneImageView setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:self.sceneImageView];
        self.sceneImageView.centerX = self.sceneButton.centerX;
        self.sceneImageView.top = self.sceneButton.centerY+3;

        self.wenluWebView = [[ABUIWebView alloc] initWithFrame:CGRectMake(0, 100, 290, 130)];
        self.wenluWebView.bounces = false;
        [self addSubview:self.wenluWebView];
        [self.wenluWebView loadWebWithPath:@"http://192.168.0.101/wenlu/index.html"];
    }
    return self;
}

- (void)receiveWenLu:(NSArray *)list {
    NSDictionary *data = @{@"data":list};
    NSString *jsonString = [data toJSONString];
    [self.wenluWebView callFuncName:@"abc" data:jsonString completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
}

- (void)onScene {
    [self.sceneButton setSelected:!self.sceneButton.isSelected];
    if (self.sceneButton.isSelected) {
        [[RoomContext shared].shixunPlayView setHidden:false];
        [[RoomContext shared].shixunPlayView playURL:self.shixunPlayAddress];
        
        [self.sceneImageView setImage:[UIImage imageNamed:@"gd_scene_up"]];
    }else{
        [[RoomContext shared].shixunPlayView setHidden:true];
        [[RoomContext shared].shixunPlayView remove];
        [self.sceneImageView setImage:[UIImage imageNamed:@"gd_scene_down"]];
    }
    
}

#pragma mark ----- receive data --------
- (void)onReceivePeerMessage:(NSDictionary *)message {
    NSInteger lmd = [message[@"Lmd"] intValue];
    if (lmd == 2) { //禁言
        [ABUITips showError:@"您被禁言"];
        [RoomContext shared].isForbidden = true;
    }
    else if (lmd == 3) { //踢人
        [ABUITips showError:@"您被踢出"];
        [NSRouter back];
    }
    else if (lmd == 4) { //设置管理员
        [ABUITips showError:@"您被设置管理"];
        [RoomContext shared].isManager = true;
    }
    else if (lmd == 7) { //解除禁言
        [ABUITips showError:@"您被解除禁言"];
        [RoomContext shared].isForbidden = false;
    }
    else if (lmd == 8) { //解除管理
        [ABUITips showError:@"您被解除管理"];
        [RoomContext shared].isManager = false;
    }

}

- (void)onReceiveRoomMessage:(NSDictionary *)message {
    if (message[@"user"] != nil) {
        NSString *text = message[@"text"];
        NSString *username = message[@"user"][@"username"];
        if (username == nil) {
            return;
        }
        NSDictionary *mm = [self chatItem:username content:text uid:message[@"user"][@"userid"] nativeid:@"livecomment"];
        [self.chatView receiveNewMessage:mm];
        return;
    }
    
    NSInteger lmd = [message[@"Lmd"] intValue];
    if (lmd == 1) { //来了
        NSLog(@"laiel");
        NSString *username = message[@"UserNickname"];
        [self.audienceView setCount:[message[@"RoomCount"] intValue]];
//        [self.chatView receiveNewNotice:@{@"name":username, @"notice":@"来了", @"uid":message[@"UserId"]}];
        [self.comeAnimateBanner pushData:@{@"name":username, @"notice":@"来了", @"uid":message[@"UserId"], @"native_id":@"RoomComeRaw"}];
    }
    else if (lmd == 5) { //用户赠送礼物
        NSString *giftid = [NSString stringWithFormat:@"%@", message[@"GiftType"]];
        if ([giftid intValue] == 1) {
            [[GiftEffectsPlayView shared] showWithVideoFile:@""];
        }
        NSMutableDictionary *newdic = [[NSMutableDictionary alloc] initWithDictionary:message];
        [newdic setValue:[Stack shared].giftMap[giftid] forKey:@"gift"];
        [self.roomGiftView push:newdic];
    }
    else if (lmd == 6) {//排行榜
        NSArray *rank = message[@"Rank"];
        [self.audienceView setList:rank];
    }
    else if (lmd == 9) { //游戏变更
        [[RoomContext shared].playPresent requestDeskInfo:message];
    }
    else if (lmd == 10) {
        [self liveclose];
    }
    else if (lmd == 11) { //离开房间
        [[RoomContext shared].playControl anchorLeave];
    }
    else if (lmd == 12) { //回到房间
        [[RoomContext shared].playControl anchorReturn];
    }
}


- (void)liveclose {
    
}
- (void)receiveRoomInfo:(NSDictionary *)roomInfo {
    self.roomInfo = roomInfo;
    
    [self.briefView setHidden:false];
    [self.audienceView setHidden:false];
    
    NSDictionary *anchor = roomInfo[@"anchor"];
    NSString *name = anchor[@"NickName"];
    NSString *icon = anchor[@"Avater"];
    [self.briefView setname:name icon:icon count:[anchor[@"Fans"] intValue]];
    
    BOOL isFollowed = [roomInfo[@"isFollowed"] boolValue];
    self.briefView.isFollowed = isFollowed;
    self.anchorPromptView.isFollow = isFollowed;
    
    [self.audienceView setList:roomInfo[@"room"][@"rank"]];
    [self.audienceView setCount:[roomInfo[@"room"][@"roomcount"] intValue]];
}

- (void)receiveDeskInfo:(NSDictionary *)deskInfo {
    
}


#pragma mark --------- local ------------
- (NSDictionary *)chatItem:(NSString *)name content:(NSString *)content uid:(NSString *)uid nativeid:(NSString *)nativeid {
    NSInteger uu = 0;
    if (uid != nil) {
        uu = [uid intValue];
    }
    
    NSString *text = [NSString stringWithFormat:@"%@:%@", name, content];
    CGSize s = [text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake((SCREEN_WIDTH/3)*2, MAXFLOAT)];
    return @{
        @"uid":@(uu),
        @"name":name,
        @"content":content,
        @"native_id":nativeid,
        @"css":@{
            @"font":@(14),
            @"w":@(s.width),
            @"h":@(s.height),
        }
    };
}

- (void)onBriefView {
    [RP promptUserWithUid:RC.anchorid];
}

- (void)onAuDienceView {
    [RP promptGiftRank];
}

- (void)bottomBar:(RoomBottomBar *)bottomBar onText:(NSString *)text {
    [[RoomContext shared].socket sendText:text];
}

- (void)roomChatView:(RoomChatView *)roomChatView didSelectUid:(NSInteger)uid {
    [RP promptUserWithUid:uid];
}

#pragma mark ----- delegates -------
- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    if ([req.uri isEqualToString:URI_FOLLOW_FOLLOW]) {
        self.briefView.isFollowed = true;
    }
    if ([req.uri isEqualToString:URI_ROOM_GIFTRANK]) {
        [self.audienceView setList:obj[@"list"]];
    }
}

//左侧用户试图
- (void)roomAnchorBriefViewOnFollow:(RoomAnchorBriefView *)roomAnchorBriefView {
    [self fetchPostUri:URI_FOLLOW_FOLLOW params:@{@"live_uid":@([RoomContext shared].anchorid)}];
}

- (void)bottomBarOnClose:(RoomBottomBar *)bottomBar {
    [self onClose];
}

- (void)bottomBarOnMore:(RoomBottomBar *)bottomBar {
    [self onMore];
}

- (void)bottomBarOnGift:(RoomBottomBar *)bottomBar {
    [self onGift];
}

- (void)onClose {
    
}

- (void)onGift {
    [self.giftControl refreshWithRoomID:RC.roomid liveuid:RC.anchorid];
    [[ABUIPopUp shared] show:self.giftControl from:ABPopUpDirectionBottom];
}

- (void)onMore {
    
}

- (void)refreshRank {
    [self fetchPostUri:URI_ROOM_GIFTRANK params:@{@"room_id":@(RC.roomid)}];
}
@end

