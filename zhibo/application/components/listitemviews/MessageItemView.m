//
//  MessageItemView.m
//  zhibo
//
//  Created by qp on 2020/7/11.
//  Copyright © 2020 qp. All rights reserved.
//

#import "MessageItemView.h"
@interface MessageItemView ()
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@end
@implementation MessageItemView
- (void)setupAdjustContents {
    self.containView = [[UIView alloc] initWithFrame:CGRectInset(self.bounds, 10, 4)];
    self.containView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.containView];
    
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 17, 47, 47)];
    self.iconImageView.backgroundColor = [UIColor hexColor:@"dedede"];
    self.iconImageView.layer.cornerRadius = 48/2;
    self.iconImageView.clipsToBounds = true;
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.containView addSubview:self.iconImageView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.subTitleLabel.font = [UIFont PingFangMedium:14];
    self.subTitleLabel.textColor = [UIColor hexColor:@"#333333"];
    [self.containView addSubview:self.titleLabel];
    
    self.subTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.subTitleLabel.font = [UIFont PingFangMedium:12];
    self.subTitleLabel.textColor = [UIColor hexColor:@"#9F9F9F"];
    [self.containView addSubview:self.subTitleLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.timeLabel.font = [UIFont PingFangMedium:12];
    self.timeLabel.textColor = [UIColor hexColor:@"#6A6A6A"];
    [self.containView addSubview:self.timeLabel];
}

- (void)reload:(NSDictionary *)item {
    self.titleLabel.text = item[@"title"];
    [self.titleLabel sizeToFit];
    self.titleLabel.width = SCREEN_WIDTH*0.4;
    
    self.subTitleLabel.text = item[@"content"];
    [self.subTitleLabel sizeToFit];
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:item[@"icon"]] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    
    
//    self.titleLabel.text = item[@"title"];
//    self.subTitleLabel.text = item[@""]
    self.timeLabel.text = item[@"time"];
    [self.timeLabel sizeToFit];
}

- (void)layoutAdjustContents {
    self.iconImageView.centerY = self.containView.height/2;
    self.titleLabel.left = 81;
    self.subTitleLabel.left = 81;
    self.titleLabel.top = self.containView.height/2-self.titleLabel.height-3;
    self.subTitleLabel.top = self.containView.height/2+3;
    self.timeLabel.left = self.containView.width-self.timeLabel.width-15;
    self.timeLabel.centerY = self.titleLabel.centerY;
}

@end
