//
//  HomeHotViewController.m
//  zhibo
//
//  Created by qp on 2020/7/27.
//  Copyright © 2020 qp. All rights reserved.
//

#import "HomeHotViewController.h"
#import "ADBannerView.h"
#import "AnchorListViewController.h"
#import "HTAsyncSocket.h"
@interface AJXCategoryIndicatorBackgroundView: JXCategoryIndicatorBackgroundView<INetData>
@property (nonatomic, strong) UIImageView *indicatorImageView;

@end

@implementation AJXCategoryIndicatorBackgroundView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.indicatorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
        [self.indicatorImageView setImage:[UIImage imageNamed:@"yuan2"]];
        [self addSubview:self.indicatorImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.indicatorImageView.left = self.width-self.indicatorImageView.width;
    self.indicatorImageView.top = 5;
}

@end

@interface HomeHotViewController ()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate, INetData, ADBannerViewDelegate>
@property (nonatomic, strong) UIView *colorView;
@property (nonatomic, strong) ADBannerView *bannerView;
@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) UIImageView *indicatorImageView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

@property (nonatomic, strong) NSArray *titleList;
@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) NSArray *bannerImgs;
@end

@implementation HomeHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.colorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 42)];
    self.colorView.backgroundColor = [UIColor hexColor:@"#FF2828"];
    [self.view addSubview:self.colorView];
    
    self.whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, self.colorView.bottom, SCREEN_WIDTH, 125)];
    self.whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.whiteView];
    
    self.bannerView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 125)];
    self.bannerView.delegate = self;
    [self.view addSubview:self.bannerView];

    
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, self.whiteView.bottom-44, SCREEN_WIDTH, 44)];
    self.categoryView.backgroundColor = UIColor.whiteColor;
    self.categoryView.delegate = self;
    self.categoryView.titleLabelZoomScale = 1.2;
    self.categoryView.titleLabelZoomEnabled = true;
    self.categoryView.titleColor = [UIColor hexColor:@"#262626"];
    self.categoryView.titleSelectedColor = [UIColor hexColor:@"#262626"];
    self.categoryView.titleSelectedFont = [UIFont PingFangSCBlod:18];
    self.categoryView.titleFont = [UIFont PingFangSCBlod:14];
    self.categoryView.contentEdgeInsetLeft = 19;
    self.categoryView.contentEdgeInsetRight = 19;
    self.categoryView.cellSpacing = 0;
    [self.view addSubview:self.categoryView];
        
    AJXCategoryIndicatorBackgroundView *backgroundView = [[AJXCategoryIndicatorBackgroundView alloc] init];
    backgroundView.indicatorHeight = JXCategoryViewAutomaticDimension;
    backgroundView.indicatorCornerRadius = 0;
    backgroundView.indicatorColor = [UIColor clearColor];
    self.categoryView.indicators = @[backgroundView];
    [backgroundView addSubview:self.indicatorImageView];
    
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_CollectionView delegate:self];
    [self.view addSubview:self.listContainerView];
    self.listContainerView.scrollView.backgroundColor = self.view.backgroundColor;
    self.listContainerView.backgroundColor = self.view.backgroundColor;
    //关联到categoryView
    self.categoryView.listContainer = self.listContainerView;
    

  
//    [[HTAsyncSocket shareAsncSocket] connecteServerWith:@"" onPort:<#(uint16_t)#>]
//    HTAsyncSocket *socket = [HTAsyncSocket shareAsncSocket];
//[socket sendDataWithType:<#(int)#> withDic:<#(nonnull NSMutableDictionary *)#>]
//    [socket reciveData:^(NSString  *data, NSString *type) {
//    }];
}

- (void)adBannerView:(ADBannerView *)adBannerView didSelectIndex:(NSInteger)index {
    NSDictionary *banner = self.bannerImgs[index];
    NSInteger kind = [self.bannerImgs[index][@"kind"] intValue];
    if (kind == 0) {
        [NSRouter gotoRoomPlayPage:[self.bannerImgs[index][@"room_id"] intValue]];
    }
    if (kind == 1) {
        NSString *url = self.bannerImgs[index][@"ad_url"];
        if ([url hasPrefix:@"http"] == false) {
            url = [NSString stringWithFormat:@"http://%@", url];
        }
        [NSRouter gotoWeb:url title:banner[@"remark"]];
    }
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.listContainerView.frame = CGRectMake(0, self.whiteView.bottom, SCREEN_WIDTH, self.view.height-self.whiteView.bottom);
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    
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

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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
    [self fetchPostUri:URI_BANNER_LIST params:nil];
}




- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    if ([req.uri isEqualToString:URI_BANNER_LIST]) {
        self.bannerImgs = obj[@"list"];
        NSMutableArray *urls = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in self.bannerImgs) {
            [urls addObject:dic[@"img"]];
        }
        
        [self.bannerView setUrls:urls];
    }else{
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
    //    [self.categoryView setTitles:@[@"热门", @"龙虎", @"百家乐", @"三公", @"牛牛", @"A89"]];
        self.categoryView.titles = self.titles;
        [self.categoryView reloadData];

        [[Service shared] refreshGameURL];
    }

}

- (void)onNetRequestFailure:(ABNetRequest *)req err:(ABNetError *)err {
    [ABUITips hideLoading];
    [self showEmptyViewWithImage:[UIImage imageNamed:@"wuwang"] text:@"网络无法连接" detailText:nil buttonTitle:@"点击刷新" buttonAction:@selector(reloadData)];
}

@end
