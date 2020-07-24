//
//  titleViewView.m
//  zhibo
//
//  Created by qp on 2020/7/9.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RoomPushReadyTitleView.h"
@interface RoomPushReadyTitleView ()
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) QMUITextField *textField;

@property (nonatomic, strong) UIButton *tipButton;
@property (nonatomic, strong) UIButton *chButton;
@end
@implementation RoomPushReadyTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(9, 12, 72, 72)];
        self.coverImageView.backgroundColor = [UIColor hexColor:@"#1B3F41"];
        self.coverImageView.clipsToBounds = true;
        self.coverImageView.layer.cornerRadius = 5;
        self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.coverImageView loadImage:[Service shared].account.avatar];
        [self addSubview:self.coverImageView];
//        [self.coverImageView addTarget:self action:@selector(onCover) forControlEvents:UIControlEventTouchUpInside];
        
        self.textField = [[QMUITextField alloc] initWithFrame:CGRectMake(self.coverImageView.right+15, 12, self.width-self.coverImageView.right-15, 40)];
        self.textField.placeholder = @"请输入您的标题";
        self.textField.textColor = [UIColor whiteColor];
        self.textField.placeholderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
        [self addSubview:self.textField];
        
        self.tipButton = [[UIButton alloc] initWithFrame:CGRectMake(self.textField.left, self.textField.bottom+20, 73, 22)];
        [self.tipButton setTitle:@"+话题标签" forState:UIControlStateNormal];
        [self.tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.tipButton.titleLabel.font = [UIFont PingFangSC:12];
        [self.tipButton addTarget:self action:@selector(onTipButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.tipButton];
        
        self.chButton = [[UIButton alloc] initWithFrame:CGRectMake(self.tipButton.left, self.tipButton.bottom+10, 73, 22)];
        [self.chButton setTitle:@"+频道选择" forState:UIControlStateNormal];
        [self.chButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.chButton.titleLabel.font = [UIFont PingFangSC:12];
        [self.chButton addTarget:self action:@selector(onChanenl) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.chButton];
        self.chButton.layer.cornerRadius = 11;
        self.chButton.layer.borderColor = [UIColor whiteColor].CGColor;
        self.chButton.layer.borderWidth = 1;
        
        self.tipButton.layer.cornerRadius = 11;
        self.tipButton.layer.borderColor = [UIColor whiteColor].CGColor;
        self.tipButton.layer.borderWidth = 1;
        
        
        [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:[Service shared].account.avatar] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
        
    }
    return self;
}

- (void)onCover {
    if (self.delegate && [self.delegate respondsToSelector:@selector(titleViewOnCover:)]) {
        [self.delegate titleViewOnCover:self];
    }
}

- (void)setLabel:(NSString *)label {
    _label = label;
    [self.tipButton setTitle:label forState:UIControlStateNormal];
    [self.tipButton sizeToFit];
    self.tipButton.width = self.tipButton.width+20;
    self.tipButton.height = 22;
}

- (void)setCover:(UIImage *)cover {
    _cover = cover;
    self.coverImageView.image = cover;
}

- (void)setChannel:(NSString *)channel {
    _channel = channel;
    [self.chButton setTitle:channel forState:UIControlStateNormal];
    [self.chButton sizeToFit];
    self.chButton.width = self.chButton.width+20;
    self.chButton.height = 22;
}

- (void)onTipButton {
    if (self.delegate && [self.delegate respondsToSelector:@selector(titleViewOnTip:)]) {
        [self.delegate titleViewOnTip:self];
    }
}

- (void)onChanenl {
    if (self.delegate && [self.delegate respondsToSelector:@selector(titleViewOnChannel:)]) {
        [self.delegate titleViewOnChannel:self];
    }
}

- (NSString *)title {
    return self.textField.text;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

@end
