//
//  HelpViewController.m
//  zhibo
//
//  Created by qp on 2020/8/15.
//  Copyright © 2020 qp. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()<INetData>
@property (nonatomic, strong) ABUIWebView *webView;
@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView = [[ABUIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    
    [self fetchPostUri:URI_ACCOUNT_HELP params:nil];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.webView.frame = CGRectMake(0, 0, self.view.width, self.view.height-SAFEHEIGHT);
    
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    if ([obj[@"address"] hasPrefix:@"http"]) {
        [self.webView loadWebWithPath:obj[@"address"]];
    }else{
        [ABUITips showError:@"功能未上线"];
    }
}
@end
