//
//  PopularizeListViewController.m
//  zhibo
//
//  Created by qp on 2020/8/4.
//  Copyright © 2020 qp. All rights reserved.
//

#import "PopularizeListViewController.h"

@interface PopularizeListViewController ()<INetData>
@property (nonatomic, strong) ABUIListView *listView;

@end

@implementation PopularizeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.listView = [[ABUIListView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.listView];
    
    [self fetchPostUri:URI_ACCOUNT_POPULARIZE_CODELIST params:nil];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.listView.frame = self.view.bounds;
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    [self.listView setDataList:obj[@"list"] css:@{@"item.size.height":@(74)}];
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
