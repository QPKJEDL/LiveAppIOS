//
//  UserListViewController.m
//  zhibo
//
//  Created by qp on 2020/7/8.
//  Copyright © 2020 qp. All rights reserved.
//

#import "UserListViewController.h"

@interface UserListViewController ()<INetData>

@end

@implementation UserListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self fetchPostUri:URI_FOLLOW_LIST params:nil];
    
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    NSLog(@"%@", obj);
}

@end
