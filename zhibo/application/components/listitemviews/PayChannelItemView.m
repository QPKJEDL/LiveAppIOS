//
//  CashoutItemView.m
//  zhibo
//
//  Created by qp on 2020/7/20.
//  Copyright © 2020 qp. All rights reserved.
//

#import "PayChannelItemView.h"
@interface PayChannelItemView ()
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *checkBoxImageView;
@end
@implementation PayChannelItemView

- (void)setupAdjustContents {
    self.containView = [[UIView alloc] initWithFrame:CGRectInset(self.bounds, 15, 5)];
    self.containView.backgroundColor = [UIColor whiteColor];
    self.containView.layer.shadowColor = [UIColor colorWithRed:88/255.0 green:85/255.0 blue:217/255.0 alpha:0.1].CGColor;
    self.containView.layer.shadowOffset = CGSizeMake(0,7);
    self.containView.layer.shadowOpacity = 1;
    self.containView.layer.shadowRadius = 10;
    self.containView.layer.cornerRadius = 4.8;
    [self addSubview:self.containView];
    
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 23, 23)];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.containView addSubview:self.iconImageView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.font = [UIFont PingFangSC:15];
    self.titleLabel.textColor = [UIColor hexColor:@"#333333"];
    [self.containView addSubview:self.titleLabel];
    
    self.checkBoxImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    self.checkBoxImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.containView addSubview:self.checkBoxImageView];
}


- (void)layoutAdjustContents {
    self.iconImageView.centerY = self.containView.height/2;
    self.iconImageView.left = 15;
    self.titleLabel.left = self.iconImageView.right+10;
    self.titleLabel.centerY = self.containView.height/2;
    
    self.checkBoxImageView.left = self.containView.width-15-self.checkBoxImageView.width;
    self.checkBoxImageView.centerY = self.containView.height/2;
}

- (void)reload:(NSDictionary *)item extra:(NSDictionary *)extra indexPath:(NSIndexPath *)indexPath {
    [self.iconImageView loadImage:item[@"icon"]];
    self.titleLabel.text = item[@"title"];
    [self.titleLabel sizeToFit];
    
    if ([extra[@"selected"] intValue] == 1) {
        [self.checkBoxImageView setImage:[UIImage imageNamed:@"cb_xuan"]];
    }else{
        [self.checkBoxImageView setImage:[UIImage imageNamed:@"cb_quan"]];
    }
}

@end
