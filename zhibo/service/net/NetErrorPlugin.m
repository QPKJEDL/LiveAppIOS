//
//  NetPlugin.m
//  zhibo
//
//  Created by qp on 2020/6/30.
//  Copyright © 2020 qp. All rights reserved.
//

#import "NetErrorPlugin.h"
#import "AppDelegate.h"
@implementation NetErrorPlugin

- (void)didReceiveError:(ABNetRequest *)request error:(ABNetError *)error {
//    [[UIApplication sharedApplication].keyWindow makeToast:error.message duration:1 position:CSToastPositionCenter];
    NSLog(@"%@",error.message);
    if (error.code == 2) {
        [ABUITips showSucceed:@"登录失效，请重新登录"];
        [[Service shared].account logout];
        [(AppDelegate *)[UIApplication sharedApplication].delegate setUpWindow];
    }
}

@end
