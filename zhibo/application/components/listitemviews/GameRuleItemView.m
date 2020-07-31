//
//  GameRuleItemView.m
//  zhibo
//
//  Created by qp on 2020/7/28.
//  Copyright © 2020 qp. All rights reserved.
//

#import "GameRuleItemView.h"
@interface GameRuleItemView ()
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *arrowImageView;
@end
@implementation GameRuleItemView

- (void)setupAdjustContents {
    self.containView = [[UIView alloc] initWithFrame:CGRectInset(self.bounds, 10, 0)];
    [self addSubview:self.containView];
    self.containView.backgroundColor = [UIColor whiteColor];
    self.containView.layer.shadowColor = [UIColor colorWithRed:117/255.0 green:0/255.0 blue:28/255.0 alpha:0.11].CGColor;
    self.containView.layer.shadowOffset = CGSizeMake(0,0);
    self.containView.layer.shadowOpacity = 1;
    self.containView.layer.shadowRadius = 5;
    self.containView.layer.cornerRadius = 5.3;
    
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectInset(self.containView.bounds, 15, 0)];
    self.titleLabel.font = [UIFont PingFangMedium:15];
    self.titleLabel.textColor = [UIColor hexColor:@"#474747"];
    [self.containView addSubview:self.titleLabel];
    
    self.arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 8, 12)];
    [self.arrowImageView setImage:[UIImage imageNamed:@"huisefanhui"]];
    [self.containView addSubview:self.arrowImageView];
}

- (void)layoutAdjustContents {
    self.arrowImageView.left = self.containView.width-15-10;
    self.arrowImageView.centerY = self.containView.height/2;
}

- (void)reload:(NSDictionary *)item {
    self.titleLabel.text = item[@"title"];
}

@end
