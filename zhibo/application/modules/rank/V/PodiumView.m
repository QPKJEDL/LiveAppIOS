//
//  PodiumView.m
//  zhibo
//
//  Created by qp on 2020/7/28.
//  Copyright © 2020 qp. All rights reserved.
//

#import "PodiumView.h"
@interface PodiumView ()
@property (nonatomic, strong) UIImageView *taiImageView;
@property (nonatomic, strong) UIImageView *guanImageView;
@property (nonatomic, strong) UILabel *nickNameLabel;
@property (nonatomic, strong) QMUIButton *moneyButton;
@end

@implementation PodiumView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.taiImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.taiImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.taiImageView];
        
        self.guanImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
        self.guanImageView.clipsToBounds = true;
        self.guanImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.guanImageView.backgroundColor = [UIColor hexColor:@""];
        [self addSubview:self.guanImageView];
        
    }
    return self;
}

- (UIImageView *)avatarImageView {
    if (_avatarImageView == nil) {
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
        _avatarImageView.clipsToBounds = true;
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        _avatarImageView.backgroundColor = [UIColor redColor];
        [self addSubview:_avatarImageView];
    }
    return _avatarImageView;
}

- (UILabel *)nickNameLabel {
    if (_nickNameLabel == nil) {
        _nickNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nickNameLabel.backgroundColor = [UIColor hexColor:@"#CA76D4"];
        _nickNameLabel.textColor = [UIColor whiteColor];
        _nickNameLabel.font = [UIFont PingFangMedium:12];
        _nickNameLabel.textAlignment = NSTextAlignmentCenter;
        _nickNameLabel.layer.cornerRadius = 9;
        _nickNameLabel.clipsToBounds = true;
        [self addSubview:_nickNameLabel];
    }
    return _nickNameLabel;
}

- (QMUIButton *)moneyButton {
    if (_moneyButton == nil) {
        _moneyButton = [[QMUIButton alloc] initWithFrame:CGRectMake(0, 0, self.width, 20)];
        [_moneyButton setImage:[UIImage imageNamed:@"jinbi2"] forState:UIControlStateNormal];
        _moneyButton.titleLabel.font = [UIFont PingFangMedium:13];
        [_moneyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:_moneyButton];
    }
    return _moneyButton;
}

- (void)clear {
    [self.moneyButton setHidden:true];
    [self.nickNameLabel setHidden:true];
    [self.avatarImageView setHidden:true];
    [self.guanImageView setHidden:true];
}

- (void)render {
    
}

- (void)renderFirst { //第一名
    
}

- (void)renderSecond { //第二名
    
}

- (void)renderThird { //第三名
    
}

- (void)setData:(NSDictionary *)data {
    [self.moneyButton setHidden:false];
    [self.nickNameLabel setHidden:false];
    [self.avatarImageView setHidden:false];
    [self.guanImageView setHidden:false];
    NSInteger mc = [data[@"num"] intValue];
    NSString *avatar = data[@"avatar"];
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:avatar] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    
    self.nickNameLabel.text = data[@"nickname"];
    [self.nickNameLabel sizeToFit];
    self.nickNameLabel.width = self.width-40;
    self.nickNameLabel.height = 18;
    self.nickNameLabel.centerX = self.width/2;
    
    if (mc == 1) {
        self.avatarImageView.width = 90;
        self.avatarImageView.height = 90;
        self.avatarImageView.layer.borderWidth = 2;
        self.avatarImageView.layer.borderColor = [UIColor hexColor:@"#FCD012"].CGColor;
        
        self.guanImageView.width = 33;
        self.guanImageView.height = 33;
        self.guanImageView.image = [UIImage imageNamed:@"huangs"];
        
        self.nickNameLabel.top = self.height-54-18;
    }
    else if (mc == 2) {
        self.avatarImageView.width = 66;
        self.avatarImageView.height = 66;
        self.avatarImageView.layer.borderWidth = 2;
        self.avatarImageView.layer.borderColor = [UIColor hexColor:@"#C5D3E3"].CGColor;
        
        self.guanImageView.width = 28;
        self.guanImageView.height = 28;
        self.guanImageView.image = [UIImage imageNamed:@"yinse"];
        
        self.nickNameLabel.top = self.height-29-18;
    }
    else if (mc == 3) {
        self.avatarImageView.width = 55;
        self.avatarImageView.height = 55;
        self.avatarImageView.layer.borderWidth = 2;
        self.avatarImageView.layer.borderColor = [UIColor hexColor:@"#F9A771"].CGColor;
        
        self.guanImageView.width = 24;
        self.guanImageView.height = 24;
        self.guanImageView.image = [UIImage imageNamed:@"tongse"];
        
        self.nickNameLabel.top = self.height-24-18;
    }
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.height/2;
    self.avatarImageView.centerX = self.width/2;
    self.avatarImageView.top = self.taiImageView.top-self.avatarImageView.height;
    
    self.nickNameLabel.top = self.avatarImageView.bottom+20;
    
    self.guanImageView.left = self.avatarImageView.left-self.guanImageView.width/2+floor(self.guanImageView.width/3);
    self.guanImageView.top = self.avatarImageView.top-self.guanImageView.width/2;
    
    CGFloat money = [data[@"money"] floatValue]/100;
    [self.moneyButton setTitle:[NSString stringWithFormat:@"%.2f", money] forState:UIControlStateNormal];
    self.moneyButton.top = self.nickNameLabel.bottom;

    
}

- (void)setTaiImageName:(NSString *)imageName mc:(NSInteger)mc {
    UIImage *im = [UIImage imageNamed:imageName];
    self.taiImageView.frame = CGRectMake(0, self.height-im.size.height, im.size.width, im.size.height);
    self.taiImageView.image = im;
    self.width = im.size.width;
    
}



@end
