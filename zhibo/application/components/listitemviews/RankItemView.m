//
//  RankItemView.m
//  zhibo
//
//  Created by qp on 2020/7/28.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RankItemView.h"
@interface RankItemView ()
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) QMUIButton *meiliButton;
@property (nonatomic, strong) UIView *lineView;
@end
@implementation RankItemView

- (void)setupAdjustContents {
    self.backgroundColor = [UIColor whiteColor];
    
    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    self.numberLabel.font = [UIFont PingFangSCBlod:14];
    self.numberLabel.textColor = [UIColor hexColor:@"#333333"];
    [self addSubview:self.numberLabel];
    
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.iconImageView.layer.cornerRadius = 32/2;
    self.iconImageView.clipsToBounds = true;
    [self addSubview:self.iconImageView];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    self.nameLabel.font = [UIFont PingFangSCBlod:14];
    self.nameLabel.textColor = [UIColor hexColor:@"#333333"];
    [self addSubview:self.nameLabel];
    
    self.meiliButton = [[QMUIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    self.meiliButton.titleLabel.font = [UIFont PingFangSCBlod:14];
    self.meiliButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.meiliButton setTitleColor:[UIColor hexColor:@"#CA76D4"] forState:UIControlStateNormal];
    [self.meiliButton setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    [self.meiliButton setSpacingBetweenImageAndTitle:2];
    [self addSubview:self.meiliButton];
    [self.meiliButton setUserInteractionEnabled:false];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, self.width-30, 1)];
    self.lineView.backgroundColor = [UIColor hexColor:@"#F3F3F3"];
    [self addSubview:self.lineView];
}

- (void)layoutAdjustContents {
    self.numberLabel.left = 20;
    self.iconImageView.left = 47;
    
    self.numberLabel.centerY = self.height/2;
    self.iconImageView.centerY = self.height/2;
    
    self.lineView.top = self.height-1;
    
    self.nameLabel.left = 117;
    self.nameLabel.centerY = self.height/2;
    
    self.meiliButton.left = self.width-15-self.meiliButton.width;
    self.meiliButton.centerY = self.height/2;
}

- (void)reload:(NSDictionary *)item extra:(NSDictionary *)extra indexPath:(NSIndexPath *)indexPath {
    self.numberLabel.text = [item stringValueForKey:@"num"];
    
    self.nameLabel.text = item[@"nickname"];
    [self.nameLabel sizeToFit];
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:item[@"avatar"]] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    
    [self.meiliButton setTitle:item[@"cmoney"] forState:UIControlStateNormal];
}
@end
