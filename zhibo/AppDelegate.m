//
//  AppDelegate.m
//  zhibo
//
//  Created by FaiWong on 2020/4/22.
//  Copyright © 2020 qp. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
@import TXLiteAVSDK_Smart;
#import "NetProvidor.h"
#import "ABUIListViewMapping.h"
#import "GameDataProcess.h"
#import "AccountDataProcess.h"
#import "RoomDataProcess.h"
#import "FollowDataProcess.h"
#import "NetErrorPlugin.h"
#import <IMService.h>
#import "LoginViewController.h"
#import "UserDataProcess.h"
#import "MessageDataPrecess.h"
#import <WOCrashProtectorManager.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "MomentDataProcess.h"
#import "RankDataProcess.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [WOCrashProtectorManager makeAllEffective];
    [IQKeyboardManager sharedManager].enable = true;
    [IQKeyboardManager sharedManager].enableAutoToolbar = true;
    [self ready];
    
    [self setUpWindow];
    
    [TXLiveBase setLicenceURL:@"http://license.vod2.myqcloud.com/license/v1/91fdbc3ccf9f493cf80ec9410610d562/TXLiveSDK.licence" key:@"cfec6f3245fbc129bdadac94e65c8413"];
    
    return YES;
}

//init window and display
- (void)setUpWindow {
    if ([Service shared].account.isLogin) {
        CGRect winFrame = [[UIScreen mainScreen] bounds];
        self.window = [[UIWindow alloc] initWithFrame:winFrame];
        self.window.rootViewController = [[MainViewController alloc] init];
        [self.window makeKeyAndVisible];
    }else{
        CGRect winFrame = [[UIScreen mainScreen] bounds];
        self.window = [[UIWindow alloc] initWithFrame:winFrame];
        self.window.rootViewController = [[LoginViewController alloc] init];
        [self.window makeKeyAndVisible];
    }
    
}

- (void)ready {
    NetProvidor *p = [[NetProvidor alloc] init];
    
    [ABNetConfiguration shared].provider = p;
    [ABUIListViewMapping shared].mapping = [[NSMutableDictionary alloc] initWithDictionary:@{
        @"anchoritem":@"AnchorItemView",
        @"betoption":@"BetOptionView",
        @"livecomment":@"LiveCommentItemView",
        @"topic":@"TopicItemView",
        @"channel":@"ChannelItemView",
        @"giftitem":@"GiftItemView",
        @"titleimage":@"TitleImageItemView",
        @"titleimage2":@"TitleImage2ItemView",
        @"user":@"UserItemView",
        @"message":@"MessageItemView",
        @"notice":@"NoticeItemView",
        @"usersub":@"UserSubItemView",
        @"deskitem":@"DeskItemView",
        @"giftrankitem":@"GiftRankItemView",
        @"roomaudience":@"RoomAudienceItemView",
        @"roommesagewelcome":@"RoomMessageWelcomeItemView",
        @"manageritem":@"ManagerItemView",
        @"gameresultitem":@"GameResultItemView",
        @"userpromptaction":@"UserPromptActionItemView",
        @"gifthistory":@"GiftHistoryItemView",
        @"paychannel":@"PayChannelItemView",
        @"moneyitem":@"MoneyItemView",
        @"moneysectionheader":@"MoneySectionHeaderView",
        @"arrowitem":@"ArrowItemView",
        @"inputitem":@"InputItemView",
        @"switchitem":@"SwitchItemView",
        @"momentitem":@"MomentItemView",
        @"imageitem":@"ImageItemView",
        @"rankitem":@"RankItemView",
        @"gamehistoryitem":@"GameHistoryItemView",
        @"gameruleitem":@"GameRuleItemView",
        @"commentitem":@"CommentItemView",
        @"commentitemreply":@"CommentReplyItemView",
        @"chargeitem":@"ChargeHistoryItemView",
        @"loweritem":@"TeamLowerItemView",
        @"statisitem":@"TeamStatisItemView",
        @"popularizecodeitem":@"PopularizeCodeItemView"
    }];
    
    [ABNet shared].errorHandle = [[NetErrorPlugin alloc] init];
    [[ABNet shared] registerDataProcess:[[RoomDataProcess alloc] init] key:@"/room"];
    [[ABNet shared] registerDataProcess:[[GameDataProcess alloc] init] key:@"/game"];
    [[ABNet shared] registerDataProcess:[[AccountDataProcess alloc] init] key:@"/account"];
    [[ABNet shared] registerDataProcess:[[FollowDataProcess alloc] init] key:@"/follow"];
    [[ABNet shared] registerDataProcess:[[UserDataProcess alloc] init] key:@"/user"];
    [[ABNet shared] registerDataProcess:[[MessageDataPrecess alloc] init] key:@"/message"];
    [[ABNet shared] registerDataProcess:[[MomentDataProcess alloc] init] key:@"/moments"];
    [[ABNet shared] registerDataProcess:[[RankDataProcess alloc] init] key:@"/rank"];
    
    [[Service shared] refreshGameURL];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    [[Service shared] enterBackground];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[RoomContext shared].playControl refreshRank];
    [[RoomContext shared].pushControl refreshRank];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
//    [[IMService instance] enterBackground];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
//    [[IMService instance] enterForeground];
}
@end
