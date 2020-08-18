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
#import "JnPasswordView.h"
@interface CashOutViewController ()<INetData, ABUIListViewDelegate, ABUIListViewDataSource>
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) BalanceView *balanceView;
@property (nonatomic, strong) ABUIListView *listView;
@property (nonatomic, strong) CashOutInputView *inputView;


@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, strong) NSString *password;
@end

@implementation CashOutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 262+26+40)];
//    [self.view addSubview:self.topView];
    _balanceView = [[BalanceView alloc] initWithFrame:CGRectMake(15, 13, self.view.width-30, 124)];
    [self.topView addSubview:_balanceView];
        
    _inputView = [[CashOutInputView alloc] initWithFrame:CGRectMake(0, _balanceView.bottom+28, self.view.width, 120)];
    [self.topView addSubview:_inputView];
    self.topView.height = self.inputView.bottom+40;
    

    self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 200, 40)];
    [submitButton setTitle:@"提现" forState:UIControlStateNormal];
    [submitButton setBackgroundColor:[UIColor hexColor:@"FF2A40"]];
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
    [self fetchPostUri:URI_ACCOUNT_DRAWPER params:nil];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.listView.frame = self.view.bounds;
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    if ([req.uri isEqualToString:URI_ACCOUNT_BALANCE_CASHOUT]) {
        [self.listView setTempleteDataList:@[obj]];
    }
    if ([req.uri isEqualToString:URI_ACCOUNT_BALANCE_INFO]){
        [self.balanceView reload:obj];
        self.inputView.num = [obj[@"info"] intValue];
    }
    if ([req.uri isEqualToString:URI_ACCOUNT_DRAWPER]) {
        NSString *text = [NSString stringWithFormat:@"提现限额:%@-%@\n手续费:%@%%\n直播币与提现比例:1:%@", obj[@"min"], obj[@"max"], obj[@"fee"], obj[@"per"]];
        [self.inputView setNoticeText:text];
    }
    if ([req.uri isEqualToString:URI_ACCOUNT_CASHOUT]) {
        [[JnPasswordView sharedInstance] dismissPasswordView];
        [ABUITips showSucceed:@"申请成功"];
    }
    
}

- (void)onNetRequestFailure:(ABNetRequest *)req err:(ABNetError *)err {
    [ABUITips showError:err.message];
}

- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item {
    self.selectIndex = indexPath.row;
    [self.listView reloadData];
}

- (NSDictionary *)listView:(ABUIListView *)listView extraDataAtIndexPath:(NSIndexPath *)indexPath {
    return @{@"selected":@(indexPath.row==self.selectIndex)};
}

- (void)onSubmit {
    if (self.inputView.textField.text.length == 0) {
        [ABUITips showError:@"请输入提现金额"];
        return;
    }
//    __weak __typeof(&*self) weakSelf = self;
    [[JnPasswordView sharedInstance] showPasswordViewWithInputPwd:^(NSString *pwd) { self.password = pwd;
    } cancel:^{
        NSLog(@"点击了取消");
    } certain:^{
        [[JnPasswordView sharedInstance] dismissPasswordView];
        [self fetchPostUri:URI_ACCOUNT_CASHOUT params:@{@"draw_money":self.inputView.textField.text, @"draw_pwd":self.password}];
    }];
}

@end
