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
#import "GameStatusPlateView.h"
#import "BetView.h"
#import "GameManager.h"
#import "BetTransform.h"
#import "MoneyInPrompt.h"
@interface RoomControl ()<RoomBottomBarDelegate, RoomChatViewDelegate, INetData, RoomAnchorBriefViewDelegate, GameStatusPlateViewDelegate, BetViewDelegate, IABMQSubscribe, RoomPlayViewDelegate>
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

@property (nonatomic, strong) RoomPlayView *shixunPlayView;

@property (nonatomic, assign) BOOL isFirstTan;

@property (nonatomic, strong) NSMutableArray *wenluList;
@property (nonatomic, strong) UIView *wenluActionView;

@property (nonatomic, strong) NSString *webPath;
@end

@implementation RoomControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.isFirstTan = true;
        self.bbbView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:self.bbbView];
        
        self.briefView = [[RoomAnchorBriefView alloc] initWithFrame:CGRectMake(6, SYS_STATUSBAR_HEIGHT+10, 147, 36)];
        self.briefView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        self.briefView.layer.cornerRadius = self.briefView.height/2;
        self.briefView.delegate = self;
        
        [self.briefView addTarget:self action:@selector(onBriefView) forControlEvents:UIControlEventTouchUpInside];
        [self.briefView setHidden:true];
        
        _bottomBar = [[RoomBottomBar alloc] initWithFrame:CGRectMake(0, self.height-TI_HEIGHT-44, SCREEN_WIDTH, 44+TI_HEIGHT)];
        _bottomBar.delegate = self;
        _bottomBar.backgroundColor = [[UIColor hexColor:@"#5B9399"] colorWithAlphaComponent:0.5];
        [self addSubview:_bottomBar];
        
        _audienceView = [[RoomAudienceView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-164-16,SYS_STATUSBAR_HEIGHT+10, 164, 30)];
        _audienceView.layer.cornerRadius = 15;
       
        [_audienceView.countLabel addTarget:self action:@selector(onAuDienceView) forControlEvents:UIControlEventTouchUpInside];
        [_audienceView setHidden:true];
        
        _chatView = [[RoomChatView alloc] initWithFrame:CGRectMake(10, self.bottomBar.top-270, (SCREEN_WIDTH/3)*2+28, 270-10)];
        _chatView.delegate = self;
        [self.bbbView addSubview:_chatView];
        _bottomBar.commentView = _bbbView;
        
        self.shixunPlayView = [[RoomPlayView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*(9.0/16.0))];
        [self addSubview:self.shixunPlayView];
        self.shixunPlayView.delegate = self;
        self.shixunPlayView.erNotice = @"暂无现场画面";
        [self.shixunPlayView setHidden:true];
        [self addSubview:self.briefView];
         [self addSubview:_audienceView];
        
        self.comeAnimateBanner = [[ABUIAnimateBanner alloc] initWithFrame:CGRectMake(0, _chatView.top-30-5, SCREEN_WIDTH, 30)];
//        self.comeAnimateBanner.backgroundColor = [UIColor redColor];
        [self.bbbView addSubview:self.comeAnimateBanner];
        
        self.roomGiftView = [[RoomGiftView alloc] initWithFrame:CGRectMake(0, _comeAnimateBanner.top-100-5, self.width, 100)];
