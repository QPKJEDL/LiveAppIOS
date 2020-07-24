//
//  BaseViewController.m
//  zhibo
//
//  Created by FaiWong on 2020/4/22.
//  Copyright © 2020 qp. All rights reserved.
//

#import "BaseViewController.h"
#import <IQKeyboardManager.h>

#define IQSets @[@"SettingViewController", @"LoginViewController", @"CashOutViewController"]

@interface BaseViewController ()
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.view.backgroundColor = [UIColor hexColor:@"F7F9FD"];
}

- (void)showNoDataEmpty {
    [self showEmptyViewWithImage:[UIImage imageNamed:@"shuju"] text:@"暂无数据" detailText:nil buttonTitle:@"点击刷新" buttonAction:@selector(refreshData)];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSString *des = [[self class] description];
    
    
    if ([IQSets containsObject:des]) {
        [IQKeyboardManager sharedManager].enable = true;
        [IQKeyboardManager sharedManager].enableAutoToolbar = true;
    }else{
        [IQKeyboardManager sharedManager].enable = false;
        [IQKeyboardManager sharedManager].enableAutoToolbar = false;
    }
}



- (void)hideEmptyView{
    [self.emptyView removeFromSuperview];
}

- (void)refreshData {
    
}

- (BOOL)shouldHideKeyboardWhenTouchInView:(UIView *)view {
    return true;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:true];
}

- (void)dealloc
{
    NSLog(@"%@ dealloc", [[self class] description]);
}

- (UIModalPresentationStyle)modalPresentationStyle {
    return UIModalPresentationFullScreen;
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
