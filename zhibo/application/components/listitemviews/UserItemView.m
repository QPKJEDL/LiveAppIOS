//
//  UserItemView.m
//  zhibo
//
//  Created by qp on 2020/7/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import "UserItemView.h"
@interface UserItemView ()
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *signLabel;
@property (nonatomic, strong) UILabel *fansLabel;

@property (nonatomic, strong) UIImageView *aniImageView;
@property (nonatomic, strong) UILabel *aniTextLabel;
@property (nonatomic, assign) BOOL isLoading;
@end
@implementation UserItemView

- (void)setupAdjustContents {
    self.backgroundColor = [UIColor clearColor];
    
    self.containView = [[UIView alloc] initWithFrame:CGRectInset(self.bounds, 10, 0)];
    self.containView.backgroundColor = [UIColor whiteColor];
    self.containView.layer.cornerRadius = 6;
    self.containView.clipsToBounds = true;
    [self addSubview:self.containView];
    
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.iconImageView.layer.cornerRadius = 24;
    self.iconImageView.clipsToBounds = true;
    [self.containView addSubview:self.iconImageView];
    
    self.nameLabel = [[QMUILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 10)];
    self.nameLabel.textColor = [UIColor hexColor:@"#474747"];
    self.nameLabel.font = [UIFont PingFangMedium:14];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.containView addSubview:self.nameLabel];
    
    self.signLabel = [[QMUILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 10)];
    self.signLabel.textColor = [UIColor hexColor:@"#8A8A8A"];
    self.signLabel.font = [UIFont PingFangSC:12];
    [self.containView addSubview:self.signLabel];
    
    self.fansLabel = [[QMUILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 10)];
    self.fansLabel.textColor = [UIColor hexColor:@"#8A8A8A"];
    self.fansLabel.font = [UIFont PingFangSC:12];
    [self.containView addSubview:self.fansLabel];
    
    self.aniImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 26, 20)];
    [self.aniImageView loadAni:@[@"guanzhu_001", @"guanzhu_002", @"guanzhu_003"]];
    self.aniImageView.animationDuration = 0.5;
    [self.containView addSubview:self.aniImageView];
    
    
    self.aniTextLabel = [[QMUILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 10)];
    self.aniTextLabel.textColor = [UIColor hexColor:@"#8A8A8A"];
    self.aniTextLabel.font = [UIFont PingFangMedium:9];
    [self.containView addSubview:self.aniTextLabel];
    
    
}

- (void)reload:(NSDictionary *)item {
    self.nameLabel.text = item[@"nickname"];
    [self.nameLabel sizeToFit];
    
    NSString *avatar = item[@"avater"];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:avatar] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    NSString *sign = item[@"sign"];
    if (sign.length == 0) {
        sign = @"这个人很懒，什么也没留下";
    }
    self.signLabel.text = sign;
    [self.signLabel sizeToFit];
    self.fansLabel.text = [NSString stringWithFormat:@"粉丝数量:%@", item[@"fans"]];
    [self.fansLabel sizeToFit];
    
    BOOL isOpen = [item[@"status"] intValue] == 1;
    if (isOpen) {
        self.aniTextLabel.text = @"直播中";
        self.aniTextLabel.textColor = [UIColor hexColor:@"#00BFCB"];
        self.aniTextLabel.top = 52;
        [self.aniImageView startAnimating];
        self.isLoading = true;
    }else{
        self.aniTextLabel.text = @"暂无直播";
        self.aniTextLabel.textColor = [UIColor hexColor:@"#D1D7E0"];
        self.aniTextLabel.centerY = self.height/2;
        [self.aniImageView stopAnimating];
        self.isLoading = false;
    }
    [self.aniTextLabel sizeToFit];
    [self layoutAdjustContents];
}

- (void)setHighlighted:(BOOL)highlighted {
    if (self.isLoading && !self.aniImageView.isAnimating) {
        [self.aniImageView startAnimating];
    }
}

- (void)layoutAdjustContents {
    self.iconImageView.left = 11;
    self.iconImageView.centerY = self.height/2;
    
    self.nameLabel.left = self.iconImageView.right+15;
    self.nameLabel.top = 13;
    
    self.signLabel.top = 37;
    self.signLabel.left = self.iconImageView.right+15;
    
    self.fansLabel.top = 55;
    self.fansLabel.left = self.iconImageView.right+15;
    
    self.aniImageView.centerX = self.containView.width-30;
    self.aniImageView.top = 23;
    
    self.aniTextLabel.centerX = self.containView.width-30;
}

@end
