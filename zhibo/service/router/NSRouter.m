//
//  NSRouter.m
//  zhibo
//
//  Created by FaiWong on 2020/4/23.
//  Copyright © 2020 qp. All rights reserved.
// 跳转

#import "NSRouter.h"

#import "RoomPlayViewController.h"
#import "ZhiBoViewController.h"
#import "PublishDTViewController.h"
#import "MessageViewController.h"
#import "SearchViewController.h"
#import "WalletViewController.h"
#import "CashOutViewController.h"
#import "ReChargeViewController.h"
#import "ChatViewController.h"
#import "SettingViewController.h"
#import "FootPrintViewController.h"
#import "BillViewController.h"
#import "LoginViewController.h"
#import "UserListViewController.h"
#import "RoomPushViewController.h"
#import "GiftHistoryViewController.h"
#import "SettingViewController.h"
#import "GameHistoryViewController.h"
#import "GameRulesViewController.h"
#import "WebViewViewController.h"
#import "ProfileViewController.h"
#import "ReChargeHistoryViewController.h"
#import "TeamFormViewController.h"
#import "PopularizeViewController.h"
#import "TransformViewController.h"
#import "PopularizeListViewController.h"
@implementation NSRouter
+ (void)doLogin {
    LoginViewController *vc = [[LoginViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    [nav setNavigationBarHidden:true];
    [[[UIApplication sharedApplication] topViewController] presentViewController:nav animated:true completion:nil];
}

+ (void)dismiss {
    [[[UIApplication sharedApplication] topViewController] dismissViewControllerAnimated:true completion:nil];
}

+ (void)back {
    [[[UIApplication sharedApplication] topViewController].navigationController popViewControllerAnimated:true];
}

+ (void)pushTo:(UIViewController *)to props:(NSDictionary *)props {
    UIViewController *from = [[UIApplication sharedApplication] topViewController];
    if (from.navigationController != nil) {
        [from.navigationController pushViewController:to animated:true];
    }
    else if (from.parent.navigationController != nil) {
        [from.parent.navigationController pushViewController:to animated:true];
    }
}

+ (void)gotoRoomPlayPage:(NSInteger)roomId {
    RoomPlayViewController *vc = [[RoomPlayViewController alloc] init];
    vc.roomid = roomId;
    [NSRouter pushTo:vc props:@{}];
}

+ (void)gotoZhiBoPage {
    ZhiBoViewController *vc = [[ZhiBoViewController alloc] init];
    [NSRouter pushTo:vc props:@{}];
}

+ (void)gotoPublishDT {
    PublishDTViewController *vc = [[PublishDTViewController alloc] init];
    vc.title = @"发布动态";
    [NSRouter pushTo:vc props:@{}];
}

+ (void)gotoMessagePage:(NSInteger)tag {
    MessageViewController *vc = [[MessageViewController alloc] init];
    NSArray *ttt = @[@"消息", @"系统公告", @"官方消息"];
    vc.title = ttt[tag];
    vc.props = @{@"type":@(tag)};
    [NSRouter pushTo:vc props:@{}];
}

+ (void)gotoSearch {
    SearchViewController *vc = [[SearchViewController alloc] init];
    vc.title = @"搜索";
    [NSRouter pushTo:vc props:@{}];
}

+ (void)gotoProfile:(NSInteger)uid {
    ProfileViewController *vc = [[ProfileViewController alloc] init];
    vc.props = @{@"uid":@(uid)};
    [NSRouter pushTo:vc props:@{}];
}

+ (void)gotoWallet {
    WalletViewController *vc = [[WalletViewController alloc] init];
    vc.title = @"直播账户";
    [NSRouter pushTo:vc props:@{}];
}

+ (void)gotoCashOut {
    CashOutViewController *vc = [[CashOutViewController alloc] init];
    vc.title = @"提现";
    [NSRouter pushTo:vc props:@{}];
}

+ (void)gotoReCharge {
    ReChargeViewController *vc = [[ReChargeViewController alloc] init];
    vc.title = @"充值";
    [NSRouter pushTo:vc props:@{}];
}

+ (void)gotoChatPage {
    ChatViewController *vc = [[ChatViewController alloc] init];
    vc.title = @"莉莉";
    [NSRouter pushTo:vc props:@{}];
}

+ (void)gotoSettingPage:(NSString *)key {
    SettingViewController *vc = [[SettingViewController alloc] init];
    vc.title = @"设置";
    vc.key = key;
    [NSRouter pushTo:vc props:@{}];
}

+ (void)gotoFootPrint {
    FootPrintViewController *vc = [[FootPrintViewController alloc] init];
    vc.title = @"我看过的";
    [NSRouter pushTo:vc props:@{}];
}

+ (void)gotoBill {
    BillViewController *vc = [[BillViewController alloc] init];
    vc.title = @"直播账单";
    [NSRouter pushTo:vc props:@{}];
}

+ (void)gotoUserList:(NSString *)title {
    UserListViewController *vc = [[UserListViewController alloc] init];
    vc.title = title;
    [NSRouter pushTo:vc props:@{}];
}

+ (void)gotoKaibo {
    RoomPushViewController *vc = [[RoomPushViewController alloc] init];
    [[[UIApplication sharedApplication] topViewController] presentViewController:vc animated:true completion:nil];
}


+ (void)gotoGiftHistroy:(NSInteger)type {
    GiftHistoryViewController *vc = [[GiftHistoryViewController alloc] init];
    vc.type = type;
    if (type == 1) {
        vc.title = @"收到的礼物";
    }else{
        vc.title = @"送出的礼物";
    }
    [NSRouter pushTo:vc props:@{}];
}

+ (void)showImages {
    
}

+ (void)gotoGameHistroy {
    GameHistoryViewController *vc = [[GameHistoryViewController alloc] init];
    [NSRouter pushTo:vc props:@{}];
}

+ (void)gotoGameRules {
    GameRulesViewController *vc = [[GameRulesViewController alloc] init];
    [NSRouter pushTo:vc props:@{}];
}

+ (void)gotoWeb:(NSString *)path title:(nonnull NSString *)title {
    WebViewViewController *vc = [[WebViewViewController alloc] init];
    vc.path = path;
    vc.title = title;
    [NSRouter pushTo:vc props:@{}];
}

+ (void)gotoChargerHistory:(NSInteger)type {
    ReChargeHistoryViewController *vc = [[ReChargeHistoryViewController alloc] init];
    vc.type = type;
    if (type == 1) {
        vc.title = @"充值记录";
    }else{
        vc.title = @"提现记录";
    }
    [NSRouter pushTo:vc props:@{}];
}

+ (void)gotoTeamForm {
    TeamFormViewController *vc = [[TeamFormViewController alloc] init];
    [NSRouter pushTo:vc props:@{}];
}

+ (void)gotoPopularize {
    PopularizeViewController *vc = [[PopularizeViewController alloc] init];
    vc.title = @"推广";
    [NSRouter pushTo:vc props:@{}];
}

+ (void)gotoTransform {
    TransformViewController *vc = [[TransformViewController alloc] init];
    vc.title = @"筹码兑换";
    [NSRouter pushTo:vc props:@{}];
}

+ (void)gotoPopularizeList {
    PopularizeListViewController *vc = [[PopularizeListViewController alloc] init];
    vc.title = @"推广码";
    [NSRouter pushTo:vc props:@{}];
}
@end
