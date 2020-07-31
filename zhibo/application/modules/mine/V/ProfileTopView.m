//
//  ProfileTopView.m
//  zhibo
//
//  Created by qp on 2020/7/28.
//  Copyright © 2020 qp. All rights reserved.
//

#import "ProfileTopView.h"
@interface ProfileTopView ()
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nickLabel;
@property (nonatomic, strong) UILabel *idLabel;
@property (nonatomic, strong) QMUIButton *followButton;

@property (nonatomic, assign) NSInteger uid;
@end
@implementation ProfileTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor hexColor:@"#FF2828"];
        
        self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        [self.avatarImageView setContentMode:UIViewContentModeScaleAspectFill];
        self.avatarImageView.clipsToBounds = true;
        self.avatarImageView.layer.cornerRadius = 25;
        [self addSubview:self.avatarImageView];
        
        self.nickLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.nickLabel.textColor = [UIColor whiteColor];
        self.nickLabel.font = [UIFont PingFangSCBlod:15];
        [self addSubview:self.nickLabel];
        
        self.idLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.idLabel.textColor = [UIColor whiteColor];
        self.idLabel.font = [UIFont PingFangSCBlod:10];
        [self addSubview:self.idLabel];
        
        self.followButton = [[QMUIButton alloc] initWithFrame:CGRectMake(0, 0, 74, 28)];
        [self.followButton setTitle:@"关注" forState:UIControlStateNormal];
        [self.followButton setTitle:@"已关注" forState:UIControlStateSelected];
        self.followButton.titleLabel.font = [UIFont PingFangSCBlod:14];
        [self.followButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:self.followButton];
        self.followButton.layer.borderWidth = 1;
        self.followButton.layer.borderColor = [UIColor whiteColor].CGColor;
        self.followButton.layer.cornerRadius = 14;
        self.followButton.clipsToBounds = true;
        [self.followButton addTarget:self action:@selector(onFollow) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)onFollow {
    if (self.followButton.isSelected) {
        [[Service shared] unfollowUserWithUid:self.uid];
    }else{
        [[Service shared] followUserWithUid:self.uid];
    }
}

- (void)setData:(NSDictionary *)data {
    self.uid = [data[@"UserId"] intValue];
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:data[@"Avater"]] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    
    self.nickLabel.text = data[@"NickName"];
    [self.nickLabel sizeToFit];
    
    self.idLabel.text = [NSString stringWithFormat:@"直播ID:%@", data[@"UserId"]];
    [self.idLabel sizeToFit];
    
    [self.followButton setSelected:[data[@"isFollowed"] intValue] == 1];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.avatarImageView.left = 15;
    self.avatarImageView.centerY = self.height/2;
    
    self.nickLabel.left = self.avatarImageView.right+5;
    self.idLabel.left = self.avatarImageView.right+5;
    
    self.nickLabel.top = self.height/2-self.nickLabel.height;
    self.idLabel.top = self.height/2;
    
    self.followButton.left = self.width-15-self.followButton.width;
    self.followButton.centerY = self.height/2;
}

@end
