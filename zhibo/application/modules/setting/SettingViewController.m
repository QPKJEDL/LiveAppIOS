//
//  NSettingViewController.m
//  zhibo
//
//  Created by qp on 2020/7/24.
//  Copyright © 2020 qp. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingPresent.h"
#import "AppDelegate.h"
@interface SettingViewController ()<ABUIListViewDelegate, SettingPresentDelegate>
@property (nonatomic, strong) ABUIListView *listtView;
@property (nonatomic, strong) SettingPresent *present;
@property (nonatomic, strong) UIButton *actionButton;
@property (nonatomic, strong) UIView *footerView;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    
    self.listtView = [[ABUIListView alloc] initWithFrame:self.view.bounds];
    self.listtView.delegate = self;
    [self.view addSubview:self.listtView];
    
    self.present = [[SettingPresent alloc] init];
    self.present.delegate = self;
    [self.present getSettingData:self.key];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.listtView.frame = self.view.bounds;
    self.listtView.top = 1;
}

- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item {
    NSString *type = item[@"type"];
    if ([type isEqualToString:@"arrow"]) {
        NSString *key = item[@"key"];
        if ([key isEqualToString:@"binding_bank"] && [Service shared].account.isBindBank) {
            key = @"editing_bank";
        }
        [NSRouter gotoSettingPage:key];
    }
}

