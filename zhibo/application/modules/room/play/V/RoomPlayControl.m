//
//  RoomPlayControl.m
//  zhibo
//
//  Created by qp on 2020/7/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RoomPlayControl.h"
#import "BetView.h"
#import "GameStatusPlateView.h"
#import "BetResultView.h"
#import "GameResultPromptView.h"
@interface RoomPlayControl ()<BetViewDelegate, ABUIListViewDelegate, IABMQSubscribe, GameStatusPlateViewDelegate>
@property (nonatomic, strong) ABUIListView *moreListView;
@property (nonatomic, strong) BetView *betView;
@property (nonatomic, strong) UIControl *maskView;
@property (nonatomic, strong) GameStatusPlateView *plateView;
@property (nonatomic, strong) GameResultPromptView *gameResultPromptView;
@property (nonatomic, strong) UIButton *jiesuanButton;

@property (nonatomic, strong) NSDictionary *desk;
@property (nonatomic, strong) NSDictionary *deskInfo;
@property (nonatomic, assign) NSInteger deskId;
@property (nonatomic, assign) NSInteger gameid;
@property (nonatomic, assign) NSInteger MaxLimit;
@property (nonatomic, assign) NSInteger MinLimit;

@property (nonatomic, strong) UILabel *leaveLabel;


@end
@implementation RoomPlayControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.maskView = [[UIControl alloc] initWithFrame:self.bounds];
        self.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        [self.maskView addTarget:self action:@selector(hideMaskView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.maskView];
        [self hideMaskView];
        
        self.moreListView = [[ABUIListView alloc] initWithFrame:CGRectMake(0, 0, self.width, 200)];
        NSArray *dataList = @[
            @{
                @"title":@"下注",
                @"icon":@"youxi",
                @"native_id":@"titleimage"
            },
            @{
                @"title":@"分享",
                @"icon":@"guanliyuan",
                @"native_id":@"titleimage"
            }
        ];
        
        NSDictionary *css = @{@"item.size.width":@"25%", @"item.size.height":@"25%"};
        self.moreListView.backgroundColor = [[UIColor hexColor:@"#232828"] colorWithAlphaComponent:0.88];
        [self.moreListView setDataList:dataList css:css];
        self.moreListView.delegate = self;
        
        self.betView = [[BetView alloc] initWithFrame:CGRectMake(0, 0, self.width, 160+44)];
        self.betView.delegate = self;
        self.betView.top = self.height;
        [self addSubview:self.betView];
        
        self.plateView = [[GameStatusPlateView alloc] initWithFrame:CGRectMake(self.width-66-10, self.height-TI_HEIGHT-44-66-10, 66, 66)];
        self.plateView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.58];
        self.plateView.layer.cornerRadius = 33;
        [self addSubview:self.plateView];
        [self.plateView addTarget:self action:@selector(onPlate) forControlEvents:UIControlEventTouchUpInside];
        self.plateView.delegate = self;
        [self.plateView watch];
        [self.plateView setHidden:true];
        
        self.gameResultPromptView = [[GameResultPromptView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height/2)];
        
        self.leaveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height/2-44, self.width, 44)];
        self.leaveLabel.text = @"主播暂时离开，马上回来";
        self.leaveLabel.textAlignment = NSTextAlignmentCenter;
        self.leaveLabel.font = [UIFont PingFangSCBlod:18];
        self.leaveLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.leaveLabel];
        [self.leaveLabel setHidden:true];
        
        [[ABMQ shared] subscribe:self channels:@[CHANNEL_ROOM_GAME, @"CHANNEL_ROOM_ROOM", @"CHANNEL_ROOM_PEER"] autoAck:true];

    }
    return self;
}

- (void)onPlate {
    [self showBetView];
}

#pragma mark ----------- local action -----------
- (void)onMore {
    [[ABUIPopUp shared] show:self.moreListView from:ABPopUpDirectionBottom];
}

- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item {
    [[ABUIPopUp shared] remove];
    if (indexPath.row == 0) {
        if (self.deskInfo == nil) {
            [ABUITips showError:@"主播未设置游戏"];
            return;
        }
        [self showBetView];
    }
}

//- (void)onFollow {
//    [[RoomContext shared].present followLiveWithUID:[self.roomInfo[@"desk"][@"LiveUid"] intValue]];
//}

- (void)onClose {
    [NSRouter back];
}

#pragma mark ----------- betview delegate --------------
- (void)betView:(BetView *)betView onConfirmWithData:(NSDictionary *)data {
    NSInteger total = 0;
    for (NSString *item in [data allValues]) {
        total+=[item integerValue];
    }
    if (total >= self.MinLimit && total <= self.MaxLimit) {
        NSDictionary *info = [[NSMutableDictionary alloc] initWithDictionary:data];
        [info setValuesForKeysWithDictionary:self.deskInfo];
        [[RoomContext shared].playPresent doBet:info];
    }else{
        [ABUITips showError:@"下注超出限红"];
    }
}

- (void)betViewOnCancel:(BetView *)betView {
    [[RoomContext shared].playPresent doBetCancel:self.deskInfo];
}