//        self.roomGiftView.backgroundColor = [UIColor purpleColor];
        [self.bbbView addSubview:self.roomGiftView];
        
        self.giftControl = [[GiftPromptView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    
//        [self.chatView receiveNewMessage:[self chatItem:@"" content:tip uid:@"0" nativeid:@"livecomment"]];
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
        self.sceneButton.left = self.width-15-56;
        self.sceneButton.top = _audienceView.bottom+5;
        [self.sceneButton addTarget:self action:@selector(onScene) forControlEvents:UIControlEventTouchUpInside];
        
        self.sceneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [self.sceneImageView setImage:[UIImage imageNamed:@"gd_scene_down"]];
        [self.sceneImageView setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:self.sceneImageView];
        self.sceneImageView.centerX = self.sceneButton.centerX;
        self.sceneImageView.top = self.sceneButton.centerY+3;
        
        self.plateView = [[GameStatusPlateView alloc] initWithFrame:CGRectMake(self.width-66-10, self.height-TI_HEIGHT-44-66-10, 66, 66)];
        self.plateView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.58];
        self.plateView.layer.cornerRadius = 33;
        [self addSubview:self.plateView];
        [self.plateView addTarget:self action:@selector(onPlate) forControlEvents:UIControlEventTouchUpInside];
        self.plateView.delegate = self;
        [self.plateView watch];
        [self.plateView setHidden:true];
        [self loadWenLu];
        RC.briefView = self.briefView;
        
        [[ABMQ shared] subscribe:self channels:@[CHANNEL_GAME_RULES, CHANNEL_ROOM_INFO, CHANNEL_ROOM_MESSAGE, CHANNEL_ROOM_PEER, CHANNEL_GAME_STATUS] autoAck:true];
        
        [self fetchPostUri:URI_ROOM_SYSTEM params:nil];
        

    }
    return self;
}

- (void)roomPlayViewLoadFail {
    
}

- (void)loadGame {
    
}

- (void)loadWenLu {
    if (self.wenluWebView == nil) {
        self.wenluWebView = [[ABUIWebView alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH*(9.0/16.0), 300, 180)];
        [self.wenluWebView.webView setOpaque:false];
//        self.wenluWebView.adapterSize = true;
        self.wenluWebView.backgroundColor = [UIColor clearColor];
        self.wenluWebView.webView.scrollView.backgroundColor = [UIColor clearColor];
        self.wenluWebView.bounces = false;
        self.wenluWebView.isShowProgress = false;
        [self addSubview:self.wenluWebView];
        self.wenluWebView.top = self.briefView.bottom+10;
    }
    if ([self.webPath isEqualToString:self.wenluWebView.webPath] == false) {
        [self.wenluWebView loadWebWithPath:self.webPath];
        [self.wenluWebView setHidden:false];
    }
    
//    [self.wenluWebView loadWebWithPath:@"index.html"];
//    [self.wenluWebView setHidden:true];

}

- (void)loadWenLuActionView {
    self.wenluActionView = [[UIView alloc] initWithFrame:CGRectMake(0, self.wenluWebView.bottom, self.wenluWebView.width, 40)];
    self.wenluActionView.backgroundColor = [UIColor redColor];
    [self addSubview:self.wenluActionView];
}

- (void)receiveWenLu:(NSArray *)list {
    NSLog(@"receiveWenLu");
    dispatch_main_async_safe((^{
        NSDictionary *data = @{@"data":list, @"gameid":@(RC.gameManager.game_id), @"boot_num":@(RC.gameManager.boot_num), @"pave_num":@(RC.gameManager.pave_num)};
        NSString *jsonString = [data toJSONString];
        [self.wenluWebView callFuncName:@"setGameResults" data:jsonString completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
            NSLog(@"%@", error);
        }];
    }));
}
//弃用
- (void)receiveWenLuItem:(NSDictionary *)item {
    id winner = item[@"Winner"];
    if ([winner isKindOfClass:[NSString class]] && [(NSString *)winner containsString:@"game"]) {
        NSDictionary *winner = [item[@"Winner"] toDictionary];
        NSDictionary *dic = @{@"Winner":winner};
        [self.wenluWebView callFuncName:@"setNewResult" data:[dic toJSONString] completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
            NSLog(@"%@", error);
        }];
    }else{
        [self.wenluWebView callFuncName:@"setNewResult" data:[item toJSONString] completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
            NSLog(@"%@", error);
        }];
    }
}

