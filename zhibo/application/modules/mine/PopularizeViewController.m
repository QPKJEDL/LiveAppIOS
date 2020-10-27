//
//  PopularizeViewController.m
//  zhibo
//
//  Created by qp on 2020/7/31.
//  Copyright © 2020 qp. All rights reserved.
//

#import "PopularizeViewController.h"
#import "ZBProgressView.h"
@interface PopularizeViewController ()<INetData>
@property (nonatomic, strong) UIScrollView *mainScollView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) ZBProgressView *progressView;

@property (nonatomic, strong) UILabel *wodeLabel;
@property (nonatomic, strong) UILabel *ruleTextLabel;
@property (nonatomic, strong) QMUITextView *textView;
@end

@implementation PopularizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mainScollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.mainScollView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 44)];
    self.titleLabel.font = [UIFont PingFangSC:14];
    self.titleLabel.text = @"选择返点比例";
    self.titleLabel.textColor = [UIColor hexColor:@"#474747"];
    [self.mainScollView addSubview:self.titleLabel];
    

    
    self.progressView = [[ZBProgressView alloc] initWithFrame:CGRectMake(15, self.titleLabel.bottom, SCREEN_WIDTH-30, 30)];
    self.progressView.progress = 0.5;
    [self.mainScollView addSubview:self.progressView];
    
    self.wodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.progressView.bottom+10, SCREEN_WIDTH, 44)];
    self.wodeLabel.font = [UIFont PingFangSC:14];
    self.wodeLabel.text = @"我的返点比例";
    self.wodeLabel.textColor = [UIColor hexColor:@"#474747"];
    [self.mainScollView addSubview:self.wodeLabel];
    
    
    self.ruleTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.progressView.bottom+50, SCREEN_WIDTH-30, 30)];
    self.ruleTextLabel.font = [UIFont PingFangSC:14];
    self.ruleTextLabel.text = @"邀请规则";
    self.ruleTextLabel.textAlignment = NSTextAlignmentCenter;
    self.ruleTextLabel.textColor = [UIColor hexColor:@"#474747"];
    [self.mainScollView addSubview:self.ruleTextLabel];
    
    self.textView = [[QMUITextView alloc] initWithFrame:CGRectMake(15, self.ruleTextLabel.bottom+10, SCREEN_WIDTH-30, 248)];
    self.textView.backgroundColor = [UIColor hexColor:@"#E9ECF5"];
    [self.textView setEditable:false];
    [self.mainScollView addSubview:self.textView];
    
    QMUIButton *btn = [[QMUIButton alloc] initWithFrame:CGRectMake(34, self.textView.bottom+50, SCREEN_WIDTH-34-34, 42)];
    btn.layer.cornerRadius = 42/2;
    btn.clipsToBounds = true;
    [btn setTitle:@"添加" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont PingFangSC:14];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor hexColor:@"FF2828"]];
    [self.mainScollView addSubview:btn];
    [btn addTarget:self action:@selector(onButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self fetchPostUri:@"/UserQrCode" params:nil];
    
}

- (void)onButton {
    int fee = [self.progressView.cursorLabel.text intValue];
    [self fetchPostUri:URI_ACCOUNT_POPULARIZE_ADD params:@{@"fee":@(fee)}];
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    if ([req.uri isEqualToString:URI_ACCOUNT_POPULARIZE_ADD]) {
        [ABUITips showSucceed:@"添加成功"];
        [self.navigationController popViewControllerAnimated:true];
    }else{
        self.textView.text = obj[@"ExtensionRules"];
        self.progressView.maxValue = MAX([obj[@"MaxFee"] intValue], 0);
        self.wodeLabel.text = [NSString stringWithFormat:@"我的返点比例%@%%", obj[@"UserFee"]];
    }
    
}

- (void)onNetRequestFailure:(ABNetRequest *)req err:(ABNetError *)err {
    [ABUITips showError:err.message];
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