- (void)receiveDeskInfo:(NSDictionary *)deskInfo {
    [self.plateView setHidden:false];
    self.shixunPlayAddress = deskInfo[@"LeftPlay"];
    self.MaxLimit = [deskInfo[@"MaxLimit"] integerValue];
    self.MinLimit = [deskInfo[@"MinLimit"] integerValue];
    self.gameid = [deskInfo[@"GameId"] intValue];
    [[RoomContext shared].gamesocket stopRoom];
    [[RoomContext shared].gamesocket startRoomWithID:[deskInfo[@"DeskId"] intValue]];
    
    [self refreshDesk:deskInfo];
    
    [self showBetView];
}

- (void)receiveBetRules:(NSDictionary *)betRules {
    [self.betView setCoins:betRules[@"coins"] options:betRules[@"options"] sounds:betRules[@"sounds"] limit:betRules[@"tip"]];
}

- (void)receiveBetSuccess {
    self.betView.isBet = true;
    [ABUITips showError:@"下注成功"];
}

- (void)hideMaskView {
    [self.maskView setHidden:true];
    [self hideBetView];
}

- (void)showBetView {
    [self.maskView setHidden:false];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView animateWithDuration:0.1 animations:^{
        self.betView.top = self.height-TI_HEIGHT-44-self.betView.height;
        self.plateView.top = self.betView.top-self.plateView.height-10+44;
    }];
}

- (void)hideBetView {
    [self.maskView setHidden:true];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView animateWithDuration:0.1 animations:^{
        self.betView.top = self.height;
        self.plateView.top = self.height-TI_HEIGHT-44-self.plateView.height-10;
    }];
}

- (BOOL)isSelf:(NSDictionary *)dic {
    NSInteger curDeskId = [dic[@"DeskId"] integerValue];
    if (self.deskId != curDeskId) {
        return false;
    }
    return true;
}

- (void)plateView:(GameStatusPlateView *)plateView onStatusChanged:(GameStatusPlateViewStatus)status {
    if (status == GameStatusPlateViewStatusWait) {
        self.betView.enabled = false;//禁止下注
        if (self.betView.isBet == false) {
            [self.betView reset];
        }
    }
}

- (void)abmq:(ABMQ *)abmq onReceiveMessage:(id)message channel:(NSString *)channel {
    if (![message isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    NSDictionary *dic = (NSDictionary *)message;
    if ([channel isEqualToString:CHANNEL_ROOM_GAME]) {
        if ([dic isKindOfClass:[NSDictionary class]] && dic[@"Cmd"] != nil) {
            if ([self isSelf:dic] == false) {
                return;
            }
            [self refreshDesk:dic];
        }
    }
    else if ([channel isEqualToString:@"CHANNEL_ROOM_ROOM"]) {
        [self onReceiveRoomMessage:message];
    }
    else if ([channel isEqualToString:@"CHANNEL_ROOM_PEER"]) {
        [self onReceivePeerMessage:message];
    }
}

- (void)refreshDesk:(NSDictionary *)desk {
    if (desk == nil) {
        return;
    }
    self.deskId = [desk[@"DeskId"] integerValue]; //刷新台桌ID
    
    //下注时传递的台桌信息准备
    NSDictionary *mm = @{
        @"DeskName":@"DeskName",
        @"DeskId":@"desk_id",
        @"Boot_num":@"boot_num",
        @"Pave_num":@"pave_num",
        @"BootNum":@"boot_num",
        @"PaveNum":@"pave_num"
    };
    self.deskInfo = [ABIteration pickKeysAndReplaceWithMapping:mm fromDictionary:desk];
    self.desk = desk;
    //获取台桌状态，执行相应UI更新
    //Phase:0洗牌中1倒计时(开始下注)2开牌中(停止下注)3结算完成
    //cmd: 10 下注成功
    int phase = -1;
    if (desk[@"Phase"] != nil) {
        phase = [desk[@"Phase"] intValue];
    }
    
    int cmd = [desk[@"Cmd"] intValue];
    if (cmd == 6) {
        phase = 4;
    }
    
    switch (phase) {
        case 0: //洗牌中
            [self.plateView watch]; //变更洗牌中
            
            self.betView.enabled = false; //禁止下注
            [self.betView reset]; //重置下注盘
            break;
        case 1://开始下注
            [self.plateView please:desk]; //开启下注倒计时
            
            self.betView.enabled = true; //开启下注
            [self showBetView]; //弹出下注UI
            [self.betView reset]; //重置下注盘
            break;
        case 2://开牌中(停止下注)
            [self.plateView wait]; //变更待开牌
            
            self.betView.enabled = false;//禁止下注
            if (self.betView.isBet == false) {
                [self.betView reset];
            }
            break;
        case 3://结算完成
            [self.plateView finish];
            
            self.betView.enabled = false;//禁止下注
            break;
        case 4://结算完成(有结果)
            [self.plateView finish];
            
            self.betView.enabled = false;//禁止下注
            [self.jiesuanButton setHidden:false];
            [RP promptGameResultWithGameId:self.gameid winner:desk[@"Winner"]];
            [self showBetView];
            [[RoomContext shared].playControl receiveWenLuItem:desk];
            
            break;
        default:
            break;
    }
}

- (void)kickoff {
    [ABUITips showError:@"您被踢出"];
    [NSRouter back];
}

- (void)liveclose {
    [self.delegate roomPlayControl:self closeWithData:self.roomInfo];
}

- (void)anchorLeave {
    [self.leaveLabel setHidden:false];
}

- (void)anchorReturn {
    [self.leaveLabel setHidden:true];
}
@end
