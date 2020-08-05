//
//  TeamFormStatisticsViewController.m
//  zhibo
//
//  Created by qp on 2020/7/31.
//  Copyright © 2020 qp. All rights reserved.
//

#import "TeamFormStatisticsViewController.h"
#import "TeamLowerItemView.h"
#import "GFCalendar.h"
@interface TeamFormStatisticsViewController ()<INetData>
@property (nonatomic, strong) TeamTextItem *itemA; //团队
@property (nonatomic, strong) TeamTextItem *itemB; //投注金额
@property (nonatomic, strong) TeamTextItem *itemC; //返点金额
@property (nonatomic, strong) ABUIListView *listtView;

@property (nonatomic, strong) UIView *dateView;
@property (nonatomic, strong) QMUIButton *dateButton;
@property (nonatomic, strong) QMUIButton *selectButton;
@end

@implementation TeamFormStatisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat w = floor(self.view.width/3);
    self.itemA = [[TeamTextItem alloc] initWithFrame:CGRectMake(0, 0, w, 50)];
    self.itemA.bLabel.text = @"团队人数";
    [self.view addSubview:self.itemA];
    
    self.itemB = [[TeamTextItem alloc] initWithFrame:CGRectMake(w, 0, w, 50)];
    self.itemB.bLabel.text = @"投注金额";
    [self.view addSubview:self.itemB];
    
    self.itemC = [[TeamTextItem alloc] initWithFrame:CGRectMake(w*2, 0, w, 50)];
    self.itemC.bLabel.text = @"返点金额";
    [self.view addSubview:self.itemC];
    
    
    self.dateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    self.dateView.backgroundColor = [UIColor whiteColor];
//    [self.dateView addLineDirection:LineDirectionBottom color:[UIColor hexColor:@"F7F9FD"] width:2];
    
    self.dateButton = [[QMUIButton alloc] initWithFrame:CGRectMake(15, 0, 120, 44)];
    self.dateButton.titleLabel.font = [UIFont PingFangSC:14];
    [self.dateButton setTitleColor:[UIColor hexColor:@"#A8A8A8"] forState:UIControlStateNormal];
    [self.dateView addSubview:self.dateButton];
    [self.dateButton addTarget:self action:@selector(onDateButton) forControlEvents:UIControlEventTouchUpInside];
    self.dateButton.spacingBetweenImageAndTitle = 18;
    self.dateButton.imagePosition = QMUIButtonImagePositionRight;
    [self.dateButton setImage:[UIImage imageNamed:@"form_arrow_down"] forState:UIControlStateNormal];
    [self.dateButton setImage:[UIImage imageNamed:@"form_arrow_up"] forState:UIControlStateSelected];
    [self.dateButton setTitle:@"2020-07-28" forState:UIControlStateNormal];
    
    
    self.selectButton = [[QMUIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-15-44, 17, 44, 22)];
    self.selectButton.titleLabel.font = [UIFont PingFangSC:14];
    [self.selectButton setTitleColor:[UIColor hexColor:@"#A8A8A8"] forState:UIControlStateNormal];
    [self.dateView addSubview:self.selectButton];
    [self.selectButton setTitle:@"查询" forState:UIControlStateNormal];
    self.selectButton.layer.borderWidth = 1;
    self.selectButton.layer.cornerRadius = 4;
    self.selectButton.clipsToBounds = true;
    self.selectButton.layer.borderColor = [UIColor hexColor:@"#A8A8A8"].CGColor;
    self.selectButton.centerY = self.dateView.height/2;
    
    self.listtView = [[ABUIListView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, self.view.height-50)];
    self.listtView.backgroundColor = self.view.backgroundColor;
    self.listtView.headerView = self.dateView;
    [self.view addSubview:self.listtView];
    
    [self fetchPostUri:URI_ACCOUNT_TEAM_STATIS params:nil];
    [self fetchPostUri:URI_ACCOUNT_WebUserBetsFee params:@{@"touid":@([Service shared].account.uid)}];
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    if ([req.uri isEqualToString:URI_ACCOUNT_WebUserBetsFee]) {
        self.itemA.aLabel.text = [obj stringValueForKey:@"teamcount"];
        self.itemB.aLabel.text = [obj stringValueForKey:@"betsmoney"];
        self.itemC.aLabel.text = [obj stringValueForKey:@"getmoney"];
    }else {
        [self.listtView setDataList:obj[@"list"] css:@{@"item.rowSpacing":@"2", @"section.inset.top":@"2"}];
    }
}

- (void)onDateButton {
    GFCalendarView *calendarView = [[GFCalendarView alloc] initWithFrameOrigin:CGPointMake(15, 0) width:SCREEN_WIDTH-2*15];
    calendarView.backgroundColor = [UIColor whiteColor];
    calendarView.didSelectDayHandler = ^(NSInteger year, NSInteger month, NSInteger day) {
        NSLog(@"=====%zd=====%zd=====%zd", year, month, day);
        NSString *newDateStr = [NSString stringWithFormat:@"%zd-%zd-%zd", year, month, day];
        [self.dateButton setTitle:newDateStr forState:UIControlStateNormal];
        [[ABUIPopUp shared] remove];
    };
    [[ABUIPopUp shared] show:calendarView from:ABPopUpDirectionCenter];
    
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