- (void)onPlate {
    if (RC.gameManager.rules == nil) {
        [ABUITips showError:@"主播未设置游戏"];
        return;
    }
    __weak __typeof(&*self) weakSelf = self;
    [RP promptBetView:[RoomContext shared].gameManager.rules hideBlock:^{
        [UIView animateWithDuration:0.1 animations:^{
            weakSelf.plateView.top = weakSelf.height-TI_HEIGHT-44-66-10;
        }];
        
    } showBlock:^{
        [UIView animateWithDuration:0.1 animations:^{
            weakSelf.plateView.top = weakSelf.height-TI_HEIGHT-44-66-10-164-30;
        }];
    }];
}

- (void)onPlate2 {
    NSLog(@"onPlate2");
    if (RC.gameManager.rules == nil) {
        return;
    }
    __weak __typeof(&*self) weakSelf = self;
    [RP promptBetView:[RoomContext shared].gameManager.rules hideBlock:^{
        [UIView animateWithDuration:0.1 animations:^{
            weakSelf.plateView.top = weakSelf.height-TI_HEIGHT-44-66-10;
        }];
        
    } showBlock:^{
        [UIView animateWithDuration:0.1 animations:^{
            weakSelf.plateView.top = weakSelf.height-TI_HEIGHT-44-66-10-164-30;
        }];
    }];
}


- (void)refreshScene {
    if (self.sceneButton.isSelected) {
        if ([RC.gameManager.shixunPlayAddress isEqualToString:self.shixunPlayView.currentURL]) {
            return;
        }
        [self.shixunPlayView playURL:RC.gameManager.shixunPlayAddress];
    }
}
- (void)onScene {
    [self.sceneButton setSelected:!self.sceneButton.isSelected];
    if (self.sceneButton.isSelected) {
        [self.shixunPlayView setHidden:false];
        [self.shixunPlayView playURL:RC.gameManager.shixunPlayAddress];
        self.wenluWebView.top = self.shixunPlayView.bottom;
        
        
        [self.sceneImageView setImage:[UIImage imageNamed:@"gd_scene_up"]];
    }else{
        [self.shixunPlayView setHidden:true];
        [self.shixunPlayView remove];
        [self.sceneImageView setImage:[UIImage imageNamed:@"gd_scene_down"]];
        self.wenluWebView.top = self.briefView.bottom+10;
    }
    
    self.wenluActionView.top = self.wenluWebView.bottom;
    
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
        [self.plateView stop];
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
        NSInteger uid = [message[@"UserId"] integerValue];
        if (uid != [Service shared].account.uid) {
            NSString *username = message[@"UserNickname"];
            [self.audienceView setCount:[message[@"RoomCount"] intValue]];
    //        [self.chatView receiveNewNotice:@{@"name":username, @"notice":@"来了", @"uid":message[@"UserId"]}];
            [self.comeAnimateBanner pushData:@{@"name":username, @"notice":@"来了", @"uid":message[@"UserId"], @"native_id":@"RoomComeRaw"}];
        }

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
//        {
//            DeskId = 3;
//            GameId = 1;
//            Lmd = 9;
//            RoomId = 5;
//        }
        [RoomContext shared].gameManager.desk_id = [message[@"DeskId"] intValue];
        [[RoomContext shared].gameManager _refreshDeskInfo];
        [self.plateView stop];
    }
    else if (lmd == 10) {
        [self liveclose];
        [self.plateView stop];
    }
    else if (lmd == 11) { //离开房间
        [self anchorLeave];
    }
    else if (lmd == 12) { //回到房间
        [self anchorReturn];
    }
}


- (void)liveclose {
    
}

- (void)rliveclose {
    
}

- (void)receiveRoomInfo:(NSDictionary *)roomInfo {
    NSLog(@"receiveRoomInfo");
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
    
    if (self.isFirstTan) {
        self.isFirstTan = false;
        [self onScene];
    }
    
}

- (void)receiveDeskInfo:(NSDictionary *)deskInfo {
    [self.plateView setHidden:false];
}


