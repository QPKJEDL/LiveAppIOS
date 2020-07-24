//
//  LiveUserView.m
//  zhibo
//
//  Created by FaiWong on 2020/5/3.
//  Copyright © 2020 qp. All rights reserved.
//

#import "LiveUserView.h"

@implementation LiveUserView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.clipsToBounds = true;
        
        self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        self.avatarImageView.layer.cornerRadius = 15;
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
    }
    return self;
}

- (void)reload:(NSDictionary *)data {
    NSString *avatar = data[@"icon"];
    NSString *name = data[@"name"];
    NSString *fansCount = [NSString stringWithFormat:@"粉丝:%@", data[@"fansCount"]];
    
    
    self.nameLabel.text = name;
    [self.nameLabel sizeToFit];
    
    [self.avatarImageView loadImage:avatar];
    self.fansTextLabel.text = fansCount;
    [self.fansTextLabel sizeToFit];
    
    [self.followButton setTitle:@"关注" forState:UIControlStateNormal];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.avatarImageView.left = 0;
    self.avatarImageView.top = 0;
    
    self.nameLabel.left = 38;
    self.nameLabel.top = self.height/2-self.nameLabel.height;
    
    
    self.fansTextLabel.top = self.height/2;
    self.fansTextLabel.left = 38;
    
    self.followButton.left = self.width-self.followButton.width-6;
    self.followButton.centerY = self.height/2;
    
}

@end
