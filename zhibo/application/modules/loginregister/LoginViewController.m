//
//  LoginViewController.m
//  zhibo
//
//  Created by qp on 2020/6/21.
//  Copyright © 2020 qp. All rights reserved.
//

#import "LoginViewController.h"
#import <ABCountDownButton.h>
//#import "LoginRegisterPresent.h"
#import "LoginRegPresent.h"
#import "AppDelegate.h"
#import "LoginView.h"
#import "LoginPhoneView.h"
#import "RegisterView.h"
@interface LoginViewController ()<JXCategoryViewDelegate, LoginRegPresentDelegate, LoginViewDelegate, LoginPhoneViewDelegate, RegisterViewDelegate>

@property (nonatomic, strong) UIScrollView *containScrollView;
@property (nonatomic, strong) UIImageView *topView;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel *logoTextLabel;
@property (nonatomic, strong) LoginView *loginView;
@property (nonatomic, strong) LoginPhoneView *loginPhoneView;
@property (nonatomic, strong) RegisterView *registerView;

@property (nonatomic, strong) UIImageView *corsorImageView;

@property (nonatomic, strong) JXCategoryTitleView *categoryView;

@property (nonatomic, strong) LoginRegPresent *lrPresent;

@property (nonatomic, assign) NSInteger displayIndex;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor hexColor:@"ffffff"];
    
    self.isVisableNavigationBar = false;
    self.lrPresent = [[LoginRegPresent alloc] init];
    self.lrPresent.delegate = self;
    
    [self loadSubView];
    
    [self display:0];
    

}

- (void)loadSubView {
    
    self.containScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.containScrollView.contentSize = self.view.size;
    self.containScrollView.bounces = false;
    [self.view addSubview:self.containScrollView];

    self.topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 325)];
//    self.topView.backgroundColor = [UIColor hexColor:@"FF2B2B"];
//    self.topView.image = [UIImage imageNamed:@"beijing"];
    [self.containScrollView addSubview:self.topView];
    [self.topView gradient:GRADIENTCOLORS direction:0];
    
    self.logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20+SYS_STATUSBAR_HEIGHT, 90, 90)];
    self.logoImageView.centerX = self.view.width/2;
    self.logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.logoImageView setImage:[UIImage imageNamed:@"logo"]];
    [self.topView addSubview:self.logoImageView];
    
    self.logoTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.logoImageView.bottom, SCREEN_WIDTH, 30)];
    [self.logoTextLabel setText:@"视讯直播"];
    self.logoTextLabel.font = [UIFont PingFangSCBlod:22];
    self.logoTextLabel.textColor = [UIColor hexColor:@"#EAE361"];
    self.logoTextLabel.textAlignment = NSTextAlignmentCenter;
    [self.topView addSubview:self.logoTextLabel];
    
    self.loginView = [[LoginView alloc] initWithFrame:CGRectMake(11, 261, SCREEN_WIDTH-22, 332)];
    self.loginView.delegate = self;
    [self.containScrollView addSubview:self.loginView];

    self.loginPhoneView = [[LoginPhoneView alloc] initWithFrame:CGRectMake(11, 261, SCREEN_WIDTH-22, 332)];
    self.loginPhoneView.delegate = self;
    [self.containScrollView addSubview:self.loginPhoneView];

    self.registerView = [[RegisterView alloc] initWithFrame:CGRectMake(11, 261, SCREEN_WIDTH-22, 411)];
    self.registerView.delegate = self;
    [self.containScrollView addSubview:self.registerView];
    
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(22, 206, self.view.width-44, 40)];
    [self.categoryView setAverageCellSpacingEnabled:false];
    self.categoryView.cellSpacing = 0;
    self.categoryView.contentEdgeInsetLeft = 0;
    self.categoryView.backgroundColor = UIColor.clearColor;
    self.categoryView.delegate = self;
    self.categoryView.titleLabelZoomEnabled = true;
    self.categoryView.titleColor = [[UIColor hexColor:@"#FFFFFF"] colorWithAlphaComponent:0.65];
    self.categoryView.titleSelectedColor = [UIColor hexColor:@"#FFFFFF"];
    self.categoryView.titleFont = [UIFont boldSystemFontOfSize:20];
    self.categoryView.cellWidth = self.categoryView.width/2;
    [self.containScrollView addSubview:self.categoryView];
    self.categoryView.titles = @[@"登录", @"注册"];
    self.categoryView.titleColorGradientEnabled = YES;
    
    UIImage *im = [UIImage imageNamed:@"triggle"];
    self.corsorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, im.size.width, im.size.height)];
    [self.corsorImageView setImage:im];
    [self.containScrollView addSubview:self.corsorImageView];
    self.corsorImageView.top = self.loginView.top-self.corsorImageView.height;
}

- (BOOL)shouldHideKeyboardWhenTouchInView:(UIView *)view {
    return YES;
}

- (void)backAction {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)display:(NSInteger)n {
    [self.loginView setHidden:true];
    [self.loginPhoneView setHidden:true];
    [self.registerView setHidden:true];
    if (n == 0) { // 显示账号登录
        [self.loginView setHidden:false];
        self.corsorImageView.centerX = self.categoryView.centerX-self.categoryView.width/4;
    }
    else if (n == 1) { // 显示手机号登录
        [self.loginPhoneView setHidden:false];
        self.corsorImageView.centerX = self.categoryView.centerX-self.categoryView.width/4;
    }else{ // 显示注册
        [self.registerView setHidden:false];
        self.corsorImageView.centerX = self.categoryView.centerX+self.categoryView.width/4;
    }
    if (n == 2) {
        return;
    }
    self.displayIndex = n;
}

#pragma mark ------ delegates ---------------
#pragma mark ------ loginview delegate ----------
- (void)loginView:(LoginView *)loginView onLoginUserName:(NSString *)username password:(NSString *)password {
    [self.lrPresent login:username passsword:password];
}

- (void)loginViewOnChange:(LoginView *)loginView {
    [self display:1];
}


#pragma mark  ------------ loginphoneView delegaet ------------
- (void)loginPhoneViewOnChange:(LoginView *)loginView {
    [self display:0];
}

- (void)loginPhoneView:(LoginView *)loginView onLoginPhone:(NSString *)phone code:(NSString *)code {
    
}

#pragma mark --------------- jxcategory delegaete --------------
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    if (index == 0) {
        [self display:self.displayIndex];
    }else{
        [self display:2];
    }
}

#pragma mark ----------- registerview delegate ------------
- (void)registerView:(RegisterView *)registerView onRegisterUserName:(NSString *)username nickName:(NSString *)nickName password:(NSString *)password {
    [self.lrPresent reg:username nickname:nickName passsword:password];
}

#pragma mark ------- loginregister present delegate --------
- (void)loginReqPresent:(LoginRegPresent *)loginReqPresent onLoginSuccess:(NSDictionary *)data {
//    [self dismissViewControllerAnimated:true completion:nil];
    [(AppDelegate *)[UIApplication sharedApplication].delegate setUpWindow];
}

- (void)loginReqPresent:(nonnull LoginRegPresent *)loginReqPresent onRegisterSuccess:(nonnull NSDictionary *)data {
    
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
