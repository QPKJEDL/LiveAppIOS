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
@interface RoomPrompt ()<TopicsPromptViewDelegate, ChannelsPromptViewDelegate>
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

@property (nonatomic, strong) TitleBlock topicsBlock;
@property (nonatomic, strong) TitleBlock channelsBlock;
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

#pragma mark --------------
- (void)promptAnchor {
    self.anchorPromptView = [[AnchorPromptView alloc] initWithFrame:CGRectMake(50, 0, SCREEN_WIDTH-100, 262)];
    self.anchorPromptView.layer.cornerRadius = 10;
    self.anchorPromptView.clipsToBounds = true;
}

#pragma mark --------------
- (void)promptUserWithUid:(NSInteger)uid {
    if (uid == 0) {
        return;
    }
    if (uid == [Service shared].account.uid) {
        self.userPromptView = [[UserPromptView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 168+72/2+TI_HEIGHT)];
        [self.userPromptView removeActionView];
    }else{
        self.userPromptView = [[UserPromptView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 218+72/2+TI_HEIGHT)];
    }
    
    [self.userPromptView refreshWith:uid roomid:RC.roomid];
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
    [self.giftrankPromptView refreshWithRoomID:RC.roomid];
    [[ABUIPopUp shared] show:self.giftrankPromptView from:ABPopUpDirectionBottom];
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
    [[ABUIPopUp shared] show:self.gameResultPromptView from:ABPopUpDirectionCenter];
}
@end
