//
//  RoomPromptView.m
//  zhibo
//
//  Created by qp on 2020/7/14.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RoomPrompt.h"
#import "UserPromptView.h"
#import "AnchorFuncPromptView.h"
#import "MeiYanPromptView.h"
#import "GamesPromptView.h"
#import "DesksPromptView.h"
#import "RoomManagerPromptView.h"
#import "TopicsPromptView.h"
#import "ChannelsPromptView.h"
#import "GiftRankPromptView.h"
#import "AnchorPromptView.h"
#import "GameResultPromptView.h"
#import "BetView.h"
#import "GameBetResultView.h"
#import "MoneyInPrompt.h"
@interface RoomPrompt ()<TopicsPromptViewDelegate, ChannelsPromptViewDelegate, GamesPromptViewDelegate, DesksPromptViewDelegate, ABUIListViewDelegate, BetViewDelegate>
@property (nonatomic, strong) UserPromptView *userPromptView; //聊天点击展示用户试图
@property (nonatomic, strong) AnchorPromptView *anchorPromptView; //主播视图
@property (nonatomic, strong) AnchorFuncPromptView *anchorFuncPromptView;//主播多功能
@property (nonatomic, strong) MeiYanPromptView *meiyanPromptView; //美颜
@property (nonatomic, strong) DesksPromptView *desksPromptView; //选择游戏台桌
@property (nonatomic, strong) GamesPromptView *gamesPrompView; //主播游戏选择
@property (nonatomic, strong) RoomManagerPromptView *roomMangerPromptView; //房间管理员列表
@property (nonatomic, strong) TopicsPromptView *topicsPromptView;
@property (nonatomic, strong) ChannelsPromptView *cannelsPromptView;
@property (nonatomic, strong) GiftRankPromptView *giftrankPromptView; //房间礼物排行榜
@property (nonatomic, strong) GameResultPromptView *gameResultPromptView;
@property (nonatomic, strong) ABUIListView *moreActionView;



