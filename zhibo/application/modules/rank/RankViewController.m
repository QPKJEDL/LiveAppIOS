//
//  RankViewController.m
//  zhibo
//
//  Created by qp on 2020/7/27.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RankViewController.h"
#import "RankListViewController.h"
@interface RankViewController ()<JXCategoryListContainerViewDelegate>
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@end

@implementation RankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    self.categoryView.backgroundColor = [UIColor hexColor:@"FF2828"];
//    [self.categoryView gradient:GRADIENTCOLORS direction:0];
//    self.categoryView.delegate = self;
    self.categoryView.titleLabelZoomEnabled = false;
    self.categoryView.titleColor = [UIColor hexColor:@"#FEC6D3"];
    self.categoryView.titleSelectedColor = [UIColor hexColor:@"#FFFFFF"];
    self.categoryView.titleSelectedFont = [UIFont PingFangSCBlod:16];
    self.categoryView.titleFont = [UIFont PingFangSCBlod:16];
    self.categoryView.contentEdgeInsetLeft = 38;
    self.categoryView.contentEdgeInsetRight = 38;
    self.categoryView.cellSpacing = 0;
    self.categoryView.contentScrollViewClickTransitionAnimationEnabled = false;
    [self.view addSubview:self.categoryView];
    [self.categoryView setTitles:@[@"女神榜", @"宠爱榜", @"赌神榜"]];
    self.categoryView.centerX = self.view.width/2;

    self.categoryView.titleColorGradientEnabled = YES;

    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorColor = [UIColor whiteColor];
    self.categoryView.indicators = @[lineView];

    self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_CollectionView delegate:self];
    [self.view addSubview:self.listContainerView];
//    self.listContainerView.scrollView.scrollEnabled = false;
    self.listContainerView.scrollView.backgroundColor = self.view.backgroundColor;
    self.listContainerView.backgroundColor = self.view.backgroundColor;
    //关联到categoryView
    self.categoryView.listContainer = self.listContainerView;
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.listContainerView.frame = CGRectMake(0, self.categoryView.height, self.view.width, self.view.height-self.categoryView.height);
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

//返回列表的数量
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return 3;
}
//根据下标index返回对应遵从`JXCategoryListContentViewDelegate`协议的列表实例
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    RankListViewController *vc = [[RankListViewController alloc] init];
    vc.parent = self;
    vc.props = @{@"index":@(index)};
    return vc;
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
