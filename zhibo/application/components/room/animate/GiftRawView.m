//
//  GiftRawView.m
//  zhibo
//
//  Created by qp on 2020/7/13.
//  Copyright © 2020 qp. All rights reserved.
//

#import "GiftRawView.h"
@interface GiftRawView ()
@property (nonatomic, strong) UIView *userView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIImageView *giftImageView;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, assign) NSInteger num;

@property (nonatomic, assign) NSInteger giftid;
@property (nonatomic, assign) NSInteger userid;
@end
@implementation GiftRawView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isFree = true;
        
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 0, 46, 46)];
        self.iconImageView.layer.cornerRadius = 46/2;
        self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.iconImageView.clipsToBounds = true;
        

        self.userView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, 180, 50)];
        self.userView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [self addSubview:self.userView];
        self.userView.layer.cornerRadius = 25;
        [self.userView addSubview:self.iconImageView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.nameLabel.textColor = [UIColor hexColor:@"#FFFFFF"];
        self.nameLabel.font = [UIFont PingFangSCBlod:14];
        [self.userView addSubview:self.nameLabel];
        
        self.detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.detailLabel.textColor = [[UIColor hexColor:@"#FFFFFF"] colorWithAlphaComponent:0.8];
        self.detailLabel.font = [UIFont PingFangSC:12];
        [self.userView addSubview:self.detailLabel];
        
        self.giftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.userView.width-40-10, 5, 40, 40)];
        self.giftImageView.layer.cornerRadius = 15;
        self.giftImageView.clipsToBounds = true;
        [self.userView addSubview:self.giftImageView];
        
        self.numberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.numberLabel.textColor = [UIColor hexColor:@"#FFFFFF"];
        self.numberLabel.font = [UIFont PingFangSCBlod:25];
        [self addSubview:self.numberLabel];
    }
    return self;
}

- (BOOL)isRefresh:(NSDictionary *)dic {
    if (self.userid == [dic[@"UserId"] intValue]) {
        NSInteger gkey = [dic[@"gift"][@"id"] intValue];
        return (gkey == self.giftid) || self.giftid == -1;
    }
    
    return false;
    
}

- (void)showWithData:(NSDictionary *)data {
    self.giftid = [data[@"gift"][@"id"] intValue];
    self.userid = [data[@"UserId"] intValue];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(autohidden) withObject:nil afterDelay:3];
    
    [self.iconImageView sd_setImageWithURL:data[@"Avater"] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    self.nameLabel.text = data[@"UserNickname"];
    if (data[@"GiftNum"] != nil) {
        self.num = self.num+[data[@"GiftNum"] intValue];
    }
    self.numberLabel.text = [NSString stringWithFormat:@"x%li", (long)self.num];
    self.detailLabel.text = [NSString stringWithFormat:@"送出%@", data[@"gift"][@"giftname"]];
    [self.numberLabel shake];
    [self.nameLabel sizeToFit];
    self.nameLabel.width = 140;
    [self.detailLabel sizeToFit];
    [self.numberLabel sizeToFit];
    
    [self.giftImageView loadImage:data[@"gift"][@"imgurl"]];
    self.alpha = 1;
    self.isFree = false;
    [UIView animateWithDuration:0.1 animations:^{
        self.left = 0;
    } completion:^(BOOL finished) {
        
    }];

}

- (void)autohidden {
    self.alpha = 1;
    self.giftid = -1;
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.left = -self.width*2;
        self.isFree = true;
        [self.delegate giftRawViewFinish];
        self.num = 0;
    }];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.userView.centerY = self.height/2;
    self.iconImageView.centerY = self.userView.height/2;
    self.nameLabel.top = self.userView.height/2-self.nameLabel.height;
    self.detailLabel.top = self.nameLabel.bottom;
    self.nameLabel.left = self.iconImageView.right+5;
    self.detailLabel.left = self.iconImageView.right+5;
    self.numberLabel.left = self.userView.right+10;
    self.numberLabel.top = self.height-self.numberLabel.height;
}

@end
