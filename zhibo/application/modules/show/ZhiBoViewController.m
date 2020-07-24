//
//  ZhiBoViewController.m
//  zhibo
//
//  Created by FaiWong on 2020/4/23.
//  Copyright © 2020 qp. All rights reserved.
//

#import "ZhiBoViewController.h"
@import TXLiteAVSDK_Smart;
@interface ZhiBoViewController ()

@end

@implementation ZhiBoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    TXLivePushConfig *_config = [[TXLivePushConfig alloc] init];  // 一般情况下不需要修改默认 confi
    TXLivePush *_pusher = [[TXLivePush alloc] initWithConfig: _config]; // config
    
    UIView *_localView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view insertSubview:_localView atIndex:0];
    _localView.center = self.view.center;
    [_pusher startPreview:_localView];
    
    NSString* rtmpUrl = @"rtmp://93621.livepush.myqcloud.com/live/1111?txSecret=04e9173d9839deac2b07cc892d43a69a&txTime=5EA069FF";
    [_pusher startPush:rtmpUrl];
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
