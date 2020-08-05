//
//  TeamFormViewController.m
//  zhibo
//
//  Created by qp on 2020/7/31.
//  Copyright © 2020 qp. All rights reserved.
//

#import "TeamFormViewController.h"

#import <JXCategoryView/JXCategoryView.h>
#import "AnchorListViewController.h"
#import "HomeNavView.h"
#import "HomeHotViewController.h"
#import "TeamFormStatisticsViewController.h"
#import "TeamFormLowerViewController.h"
@interface TeamFormViewController ()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate, INetData>
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *titleList;

@property (nonatomic, strong) UIButton *messageButton;

@end

@implementation TeamFormViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"团队报表";
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    self.categoryView.backgroundColor = [UIColor hexColor:@"#FF2828"];
    self.categoryView.delegate = self;
    self.categoryView.titleLabelZoomEnabled = false;
    self.categoryView.titleColor = [UIColor hexColor:@"#FFC6D3"];
    self.categoryView.titleSelectedColor = [UIColor hexColor:@"#F7F8FA"];
    self.categoryView.titleSelectedFont = [UIFont PingFangSCBlod:16];
    self.categoryView.titleFont = [UIFont PingFangSCBlod:16];
    self.categoryView.contentEdgeInsetLeft = 60;
    self.categoryView.contentEdgeInsetRight = 60;
//    self.categoryView.cellSpacing = 30;
    self.categoryView.contentScrollViewClickTransitionAnimationEnabled = false;
    [self.view addSubview:self.categoryView];
    [self.categoryView setTitles:@[@"团队统计", @"下级报表"]];
    self.categoryView.centerX = self.view.width/2;

    self.categoryView.titleColorGradientEnabled = YES;

    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorColor = [UIColor whiteColor];
//    lineView.indicatorWidth = 30;
    self.categoryView.indicators = @[lineView];

    self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_CollectionView delegate:self];
    [self.view addSubview:self.listContainerView];
    self.listContainerView.scrollView.scrollEnabled = false;
    self.listContainerView.scrollView.backgroundColor = self.view.backgroundColor;
    self.listContainerView.backgroundColor = self.view.backgroundColor;
    //关联到categoryView
    self.categoryView.listContainer = self.listContainerView;
}


- (void)setUpNavView {
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.listContainerView.frame = CGRectMake(0, 44, SCREEN_WIDTH, self.view.height-44);
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
    return 2;
}
//根据下标index返回对应遵从`JXCategoryListContentViewDelegate`协议的列表实例
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    if (index == 0) {
        TeamFormStatisticsViewController *vc = [[TeamFormStatisticsViewController alloc] init];
        vc.parent = self;
        return vc;
    }
    TeamFormLowerViewController *vc = [[TeamFormLowerViewController alloc] init];
    vc.parent = self;
    vc.props = @{@"id":@(-1)};
    return vc;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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
