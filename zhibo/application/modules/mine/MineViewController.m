//
//  MeViewController.m
//  zhibo
//
//  Created by qp on 2020/7/24.
//  Copyright © 2020 qp. All rights reserved.
//

#import "MineViewController.h"
#import "MineTopView.h"
#import "MinePresent.h"
#import "MineNavView.h"
@interface MineViewController ()<MinePresentDelegate, ABUIListViewDelegate, INetData>
@property (nonatomic, strong) ABUIListView *listView;
@property (nonatomic, strong) MineTopView *topView;
@property (nonatomic, strong) MinePresent *present;
@property (nonatomic, strong) MineNavView *navView;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isVisableNavigationBar = false;
    
    self.topView = [[MineTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 284+STATUS_AND_NAV_BAR_HEIGHT)];
    
    self.listView = [[ABUIListView alloc] initWithFrame:self.view.bounds];
    self.listView.collectionView.showsVerticalScrollIndicator = false;
    self.listView.headerView = self.topView;
    self.listView.delegate = self;
    [self.listView adapterSafeArea];
    [self.view addSubview:self.listView];
    
    UILabel *versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 30)];
    [versionLabel setText:[NSString stringWithFormat:@"V%@", [ABDevice applicationVersion]]];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    [versionLabel setTextColor:[UIColor hexColor:@"999999"]];
    versionLabel.font = [UIFont PingFangSC:14];
    self.listView.footerView = versionLabel;
    
    NSArray *dataList = [Config getMe];
    [self.listView setTempleteDataList:dataList];
    
    self.navView = [[MineNavView alloc] initWithFrame:CGRectMake(0, SYS_STATUSBAR_HEIGHT, SCREEN_WIDTH, 44)];
    [self.navView.settingButton addTarget:self action:@selector(onSettingAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];

    self.present = [[MinePresent alloc] init];
    self.present.delegate = self;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.listView.frame = self.view.bounds;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.present refreshTopInfo];
}

#pragma mark ------ local action-----
- (void)onSettingAction {
    [NSRouter gotoSettingPage:@"home"];
}

#pragma mark - MinePresent delegate and dataSource

- (void)minePresent:(MinePresent *)minePresent onReceiveTopInfo:(NSDictionary *)info {
    [self.topView loadData:info];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item {
    NSString *icon = item[@"icon"];
    if ([icon isEqualToString:@"kanguo"]) {
        [NSRouter gotoFootPrint];
    }
    if ([icon isEqualToString:@"zhibozhenghu"]) {
        [NSRouter gotoWallet];
    }
    if ([icon isEqualToString:@"youxijilu-"]) {
        [NSRouter gotoGameHistroy];
    }
    if ([icon isEqualToString:@"youxiguiz"]) {
        [NSRouter gotoGameRules];
    }
    if ([icon isEqualToString:@"songchuliwu"]) {
        [NSRouter gotoGiftHistroy:2];
    }
    if ([icon isEqualToString:@"shoudao"]) {
        [NSRouter gotoGiftHistroy:1];
    }
    if ([icon isEqualToString:@"congzhijilu"]) {
        [NSRouter gotoChargerHistory:1];
    }
    if ([icon isEqualToString:@"tixianjil-"]) {
        [NSRouter gotoChargerHistory:2];
    }
    if ([icon isEqualToString:@"liushuijilu"]) {
        [NSRouter gotoChargerHistory:3];
    }
    if ([icon isEqualToString:@"tuanduibaobiao"]) {
        [NSRouter gotoTeamForm];
    }
    if ([icon isEqualToString:@"bangzhu"]) {
//        [NSRouter gotoHelp];
        [self fetchPostUri:URI_ACCOUNT_HELP params:nil];
    }
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    if ([obj[@"address"] hasPrefix:@"http"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:obj[@"address"]]];
    }else{
        [ABUITips showError:@"功能未上线"];
    }
    
}
@end