#pragma mark --------- local ------------
- (NSDictionary *)chatItem:(NSString *)name content:(NSString *)content uid:(NSString *)uid nativeid:(NSString *)nativeid {
    NSInteger uu = 0;
    if (uid != nil) {
        uu = [uid intValue];
    }
    
    NSString *text = [NSString stringWithFormat:@"%@:%@", name, content];
    CGSize s = [text sizeWithFont:[UIFont boldSystemFontOfSize:14] constrainedToSize:CGSizeMake((SCREEN_WIDTH/3)*2, MAXFLOAT)];
    return @{
        @"uid":@(uu),
        @"name":name,
        @"content":content,
        @"native_id":nativeid,
        @"css":@{
            @"font":@(14),
            @"w":@(s.width+2),
            @"h":@(s.height),
        }
    };
}

- (void)onBriefView {
    [RP promptUserWithUid:RC.roomManager.anchorid];
}

- (void)onAuDienceView {
    [RP promptGiftRank];
}

- (void)bottomBar:(RoomBottomBar *)bottomBar onText:(NSString *)text {
    [[RoomContext shared].roomManager sendText:text];
}

- (void)roomChatView:(RoomChatView *)roomChatView didSelectUid:(NSInteger)uid {
//    [RP promptUserWithUid:uid];
}

#pragma mark ----- delegates -------
- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    if ([req.uri isEqualToString:URI_ROOM_SYSTEM]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:[self chatItem:@"" content:obj[@"text"] uid:@"0" nativeid:@"livecomment"]];
        dic[@"color"] = obj[@"color"];
        dic[@"type"] = @"sys";
        RC.roomManager.nickcolor = obj[@"nick_color"];
        RC.roomManager.talkcolor = obj[@"talk_color"];
        [self.chatView receiveNewMessage:dic];
    }
    if ([req.uri isEqualToString:URI_FOLLOW_FOLLOW]) {
        self.briefView.isFollowed = true;
    }
    if ([req.uri isEqualToString:URI_ROOM_GIFTRANK]) {
        [self.audienceView setList:obj[@"list"]];
    }
    if ([req.uri isEqualToString:URI_ACCOUNT_BALANCE_INFO]) {
        NSString *balanceText = [obj stringValueForKey:@"info"];
        [[ABUIPopUp shared] remove:0];
        MoneyInPrompt *prompt = [[MoneyInPrompt alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-30, 200)];
        [prompt.layer setCornerRadius:10];
        [prompt setBalance:balanceText];
        [[ABUIPopUp shared] show:prompt from:ABPopUpDirectionTop distance:SCREEN_HEIGHT/4 hideBlock:^{
        }];
    }
}

//左侧用户试图
- (void)roomAnchorBriefViewOnFollow:(RoomAnchorBriefView *)roomAnchorBriefView {
    [self fetchPostUri:URI_FOLLOW_FOLLOW params:@{@"live_uid":@([RoomContext shared].roomManager.anchorid)}];
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
    [self.giftControl refreshWithRoomID:RC.roomManager.roomid liveuid:RC.roomManager.anchorid];
    [[ABUIPopUp shared] show:self.giftControl from:ABPopUpDirectionBottom];
}

- (void)onMore {
    [RP promptMoreActions:^(NSInteger index) {
        if (index == 0) {
            [self onPlate];
        }
        if (index == 1) {
            [self edu];
        }
    }];
}

- (void)refreshRank {
    [self fetchPostUri:URI_ROOM_GIFTRANK params:@{@"room_id":@(RC.roomManager.roomid)}];
}


