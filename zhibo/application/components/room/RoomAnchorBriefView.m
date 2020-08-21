//
//  LiveAnchorView.m
//  zhibo
//
//  Created by qp on 2020/7/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RoomAnchorBriefView.h"

@interface RoomAnchorBriefView ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *fansTextLabel;
@property (nonatomic, strong) UILabel *fansCountLabel;
@property (nonatomic, strong) UIButton *followButton;
@end
@implementation RoomAnchorBriefView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.clipsToBounds = true;
        
        self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 33, 33)];
        self.avatarImageView.layer.cornerRadius = 15;
        self.avatarImageView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.avatarImageView.clipsToBounds = true;
        [self addSubview:self.avatarImageView];
        
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.nameLabel];
        
        self.fansTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.fansTextLabel.textColor = [UIColor whiteColor];
        self.fansTextLabel.font = [UIFont systemFontOfSize:9];
        [self addSubview:self.fansTextLabel];
        
        
        self.followButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 18)];
        [self addSubview:self.followButton];
        [self.followButton gradient:GRADIENTCOLORS direction:0];
        [self.followButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.followButton.titleLabel.font = [UIFont systemFontOfSize:12];
        self.followButton.layer.cornerRadius = 9;
        self.followButton.clipsToBounds = true;
        [self.followButton addTarget:self action:@selector(onButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)onButton {
    [self.delegate roomAnchorBriefViewOnFollow:self];
}

- (void)setname:(NSString *)name icon:(NSString *)icon count:(NSInteger)count {
    NSString *fansCount = [NSString stringWithFormat:@"粉丝:%ld", (long)count];
    self.nameLabel.text = name;
    [self.nameLabel sizeToFit];
    self.nameLabel.width = 70;
    
    [self.avatarImageView loadImage:icon];
    self.fansTextLabel.text = fansCount;
    [self.fansTextLabel sizeToFit];
    
    [self.followButton setTitle:@"关注" forState:UIControlStateNormal];
}

- (void)setIsFollowed:(BOOL)isFollowed {
    _isFollowed = isFollowed;
    [self.followButton setHidden:isFollowed];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.avatarImageView.left = 2;
    self.avatarImageView.top = 2;
    
    self.nameLabel.left = 38;
    self.nameLabel.top = self.height/2-self.nameLabel.height;
    
    
    self.fansTextLabel.top = self.height/2+2;
    self.fansTextLabel.left = 38;
    
    self.followButton.left = self.width-self.followButton.width-6;
    self.followButton.centerY = self.height/2;
    
}
@end