@property (nonatomic, strong) TitleBlock topicsBlock;
@property (nonatomic, strong) TitleBlock channelsBlock;
@property (nonatomic, strong) GameBlock gameBlock;
@property (nonatomic, strong) IndexBlock moreActionIndexBlock;
@property (nonatomic, assign) NSInteger gameid;
@end
@implementation RoomPrompt
+ (RoomPrompt *)shared {
    static RoomPrompt *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (BetView *)betView {
    if (!_betView) {
        self.betView = [[BetView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 204)];
        self.betView.delegate = self;
    }
    return _betView;
}

#pragma mark --------------
- (void)promptAnchor {
    self.anchorPromptView = [[AnchorPromptView alloc] initWithFrame:CGRectMake(50, 0, SCREEN_WIDTH-100, 262)];
    self.anchorPromptView.layer.cornerRadius = 10;
    self.anchorPromptView.clipsToBounds = true;
}

#pragma mark --------------
- (void)promptUserWithUid:(NSInteger)uid {
    if (uid == 0) {
//        [ABUITips showError:@"用户ID错误"];
        return;
    }
    if (uid == [Service shared].account.uid) {
        self.userPromptView = [[UserPromptView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 168+72/2+TI_HEIGHT)];
        [self.userPromptView removeActionView];
    }else{
        self.userPromptView = [[UserPromptView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 218+72/2+TI_HEIGHT)];
    }
    
    [self.userPromptView refreshWith:uid roomid:RC.roomManager.roomid];
    [[ABUIPopUp shared] show:self.userPromptView from:ABPopUpDirectionBottom];
}

#pragma mark --------------
- (void)promptBeauty {
    self.meiyanPromptView = [[MeiYanPromptView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150+TI_HEIGHT)];
    [[ABUIPopUp shared] show:self.meiyanPromptView from:ABPopUpDirectionBottom];
}

#pragma mark ----------------- topic -----------
- (void)promptTopic:(TitleBlock)block {
    self.topicsBlock = block;
    self.topicsPromptView = [[TopicsPromptView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.6)];
    self.topicsPromptView.delegate = self;
    [[ABUIPopUp shared] show:self.topicsPromptView from:ABPopUpDirectionBottom];
}

- (void)topicsPromptView:(TopicsPromptView *)topicsPromptView didSelectTopic:(NSString *)topic {
    [[ABUIPopUp shared] remove];
    self.topicsBlock(topic);
}

#pragma mark ----------------- channels -----------
- (void)promptChannels:(TitleBlock)block {
    self.channelsBlock = block;
    self.cannelsPromptView = [[ChannelsPromptView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.6)];
    self.cannelsPromptView.delegate = self;
    [[ABUIPopUp shared] show:self.cannelsPromptView from:ABPopUpDirectionBottom];
}

- (void)channelsPromptView:(ChannelsPromptView *)channelsPromptView didSelectChannel:(NSString *)channel {
    [[ABUIPopUp shared] remove];
    self.channelsBlock(channel);
}

#pragma mark --------------
- (void)promptGiftRank {
    self.giftrankPromptView = [[GiftRankPromptView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.6)];
    self.giftrankPromptView.layer.cornerRadius = 10;
    self.giftrankPromptView.clipsToBounds = true;
    [self.giftrankPromptView refreshWithRoomID:RC.roomManager.roomid];
    [[ABUIPopUp shared] show:self.giftrankPromptView from:ABPopUpDirectionBottom];
}

#pragma mark ---------
- (void)promptGameBlock:(GameBlock)block {
    self.gameBlock = block;
    self.gamesPrompView = [[GamesPromptView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 144)];
    self.gamesPrompView.delegate = self;
    [[ABUIPopUp shared] show:self.gamesPrompView from:ABPopUpDirectionBottom];
}
#pragma mark ---------
- (void)promptGameResultWithGameId:(NSInteger)gameid winner:(id)winner {
    [[ABUIPopUp shared] remove:0];
    
    NSString *winKey = [NSString stringWithFormat:@"%@", winner];
    if ([winKey containsString:@"{"] && [winKey containsString:@"}"]) {
        NSDictionary *dic = [winKey toDictionary];
        winKey = [[dic allValues] componentsJoinedByString:@","];
    }
    
    self.gameResultPromptView = [[GameResultPromptView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.6)];
    [self.gameResultPromptView refreshWithGid:gameid winKey:winKey];
    [[ABUIPopUp shared] show:self.gameResultPromptView from:ABPopUpDirectionCenter duration:5 distance:0 hideBlock:^{
        
    } showBlock:^{
        
    }];
}

- (void)gamesPromptView:(GamesPromptView *)gamesPromptView didSelectIndex:(NSInteger)index item:(NSDictionary *)item {
    [[ABUIPopUp shared] remove:0];
    [self promptDesksWithGameId:[item[@"id"] intValue]];
}

- (void)promptDesksWithGameId:(NSInteger)gameid {
    self.gameid = gameid;
    self.desksPromptView = [[DesksPromptView alloc] initWithFrame:CGRectMake(0, 0, 331, 262)];
    self.desksPromptView.delegate = self;
    [self.desksPromptView refreshWithGameID:gameid];
    [[ABUIPopUp shared] show:self.desksPromptView from:ABPopUpDirectionCenter];
}

- (void)desksPromptView:(DesksPromptView *)desksPromptView didSelectIndex:(NSInteger)index item:(NSDictionary *)item {
    [[ABUIPopUp shared] remove];
    self.gameBlock([item[@"GameId"] intValue], [item[@"DeskId"] intValue], item[@"GameName"]);
}

#pragma mark ---------
- (void)promptMoreActions:(IndexBlock)block {
    self.moreActionIndexBlock = block;
    self.moreActionView = [[ABUIListView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    NSArray *dataList = @[
        @{
            @"title":@"下注",
            @"icon":@"youxi",
            @"native_id":@"titleimage"
        },
        @{
            @"title":@"额度转换",
            @"icon":@"jinbi",
            @"native_id":@"titleimage"
        }
    ];
    
    NSDictionary *css = @{@"item.size.width":@"25%", @"item.size.height":@"25%"};
    self.moreActionView.backgroundColor = [[UIColor hexColor:@"#232828"] colorWithAlphaComponent:0.88];
    [self.moreActionView setDataList:dataList css:css];
    self.moreActionView.delegate = self;
    [[ABUIPopUp shared] show:_moreActionView from:ABPopUpDirectionBottom];
}

- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item {
    if (listView == self.moreActionView) {
        self.moreActionIndexBlock(indexPath.row);
    }
}

#pragma mark ----------- betview --------------
- (void)promptBetView:(NSDictionary *)rules hideBlock:(nonnull ABUIPopupBlock)hideBlock showBlock:(nonnull ABUIPopupBlock)showBlock {
    [[ABUIPopUp shared] remove:0];
    if (RC.gameManager.game_id != self.betView.game_id) {
        self.betView.game_id = RC.gameManager.game_id;
        [self.betView setCoins:rules[@"coins"] options:rules[@"options"] sounds:rules[@"sounds"] limit:rules[@"tip"]];
    }
    
    RC.gameManager.betView = self.betView;
    [[ABUIPopUp shared] show:self.betView from:ABPopUpDirectionBottom distance:[ABDevice safeHeight]+44 hideBlock:hideBlock showBlock:showBlock];
}

- (void)betView:(BetView *)betView onConfirmWithData:(NSDictionary *)data {
    [RC.gameManager doBet:data];
}

- (void)betViewOnCancel:(BetView *)betView {
    [RC.gameManager doBetCancel];
}

- (void)promptGameBetResult:(NSDictionary *)data {
    [[ABUIPopUp shared] remove:0];
    GameBetResultView *gbrv = [[GameBetResultView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-30, 300)];
//    [gbrv setData:@{
//        @"Balance":@1308,
//        @"Boot_num": @1,
//        @"Cmd": @7,
//        @"DeskId": @1,
//        @"Desk_name":@"CS2",
//        @"GameType":@2,
//        @"Pave_num": @50,
//        @"Result" :@1,
//        @"Sumgetmoney":@400,
//        @"Todaymoney":@1100,
//    }];
    [gbrv setData:data];
    [[ABUIPopUp shared] show:gbrv from:ABPopUpDirectionCenter duration:5];
}

@end
