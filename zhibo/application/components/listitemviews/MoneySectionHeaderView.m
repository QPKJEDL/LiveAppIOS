//
//  MoneySectionHeaderView.m
//  zhibo
//
//  Created by qp on 2020/7/21.
//  Copyright © 2020 qp. All rights reserved.
//

#import "MoneySectionHeaderView.h"
@interface MoneySectionHeaderView ()
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *titleLabel;
@end
@implementation MoneySectionHeaderView

- (void)setupAdjustContents {
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 3, 14)];
    self.lineView.backgroundColor = [UIColor hexColor:@"#FF3483"];
    self.lineView.layer.cornerRadius = 3/2;
    [self addSubview:self.lineView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width/2, self.height)];
    self.titleLabel.font = [UIFont PingFangSCBlod:15];
    self.titleLabel.textColor = [UIColor hexColor:@"333333"];
    [self addSubview:self.titleLabel];
}

- (void)layoutAdjustContents {
    self.lineView.left = 15;
    self.lineView.centerY = self.height/2;
    
    self.titleLabel.left = self.lineView.right+7;
    self.titleLabel.centerY = self.height/2;
}

- (void)reload:(NSDictionary *)item {
    self.titleLabel.text = item[@"title"];
}

@end
