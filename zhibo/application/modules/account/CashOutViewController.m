//
//  CashOutViewController.m
//  zhibo
//
//  Created by FaiWong on 2020/4/25.
//  Copyright © 2020 qp. All rights reserved.
//

#import "CashOutViewController.h"
#import "BalanceView.h"
#import "CashOutInputView.h"
@interface CashOutViewController ()<INetData, ABUIListViewDelegate, ABUIListViewDataSource>
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) BalanceView *balanceView;
@property (nonatomic, strong) ABUIListView *listView;
@property (nonatomic, strong) CashOutInputView *inputView;


@property (nonatomic, assign) NSInteger selectIndex;
@end

@implementation CashOutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 262+26)];
//    [self.view addSubview:self.topView];
    _balanceView = [[BalanceView alloc] initWithFrame:CGRectMake(15, 13, self.view.width-30, 124)];
    [self.topView addSubview:_balanceView];
        
    _inputView = [[CashOutInputView alloc] initWithFrame:CGRectMake(0, _balanceView.bottom+28, self.view.width, 120)];
    [self.topView addSubview:_inputView];
    self.topView.height = self.inputView.bottom;
    

    self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 200, 40)];
    [submitButton setTitle:@"提现" forState:UIControlStateNormal];
    [submitButton setBackgroundColor:[UIColor hexColor:@"00BFCB"]];
    submitButton.layer.cornerRadius = 20;
    submitButton.titleLabel.font = [UIFont PingFangSC:17];
    submitButton.clipsToBounds = true;
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitButton.centerX = self.view.width/2;
    [submitButton addTarget:self action:@selector(onSubmit) forControlEvents:UIControlEventTouchUpInside];
    [self.footerView addSubview:submitButton];

    self.listView = [[ABUIListView alloc] initWithFrame:self.view.bounds];
    self.listView.headerView = self.topView;
    self.listView.footerView = self.footerView;
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.collectionView.bounces = false;
    [self.view addSubview:self.listView];
    
    self.selectIndex = 0;
    
    [self fetchPostUri:URI_ACCOUNT_BALANCE_INFO params:nil];
    [self fetchPostUri:URI_ACCOUNT_BALANCE_CASHOUT params:nil];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.listView.frame = self.view.bounds;
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    if ([req.uri isEqualToString:URI_ACCOUNT_BALANCE_CASHOUT]) {
        [self.listView setTempleteDataList:@[obj]];
    }else{
        [self.balanceView reload:obj];
        self.inputView.num = [obj[@"info"] intValue];
    }
    
}

- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item {
    self.selectIndex = indexPath.row;
    [self.listView reloadData];
}

- (NSDictionary *)listView:(ABUIListView *)listView extraDataAtIndexPath:(NSIndexPath *)indexPath {
    return @{@"selected":@(indexPath.row==self.selectIndex)};
}

- (void)onSubmit {
    [ABUITips showError:@"开发中"];
}

@end