- (void)abmq:(ABMQ *)abmq onReceiveMessage:(id)message channel:(NSString *)channel {
    if ([channel isEqualToString:CHANNEL_GAME_RULES]) {
//        [self onPlate2];
        [self refreshScene];
        [self.plateView setHidden:false];
        
        if (RC.gameManager.game_id == 1 || RC.gameManager.game_id == 2) {
            self.webPath = @"index.html";
        }else{
            self.webPath = @"index2.html";
        }
        [self loadWenLu];
        
    }
    if ([channel isEqualToString:CHANNEL_ROOM_INFO]) {
        [self receiveRoomInfo:message];
    }
    if ([channel isEqualToString:CHANNEL_ROOM_MESSAGE]) {
        [self onReceiveRoomMessage:message];
    }
    if ([channel isEqualToString:CHANNEL_ROOM_PEER]) {
        [self onReceivePeerMessage:message];
    }

    if ([channel isEqualToString:CHANNEL_GAME_STATUS]) {
        NSDictionary *dic = (NSDictionary *)message;
        NSInteger status = [dic[@"status"] integerValue];
        NSDictionary *desk = dic[@"data"];
        switch (status) {
            case 0: //洗牌中
                [self.plateView watch]; //变更洗牌中

                [RoomPrompt shared].betView.enabled = false; //禁止下注
                [[RoomPrompt shared].betView reset]; //重置下注盘
                break;
            case 1://开始下注
                [self.plateView please:desk]; //开启下注倒计时
                NSLog(@"开始下注");
                [RoomPrompt shared].betView.enabled = true; //开启下注
                [self onPlate2]; //弹出下注UI
                [[RoomPrompt shared].betView reset]; //重置下注盘
                break;
            case 2://开牌中(停止下注)
                [self.plateView wait]; //变更待开牌
                [[RoomPrompt shared].betView timeEnd];
                [RoomPrompt shared].betView.enabled = false;//禁止下注
                break;
            case 3://结算完成
                [self.plateView finish];

                [RoomPrompt shared].betView.enabled = false;//禁止下注
                break;
            case 4://结算完成(有结果)
            {
                [self.plateView finish];
                
                [RoomPrompt shared].betView.enabled = false;//禁止下注
//                [RP promptGameResultWithGameId:RC.gameManager.game_id winner:desk[@"Winner"]];
                
//                [self receiveWenLuItem:desk];
                [RC.gameManager refreshwenlu];
                [RC.gameManager refreshBalance];
                NSString *name = [[BetTransform shared] getMusicGid:RC.gameManager.game_id winner:desk[@"Winner"]];
                [[ABAudio shared] playBundleFileWithMultipleName:name];
            }

                
                break;
            case 7://结算完成(下注后有结果)
                NSLog(@"结算完成");
                [RP promptGameBetResult:desk];
               break;
            case 8://换靴
                [self receiveWenLu:@[]];
                break;
            default:
                break;
        }
    }
}

- (void)plateView:(GameStatusPlateView *)plateView onStatusChanged:(GameStatusPlateViewStatus)status {
    if (status == GameStatusPlateViewStatusWait) {
        [RoomPrompt shared].betView.enabled = false;//禁止下注
        [RP.betView timeEnd];
    }
}

- (void)anchorLeave {
    
}

- (void)anchorReturn {
    
}

- (void)free {
    [self.plateView stop];
    [[ABMQ shared] unsubscribe:self];
    [self.shixunPlayView free];
}

- (void)dealloc
{
    NSLog(@"%@ dealloc", [[self class] description]);
    [self.plateView stop];
    [self.shixunPlayView free];
    [[ABMQ shared] unsubscribe:self];
    self.wenluWebView.delegate = nil;
    [self.wenluWebView free];
    [self.wenluWebView removeFromSuperview];
    
}

//- (void)abmq:(ABMQ *)abmq onReceiveMessage:(id)message channel:(NSString *)channel {
//    if (![message isKindOfClass:[NSDictionary class]]) {
//        return;
//    }
//
//    NSDictionary *dic = (NSDictionary *)message;
//    if ([channel isEqualToString:CHANNEL_ROOM_GAME]) {
//        if ([dic isKindOfClass:[NSDictionary class]] && dic[@"Cmd"] != nil) {
//            if ([self isSelf:dic] == false) {
//                return;
//            }
//            [self refreshDesk:dic];
//        }
//    }
//    else if ([channel isEqualToString:@"CHANNEL_ROOM_ROOM"]) {
//        [self onReceiveRoomMessage:message];
//    }
//    else if ([channel isEqualToString:@"CHANNEL_ROOM_PEER"]) {
//        [self onReceivePeerMessage:message];
//    }
//}

- (void)edu {
    [self fetchPostUri:URI_ACCOUNT_BALANCE_INFO params:nil];
}

@end

