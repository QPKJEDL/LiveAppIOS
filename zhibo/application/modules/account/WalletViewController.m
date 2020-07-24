//
//  WalletViewController.m
//  zhibo
//
//  Created by FaiWong on 2020/4/25.
//  Copyright © 2020 qp. All rights reserved.
//

#import "WalletViewController.h"
#import "WalletViewTopView.h"
@interface WalletViewController ()<ABUIListViewDelegate, ABUIListViewDataSource, INetData>
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) WalletViewTopView *walletView;
@property (nonatomic, strong) ABUIListView *listView;

@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation WalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"钱包";
    
    self.isVisableNavigationBar = false;

    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SYS_STATUSBAR_HEIGHT+288+25+44)];
    self.topView.backgroundColor = self.view.backgroundColor;
    
    self.walletView = [[WalletViewTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SYS_STATUSBAR_HEIGHT+288)];
    [self.walletView.cashoutButton addTarget:self action:@selector(cashOutAction) forControlEvents:UIControlEventTouchUpInside];
    [self.walletView.rechargeButton addTarget:self action:@selector(reChargeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.walletView corner:UIRectCornerBottomLeft radii:40];
    [self.topView addSubview:self.walletView];
    
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, self.topView.height-44, SCREEN_WIDTH, 44)];
    titleView.backgroundColor = [UIColor whiteColor];
    [self.topView addSubview:titleView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectInset(titleView.bounds, 15, 0)];
    self.titleLabel.font = [UIFont PingFangSCBlod:20];
    self.titleLabel.text = @"发现";
    [titleView addSubview:self.titleLabel];
    
    self.dataList = [ResourceUtil readDataWithFileName:@"wallet"][@"data"];
    
    _listView = [[ABUIListView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.topView.height+90)];
    _listView.backgroundColor = [UIColor whiteColor];
    _listView.collectionView.backgroundColor = [UIColor whiteColor];
    _listView.headerView = self.topView;
    _listView.delegate = self;
    _listView.dataSource = self;
    [self.view addSubview:_listView];
    
    NSArray *dataList = @[
        @{
            @"title":@"提现记录",
            @"icon":@"tixian",
            @"native_id":@"titleimage2"
        },
        @{
            @"title":@"充值记录",
            @"icon":@"congz",
            @"native_id":@"titleimage2"
        },
        @{
            @"title":@"收到的礼物",
            @"icon":@"shouliwu",
            @"native_id":@"titleimage2"
        },
        @{
            @"title":@"送出的礼物",
            @"icon":@"songliwu",
            @"native_id":@"titleimage2"
        }
    
    ];
    _listView.bounces = false;
    [_listView setDataList:dataList css:@{
        @"item.size.width":@"25%",
        @"item.size.height":@(50)
    }];
    
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, SYS_STATUSBAR_HEIGHT, 44, 44)];
    [self.backButton setImage:[UIImage imageNamed:@"white_back"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(onBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SYS_STATUSBAR_HEIGHT, 100, 44)];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont PingFangMedium:18];
    self.titleLabel.text = @"钱包";
    [self.view addSubview:self.titleLabel];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.centerX = self.view.width/2;
    
    [self fetchPostUri:URI_ACCOUNT_BALANCE_INFO params:nil];
}

- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item {
    if (indexPath.row == 2) {
        [NSRouter gotoGiftHistroy:1];
    }
    if (indexPath.row == 3) {
        [NSRouter gotoGiftHistroy:2];
    }
}

- (void)onBack {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
//    self.listView.frame = self.view.bounds;
}


//- (NSInteger)listView:(ListView *)listView numberOfItemsInSection:(NSInteger)section {
//    return self.dataList.count;
//}
//
//- (NSDictionary *)listView:(ListView *)listView itemAtIndexPath:(NSIndexPath *)indexPath {
//    return self.dataList[indexPath.row];
//}
//
//- (void)listView:(ListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSDictionary *item = self.dataList[indexPath.row];
//    NSString *key = item[@"key"];
//    if ([key isEqualToString:@"bill"]) {
//        [NSRouter gotoBill];
//    }
//}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)cashOutAction {
    [NSRouter gotoCashOut];
}

- (void)reChargeAction {
    [NSRouter gotoReCharge];
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    [self.walletView reload:obj];
}

@end
