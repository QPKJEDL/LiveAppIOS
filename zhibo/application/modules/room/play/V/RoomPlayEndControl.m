//
//  RoomPlayEndControl.m
//  zhibo
//
//  Created by qp on 2020/7/15.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RoomPlayEndControl.h"
@interface RoomPlayEndControl()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) ABUIWebView *webView;
@end
@implementation RoomPlayEndControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor hexColor:@"161823"];
        
        //设置背景图片
        _avatarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, SYS_STATUSBAR_HEIGHT+100, 100, 100)];
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        _avatarImageView.layer.cornerRadius = 50;
        _avatarImageView.clipsToBounds = true;
        [self addSubview:_avatarImageView];
        _avatarImageView.centerX = self.width/2;

        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SYS_STATUSBAR_HEIGHT+80, self.width, 100)];
        self.nameLabel.text = @"直播已结束";
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.nameLabel];
        
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SYS_STATUSBAR_HEIGHT+80, self.width, 30)];
        self.titleLabel.text = @"直播已结束";
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        
        self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.titleLabel.bottom+50, 200, 44)];
        self.backButton.layer.cornerRadius = 22;
        self.backButton.clipsToBounds = true;
        [self.backButton setTitle:@"返回" forState:UIControlStateNormal];
        [self.backButton setBackgroundColor:[UIColor hexColor:@"00BFCB"]];
        [self.backButton addTarget:self action:@selector(onBack) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.backButton];
        
        self.backButton.centerX = self.width/2;
        
        
        self.webView = [[ABUIWebView alloc] initWithFrame:CGRectMake(0, SYS_STATUSBAR_HEIGHT, 290, 130)];
        self.webView.webView.scrollView.showsVerticalScrollIndicator = false;
        self.webView.webView.scrollView.showsHorizontalScrollIndicator = false;
        self.webView.webView.scrollView.bounces = false;
        self.webView.webView.scrollView.scrollEnabled = false;
        
//        self.webView.adapterSize = true;
//        [self addSubview:self.webView];
//        [self.webView loadWebWithPath:@"http://192.168.0.101/wenlu/index.html"];
    }
    return self;
}

- (void)setData:(NSDictionary *)data {
    NSString *avater = data[@"anchor"][@"Avater"];
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:avater] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    self.nameLabel.text = data[@"anchor"][@"NickName"];
    [self.nameLabel sizeToFit];
    self.nameLabel.top = self.avatarImageView.bottom+20;
    self.nameLabel.centerX = self.width/2;
    
    self.titleLabel.top = self.nameLabel.bottom+50;
    self.backButton.top = self.titleLabel.bottom+50;
}

- (void)onBack {
//    [NSRouter back];
    [self.webView callFuncName:@"abc" data:@"1111" completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
        
    }];
}
@end
