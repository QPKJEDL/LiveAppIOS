//
//  HomeViewController.m
//  zhibo
//
//  Created by FaiWong on 2020/4/22.
//  Copyright © 2020 qp. All rights reserved.
//

#import "HomeViewController.h"
#import <JXCategoryView/JXCategoryView.h>
#import "AnchorListViewController.h"
#import "HomeNavView.h"
@interface HomeViewController ()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate, INetData>
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *titleList;

@property (nonatomic, strong) HomeNavView *navView;
@property (nonatomic, strong) UIButton *messageButton;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor hexColor:@"F7F9FD"];
    CGFloat categoryViewHeight = 50.0;
    self.navView = [[HomeNavView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, STATUS_AND_NAV_BAR_HEIGHT)];
    self.navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.navView];
    
    self.isVisableNavigationBar = false;

    
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, self.navView.bottom, SCREEN_WIDTH, categoryViewHeight)];
    self.categoryView.backgroundColor = UIColor.whiteColor;
    self.categoryView.delegate = self;
    self.categoryView.titleLabelZoomScale = 1.2;
    self.categoryView.titleLabelZoomEnabled = true;
    self.categoryView.titleColor = [UIColor hexColor:@"#262626"];
    self.categoryView.titleSelectedColor = [UIColor hexColor:@"#262626"];
    self.categoryView.titleSelectedFont = [UIFont PingFangSCBlod:18];
    self.categoryView.titleFont = [UIFont PingFangSC:18];
    self.categoryView.contentEdgeInsetLeft = 19;
    self.categoryView.contentEdgeInsetRight = 19;
    self.categoryView.cellSpacing = 30;
    [self.view addSubview:self.categoryView];
    [self.categoryView setHidden:true];


    self.categoryView.titleColorGradientEnabled = YES;

    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.lineStyle = JXCategoryIndicatorLineStyle_Lengthen;
    lineView.indicatorColor = [UIColor whiteColor];
    lineView.indicatorWidth = 20;
    self.categoryView.indicators = @[lineView];


    self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_CollectionView delegate:self];
    [self.view addSubview:self.listContainerView];
    self.listContainerView.scrollView.backgroundColor = self.view.backgroundColor;
    self.listContainerView.backgroundColor = self.view.backgroundColor;
    //关联到categoryView
    self.categoryView.listContainer = self.listContainerView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.titles.count == 0) {
        [self reloadData];
    }
}

- (void)reloadData {
    [ABUITips showLoading];
    [self hideEmptyView];
    [self fetchPostUri:URI_CHANNEL_LIST params:nil];
}

- (void)setUpNavView {
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.listContainerView.frame = CGRectMake(0, self.categoryView.bottom, SCREEN_WIDTH, self.view.height-self.categoryView.bottom);
}
//点击选中或者滚动选中都会调用该方法。适用于只关心选中事件，不关心具体是点击还是滚动选中的。
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    
}

//点击选中的情况才会调用该方法
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    
}

//滚动选中的情况才会调用该方法
- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index {
    
}

//正在滚动中的回调
- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
    
}


//返回列表的数量
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}
//根据下标index返回对应遵从`JXCategoryListContentViewDelegate`协议的列表实例
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    AnchorListViewController *vc = [[AnchorListViewController alloc] init];
    vc.parent = self;
    vc.props = self.titleList[index];
    return vc;
}


- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    [ABUITips hideLoading];
    [self hideEmptyView];
    [self.categoryView setHidden:false];
    NSArray *list = obj[@"list"];
    self.titleList = list;
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    for (NSDictionary *item in list) {
        [titles addObject:item[@"channel"]];
    }
    self.titles = titles;
//    self.titles = @[@"女神", @"热门", @"音乐", @"舞蹈", @"交友", @"新人", @"同城", @"游戏"];
    self.categoryView.titles = self.titles;
    [self.categoryView reloadData];
    
    [[Service shared] refreshGameURL];
}

- (void)onNetRequestFailure:(ABNetRequest *)req err:(ABNetError *)err {
    [ABUITips hideLoading];
    [self showEmptyViewWithImage:[UIImage imageNamed:@"wuwang"] text:@"网络无法连接" detailText:nil buttonTitle:@"点击刷新" buttonAction:@selector(reloadData)];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
