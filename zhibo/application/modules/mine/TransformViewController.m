//
//  TransformViewController.m
//  zhibo
//
//  Created by qp on 2020/8/3.
//  Copyright © 2020 qp. All rights reserved.
//

#import "TransformViewController.h"
#import "MoneyInPrompt.h"
#import "MoneyOutPrompt.h"
@interface TransformViewItem: UIView
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) QMUIButton *button1;
@property (nonatomic, strong) QMUIButton *button2;
@end

@implementation TransformViewItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.imageView setImage:[UIImage imageNamed:@"jinsede"]];
        [self addSubview:self.imageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel.text = @"账户余额";
        self.titleLabel.font = [UIFont PingFangSC:14];
        self.titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        [self.titleLabel sizeToFit];
        self.titleLabel.left = 17;
        self.titleLabel.top = 25;
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.contentLabel.text = @"0";
        self.contentLabel.font = [UIFont PingFangSC:23];
        self.contentLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.contentLabel];
        [self.contentLabel sizeToFit];
        self.contentLabel.width = self.width-30;
        self.contentLabel.left = 17;
        self.contentLabel.centerY = self.height*0.6;
        
        self.button1 = [[QMUIButton alloc] initWithFrame:CGRectMake(self.width-89-70, self.height-30-10, 69, 31)];
        [self.button1 setTitleColor:[UIColor hexColor:@"#474747"] forState:UIControlStateNormal];
        [self.button1 setBackgroundColor:[UIColor hexColor:@"#E9ECF5"]];
        self.button1.titleLabel.font = [UIFont PingFangSC:14];
        self.button1.layer.cornerRadius = 15;
        self.button1.clipsToBounds = true;
        [self addSubview:self.button1];
        
        self.button2 = [[QMUIButton alloc] initWithFrame:CGRectMake(self.button1.right+10, self.height-30-10, 69, 31)];
        [self.button2 setTitleColor:[UIColor hexColor:@"#474747"] forState:UIControlStateNormal];
        [self.button2 setBackgroundColor:[UIColor hexColor:@"#E9ECF5"]];
         self.button2.titleLabel.font = [UIFont PingFangSC:14];
        self.button2.layer.cornerRadius = 15;
        self.button2.clipsToBounds = true;
        [self addSubview:self.button2];
    }
    return self;
}

@end

@interface TransformViewController ()<INetData, IABMQSubscribe>
@property (nonatomic, strong) TransformViewItem *balanceItem;
@property (nonatomic, strong) TransformViewItem *shixunItem;
@end

@implementation TransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.balanceItem = [[TransformViewItem alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH-30, 152)];
    [self.balanceItem.imageView setImage:[UIImage imageNamed:@"hongsede"]];
    [self.balanceItem.button1 setTitle:@"充值" forState:UIControlStateNormal];
    [self.balanceItem.button2 setTitle:@"提现" forState:UIControlStateNormal];
    [self.balanceItem.button1 addTarget:self action:@selector(onAButton1) forControlEvents:UIControlEventTouchUpInside];
    [self.balanceItem.button2 addTarget:self action:@selector(onAButton2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.balanceItem];
    
    self.shixunItem = [[TransformViewItem alloc] initWithFrame:CGRectMake(15, 186, SCREEN_WIDTH-30, 119)];
    self.shixunItem.titleLabel.text = @"视讯余额";
    [self.shixunItem.button1 setTitle:@"转入" forState:UIControlStateNormal];
    [self.shixunItem.button2 setTitle:@"转出" forState:UIControlStateNormal];
    [self.shixunItem.button1 addTarget:self action:@selector(onBButton1) forControlEvents:UIControlEventTouchUpInside];
    [self.shixunItem.button2 addTarget:self action:@selector(onBButton2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.shixunItem];
    
    [self fetchPostUri:URI_ACCOUNT_BALANCE_INFO params:nil];
    [self fetchPostUri:URI_ACCOUNT_SX_BANLANCE params:nil];
    
    [[ABMQ shared] subscribe:self channel:@"refreshbalance" autoAck:true];
}

- (void)abmq:(ABMQ *)abmq onReceiveMessage:(id)message channel:(NSString *)channel {
    [self fetchPostUri:URI_ACCOUNT_BALANCE_INFO params:nil];
    [self fetchPostUri:URI_ACCOUNT_SX_BANLANCE params:nil];
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    if ([req.uri isEqualToString:URI_ACCOUNT_BALANCE_INFO]) {
        [self.balanceItem.contentLabel setText:[obj stringValueForKey:@"info"]];
    }
    if ([req.uri isEqualToString:URI_ACCOUNT_SX_BANLANCE]) {
        [self.shixunItem.contentLabel setText:[obj stringValueForKey:@"balance"]];
    }
}

- (void)onAButton1 {
    [NSRouter gotoReCharge];
}

- (void)onAButton2 {
    [NSRouter gotoCashOut];
}

- (void)onBButton1 {
    MoneyInPrompt *prompt = [[MoneyInPrompt alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-30, 200)];
    [prompt.layer setCornerRadius:10];
    [prompt setBalance:self.balanceItem.contentLabel.text];
    [[ABUIPopUp shared] show:prompt from:ABPopUpDirectionTop distance:SCREEN_HEIGHT/4 hideBlock:^{
        [self.view endEditing:true];
    }];
}

- (void)onBButton2 {
    MoneyOutPrompt *prompt = [[MoneyOutPrompt alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-30, 200)];
    [prompt.layer setCornerRadius:10];
    [prompt setBalance:self.shixunItem.contentLabel.text];
    [[ABUIPopUp shared] show:prompt from:ABPopUpDirectionTop distance:SCREEN_HEIGHT/4 hideBlock:^{
        [self.view endEditing:true];
    }];
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
