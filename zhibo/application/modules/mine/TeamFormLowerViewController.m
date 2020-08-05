//
//  TeamFormLowerViewController.m
//  zhibo
//
//  Created by qp on 2020/7/31.
//  Copyright © 2020 qp. All rights reserved.
//

#import "TeamFormLowerViewController.h"
#import "MoneySectionHeaderView.h"
@interface TeamFormLowerViewController ()<INetData, ABUIListViewDelegate, ABUIListViewDataSource>
@property (nonatomic, strong) UIView *searchWrapper;
@property (nonatomic, strong) ABUIListView *listtView;
@property (nonatomic, strong) QMUITextField *searchTextField;

@property (nonatomic, strong) QMUIButton *selectButton;
@property (nonatomic, strong) MoneySectionHeaderView *headerView;

@property (nonatomic, strong) NSMutableDictionary *infoDic;
@property (nonatomic, strong) NSArray *dataList;
@end

@implementation TeamFormLowerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.infoDic = [[NSMutableDictionary alloc] init];
//    self.searchWrapper = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 76)];
//    self.searchWrapper.backgroundColor = self.view.backgroundColor;
//    [self.view addSubview:self.searchWrapper];
//
//    self.searchTextField = [[QMUITextField alloc] initWithFrame:CGRectMake(16, 17, SCREEN_WIDTH-16-16-84-5, 44)];
//    self.searchTextField.backgroundColor = [UIColor hexColor:@"#E9ECF5"];
//    self.searchTextField.placeholder = @"请输入账户和昵称查询";
//    self.searchTextField.textInsets = UIEdgeInsetsMake(0, 38, 0, 15);
//    self.searchTextField.font = [UIFont PingFangSC:14];
//    self.searchTextField.layer.cornerRadius = 22;
//    self.searchTextField.clipsToBounds = true;
//    [self.searchWrapper addSubview:self.searchTextField];
//
//    UIImageView *searchIcon = [[UIImageView alloc] initWithFrame:CGRectMake(18, 0, 14, 14)];
//    searchIcon.image = [UIImage imageNamed:@"shousuo"];
//    [_searchTextField addSubview:searchIcon];
//    searchIcon.centerY = _searchTextField.height/2;
//
//    self.selectButton = [[QMUIButton alloc] initWithFrame:CGRectMake(0, 0, 84, 44)];
//    [self.selectButton setTitle:@"查询" forState:UIControlStateNormal];
//    [self.selectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    self.selectButton.backgroundColor = [UIColor hexColor:@"#FF2828"];
//    self.selectButton.layer.cornerRadius = 22;
//    self.selectButton.titleLabel.font = [UIFont PingFangMedium:14];
//    [self.searchWrapper addSubview:self.selectButton];
//    self.selectButton.left = self.searchTextField.right+10;
//    self.selectButton.centerY = self.searchWrapper.height/2;
//    [self.selectButton addTarget:self action:@selector(onSelectButton) forControlEvents:UIControlEventTouchUpInside];
    
    self.headerView = [[MoneySectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    [self.headerView setupAdjustContents];
    [self.headerView layoutAdjustContents];
    [self.view addSubview:self.headerView];
    
    self.listtView = [[ABUIListView alloc] initWithFrame:CGRectMake(0, self.headerView.height, SCREEN_WIDTH, self.view.height)];
    self.listtView.backgroundColor = self.view.backgroundColor;
    self.listtView.delegate = self;
    self.listtView.dataSource = self;
    [self.view addSubview:self.listtView];
    
    [self refreshData];
}

- (void)refreshData {
    [self fetchPostUri:URI_ACCOUNT_TEAM_LOWERS params:nil];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.listtView.frame = CGRectMake(0, self.headerView.height, SCREEN_WIDTH, self.view.height-self.headerView.height);
}

- (CGSize)listView:(ABUIListView *)listView sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *item = self.dataList[indexPath.row];
    if (self.infoDic[item[@"user_id"]]) {
        return CGSizeMake(SCREEN_WIDTH, 134);
    }
    return CGSizeMake(SCREEN_WIDTH, 68);
}

- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item {
    if (self.infoDic[item[@"user_id"]] != nil) {
        return;
    }
    [ABUITips showLoading];
    [self fetchPostUri:URI_ACCOUNT_WebUserBetsFee params:@{@"touid":item[@"user_id"]}];
}


- (NSDictionary *)listView:(ABUIListView *)listView extraDataAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *item = self.dataList[indexPath.row];
    if (self.infoDic[item[@"user_id"]]) {
        return @{@"info":self.infoDic[item[@"user_id"]]};
    }
    
    return nil;
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    [ABUITips hideLoading];
    if ([req.uri isEqualToString:URI_ACCOUNT_TEAM_LOWERS]) {
        [self.headerView reload:@{@"title":[NSString stringWithFormat:@"下级人数:%@", obj[@"count"]]}];
        self.dataList = obj[@"list"];
          [self.listtView setDataList:obj[@"list"] css:@{@"item.size.height":@"68", @"item.rowSpacing":@"1"}];
    }else{
        [self.infoDic setValue:obj forKey:obj[@"userid"]];
        [self.listtView reloadData];
    }
}

- (void)onNetRequestFailure:(ABNetRequest *)req err:(ABNetError *)err {
    [ABUITips hideLoading];
}

- (void)onSelectButton {
    [self fetchPostUri:URI_ACCOUNT_TEAM_LOWERS params:@{@"keywords":@"xx"}];
}

@end
