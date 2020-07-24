//
//  ReChargeViewController.m
//  zhibo
//
//  Created by FaiWong on 2020/4/25.
//  Copyright © 2020 qp. All rights reserved.
//

#import "ReChargeViewController.h"

@interface ReChargeViewController ()<ABUIListViewDelegate, ABUIListViewDataSource, INetData>
@property (nonatomic, strong) ABUIListView *listView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, assign) NSInteger selectIndex2;
@end

@implementation ReChargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.listView = [[ABUIListView alloc] initWithFrame:self.view.bounds];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    [self.view addSubview:self.listView];
    
    
    UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 200, 40)];
    [submitButton setTitle:@"充值" forState:UIControlStateNormal];
    [submitButton setBackgroundColor:[UIColor hexColor:@"00BFCB"]];
    submitButton.layer.cornerRadius = 20;
    submitButton.titleLabel.font = [UIFont PingFangSC:17];
    submitButton.clipsToBounds = true;
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(onSubmit) forControlEvents:UIControlEventTouchUpInside];
    submitButton.centerX = self.view.width/2;
    
    self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    [self.footerView addSubview:submitButton];
    self.listView.footerView = self.footerView;
    
    self.selectIndex = 0;
    self.selectIndex2 = 0;
    [self fetchPostUri:URI_ACCOUNT_BALANCE_RECHARGE params:nil];
    
    
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    [self.listView setTempleteDataList:obj[@"list"]];
}

- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item {
    if (indexPath.section == 1) {
        self.selectIndex = indexPath.row;
    }else{
        self.selectIndex2 = indexPath.row;
    }
    [self.listView reloadData];
}

- (NSDictionary *)listView:(ABUIListView *)listView extraDataAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return @{@"selected":@(indexPath.row==self.selectIndex)};
    }
    
    return @{@"selected":@(indexPath.row==self.selectIndex2)};;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.listView.frame = self.view.bounds;
}

- (void)onSubmit {
    [ABUITips showError:@"开发中"];
}

@end
