//
//  ReChargeViewController.m
//  zhibo
//
//  Created by FaiWong on 2020/4/25.
//  Copyright © 2020 qp. All rights reserved.
//

#import "ReChargeViewController.h"
#import "JnPasswordView.h"
#import "CashOutInputView.h"
@interface ReChargeViewController ()<ABUIListViewDelegate, ABUIListViewDataSource, INetData>
@property (nonatomic, strong) ABUIListView *listView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, assign) NSInteger selectIndex;

@property (nonatomic, strong) CashOutInputView *inputView;
@property (nonatomic, strong) NSArray *dataList;
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
    [submitButton setBackgroundColor:[UIColor hexColor:@"FF2A40"]];
    submitButton.layer.cornerRadius = 20;
    submitButton.titleLabel.font = [UIFont PingFangSC:17];
    submitButton.clipsToBounds = true;
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(onSubmit) forControlEvents:UIControlEventTouchUpInside];
    submitButton.centerX = self.view.width/2;
    
    self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    
    _inputView = [[CashOutInputView alloc] initWithFrame:CGRectMake(0, 20, self.view.width, 120)];
    [self.footerView addSubview:_inputView];
    [self.inputView recharge];
    
    submitButton.top = self.inputView.bottom;
    self.footerView.height = submitButton.bottom;
    
    [self.footerView addSubview:submitButton];
    
    
    
    self.listView.footerView = self.footerView;
    
    self.selectIndex = -1;
    [self fetchPostUri:URI_ACCOUNT_RECHARGE_CHANNELS params:nil];
    
    
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    if ([req.uri isEqualToString:URI_ACCOUNT_RECHARGE_CHANNELS]) {
        NSArray *list = obj[@"list"];
        if (list.count > 0) {
            self.dataList = obj[@"list"][0][@"items"];
            self.selectIndex = 0;
        }
        [self.listView setTempleteDataList:obj[@"list"]];
        
        
    }else {
        [ABUITips showSucceed:@"跳转充值..."];
        NSString *url = obj[@"url"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
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
    return @{@"selected":@(indexPath.row==self.selectIndex)};;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.listView.frame = self.view.bounds;
}

- (void)onSubmit {
    if (self.selectIndex < 0 || self.selectIndex >= self.dataList.count) {
        [ABUITips showError:@"请选择充值通道"];
        return;
    }
    
    if (self.inputView.textField.text.length == 0) {
        [ABUITips showError:@"请输入充值金额"];
        return;
    }
    [self.view endEditing:true];
    
    NSInteger czid = [self.dataList[self.selectIndex][@"id"] intValue];
    [self fetchPostUri:URI_ACCOUNT_BALANCE_RECHARGE params:@{@"czid":@(czid), @"money":self.inputView.textField.text}];
//    [[JnPasswordView sharedInstance] showPasswordViewWithInputPwd:^(NSString *pwd) { NSLog(@"密码 = %@",pwd);
//    } cancel:^{
//        NSLog(@"点击了取消");
//    } certain:^{
//        NSLog(@"点击了确定");
//        [ABUITips showError:@"开发中"];
//    }];
}

@end
