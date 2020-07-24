//
//  BillViewController.m
//  zhibo
//
//  Created by qp on 2020/4/29.
//  Copyright © 2020 qp. All rights reserved.
//

#import "BillViewController.h"
@interface BillViewController ()<JXCategoryViewDelegate>
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) NSArray *titles;
@end

@implementation BillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    self.categoryView.backgroundColor = [UIColor hexColor:@"f3f3f2"];
    self.categoryView.delegate = self;
    self.categoryView.titleColor = [UIColor hexColor:@"8F8F8F"];
    self.categoryView.titleSelectedColor = [UIColor hexColor:@"141319"];
    self.categoryView.titleFont = [UIFont boldSystemFontOfSize:13];
    self.categoryView.cellWidth = 50;
    [self.view addSubview:self.categoryView];

    self.titles = @[@"充值记录", @"提现记录"];
    self.categoryView.titles = self.titles;
    self.categoryView.titleColorGradientEnabled = YES;
    
    
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.lineStyle = JXCategoryIndicatorLineStyle_Lengthen;
    lineView.indicatorColor = [UIColor hexColor:@"333333"];
    lineView.indicatorWidth = 100;
    self.categoryView.indicators = @[lineView];
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