- (void)buttonAction {
    if ([self.key isEqualToString:@"home"]) {
        [[Service shared].account logout];
        [(AppDelegate *)[UIApplication sharedApplication].delegate setUpWindow];
        return;
    }

//    [self.view makeToastActivity:CSToastPositionCenter];
    if ([self.key isEqualToString:@"loginpwd"]) {
        NSString *newpwd = [[[Stack shared] get:@"newpwd"] trimmingNewLineAndWhiteSpace];
        NSString *renewpwd = [[[Stack shared] get:@"renewpwd"] trimmingNewLineAndWhiteSpace];
        NSString *smscode = [[[Stack shared] get:@"sms"] trimmingNewLineAndWhiteSpace];
        if (newpwd.length == 0) {
            [ABUITips showError:@"请输入密码"];
            return;
        }
        if (![newpwd isEqualToString:renewpwd]) {
            [ABUITips showError:@"密码输入不一致"];
            return;
        }
        
        if (smscode.length == 0) {
            [ABUITips showError:@"请输入验证码"];
            return;
        }
        
        [self fetchPostUri:URI_ACCOUNT_FORGET_LOGIN params:@{@"new_pwd":newpwd, @"code":smscode}];
    }
    if ([self.key isEqualToString:@"rechargepwd"]) {
        NSString *newpwd = [[[Stack shared] get:@"newpwd"] trimmingNewLineAndWhiteSpace];
        NSString *renewpwd = [[[Stack shared] get:@"renewpwd"] trimmingNewLineAndWhiteSpace];
        NSString *smscode = [[[Stack shared] get:@"sms"] trimmingNewLineAndWhiteSpace];
        if (newpwd.length == 0) {
            [ABUITips showError:@"请输入密码"];
            return;
        }
        if (![newpwd isEqualToString:renewpwd]) {
            [ABUITips showError:@"密码输入不一致"];
            return;
        }
        
        if (smscode.length == 0) {
            [ABUITips showError:@"请输入验证码"];
            return;
        }
        
        [self fetchPostUri:URI_ACCOUNT_FORGET_RECHARGE params:@{@"new_pwd":newpwd, @"code":smscode}];
    }
    if ([self.key isEqualToString:@"editnick"]) {
        NSString *nickname = [[Stack shared] get:@"nickname"];
        if ([nickname isEqualToString:@":recovery"]) {
            [NSRouter gotoXXXX];
            return;
        }
        [self fetchPostUri:URI_ACCOUNT_EDIT_NICKNAME params:@{@"nickname":[[Stack shared] get:@"nickname"]}];
    }
    if ([self.key isEqualToString:@"binding_wechat"]) {
        [self fetchPostUri:URI_ACCOUNT_BIND_WECHAT params:@{@"wx":[[Stack shared] get:@"wx_account"], @"wx_name":[[Stack shared] get:@"wx_name"]}];
    }
    if ([self.key isEqualToString:@"binding_alipay"]) {
        [self fetchPostUri:URI_ACCOUNT_BIND_ALIPAY params:@{@"ali":[[Stack shared] get:@"alipay_account"], @"ali_name":[[Stack shared] get:@"alipay_name"]}];
    }
    if ([self.key isEqualToString:@"editing_bank"]) {
        NSString *bankCardNumber = [[Stack shared] get:@"bank_cardnumber"];
        bankCardNumber = [bankCardNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (![ABTools isValidBankCardNo:bankCardNumber]) {
            [ABUITips showError:@"银行卡号码错误"];
            return;
        }
        NSString *bank_username = [[Stack shared] get:@"bank_username"];
        NSString *bank_name = [[Stack shared] get:@"bank_name"];
        NSString *bank_store = [[Stack shared] get:@"bank_store"];
        if (bank_username.length == 0) {
            [ABUITips showError:@"请输入持卡人姓名"];
            return;
        }
        if (bank_name.length == 0) {
            [ABUITips showError:@"请输入银行名称"];
            return;
        }
        if (bank_store.length == 0) {
            [ABUITips showError:@"请输入开户网点"];
            return;
        }
        [self fetchPostUri:URI_ACCOUNT_BIND_CARD params:@{
            @"card_name":bank_username,
            @"bank_name":bank_name,
            @"bank_card":bankCardNumber,
            @"bank_addr":bank_store,
            @"type":@"2",
        }];
    }
    if ([self.key isEqualToString:@"binding_bank"]) {
        NSString *bankCardNumber = [[Stack shared] get:@"bank_cardnumber"];
        bankCardNumber = [bankCardNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (![ABTools isValidBankCardNo:bankCardNumber]) {
            [ABUITips showError:@"银行卡号码错误"];
            return;
        }
        NSString *draw_pwd1 = [[Stack shared] get:@"bank_pwd"];
        NSString *draw_pwd2 = [[Stack shared] get:@"rebank_pwd"];
        NSString *bank_username = [[Stack shared] get:@"bank_username"];
        NSString *bank_name = [[Stack shared] get:@"bank_name"];
        NSString *bank_store = [[Stack shared] get:@"bank_store"];
        if (bank_username.length == 0) {
            [ABUITips showError:@"请输入持卡人姓名"];
            return;
        }
        if (bank_name.length == 0) {
            [ABUITips showError:@"请输入银行名称"];
            return;
        }
        if (bank_store.length == 0) {
            [ABUITips showError:@"请输入开户网点"];
            return;
        }
        if (draw_pwd1.length == 0) {
            [ABUITips showError:@"请填写支付密码"];
            return;
        }
        if (draw_pwd2.length == 0) {
            [ABUITips showError:@"请再次填写支付密码"];
            return;
        }
        
        if ([draw_pwd2 isEqualToString:draw_pwd1] == false) {
            [ABUITips showError:@"两次支付密码输入不一致"];
            return;
        }
        
        [self fetchPostUri:URI_ACCOUNT_BIND_CARD params:@{
            @"card_name":bank_username,
            @"bank_name":bank_name,
            @"bank_card":bankCardNumber,
            @"bank_addr":bank_store,
            @"draw_pwd1":draw_pwd1,
            @"draw_pwd2":draw_pwd2,
            @"type":@"1",
        }];
    }
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    [self.view hideToastActivity];
    if ([req.uri isEqualToString:URI_ACCOUNT_FORGET_LOGIN]) {
        [ABUITips showSucceed:@"修改成功"];
        [self.navigationController popViewControllerAnimated:true];
    }
    if ([req.uri isEqualToString:URI_ACCOUNT_FORGET_RECHARGE]) {
        [ABUITips showSucceed:@"修改成功"];
        [self.navigationController popViewControllerAnimated:true];
    }
    if ([req.uri isEqualToString:URI_ACCOUNT_EDIT_NICKNAME]) {
        [[Service shared].account updateInfo:@{@"NickName":req.params[@"nickname"]}];
        [ABUITips showSucceed:@"修改成功"];
        [self.navigationController popViewControllerAnimated:true];
    }
    if ([req.uri isEqualToString:URI_ACCOUNT_BIND_WECHAT]) {
        [ABUITips showSucceed:@"绑定成功"];
        [[Service shared].account updateBank:@{@"Wx":req.params[@"wx"], @"WxName":req.params[@"wx_name"]}];
    }
    if ([req.uri isEqualToString:URI_ACCOUNT_BIND_ALIPAY]) {
         [ABUITips showSucceed:@"绑定成功"];
        [[Service shared].account updateBank:@{@"Ali":req.params[@"ali"], @"AliName":req.params[@"ali_name"]}];
    }
    if ([req.uri isEqualToString:URI_ACCOUNT_BIND_CARD]) {
         [ABUITips showSucceed:@"绑定成功"];
        [self fetchPostUri:URI_ACCOUNT_INFO params:nil];
       [self.navigationController popViewControllerAnimated:true];
    }
    if ([req.uri isEqualToString:URI_ACCOUNT_INFO]) {
        [[Service shared].account setInfo:obj];
    }
}

- (void)onNetRequestFailure:(ABNetRequest *)req err:(ABNetError *)err {
    [self.view hideToastActivity];
    [ABUITips showError:err.message];
}

- (void)present:(SettingPresent *)present onDataList:(NSArray *)dataList {
    self.title = self.present.title;
    NSDictionary *actions = self.present.actions;
    if (actions != nil) {
        self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
        _listtView.footerView = self.footerView;
        
        self.actionButton = [ViewUtil createButtonWithTitle:actions[@"title"] color:[UIColor hexColor:@"#FF2A40"] fontSize:16 isBold:true];
        [self.actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.actionButton.backgroundColor = [UIColor hexColor:@"#FF2A40"];
        if (actions[@"bgcolor"]) {
            self.actionButton.backgroundColor = [UIColor hexColor:actions[@"bgcolor"]];
        }
        self.actionButton.titleLabel.font = [UIFont PingFangMedium:18];
        self.actionButton.frame = CGRectMake(0, 0, self.view.width-50, 50);
        self.actionButton.layer.cornerRadius = 25;
        self.actionButton.clipsToBounds = true;
        self.actionButton.centerX = self.view.width/2;
        [self.actionButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        self.actionButton.top = self.footerView.height-self.actionButton.height;
        [self.footerView addSubview:self.actionButton];
    }
    [self.listtView setTempleteDataList:dataList];
}


@end
