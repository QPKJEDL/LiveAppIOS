//
//  GiftItemView.m
//  zhibo
//
//  Created by qp on 2020/7/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import "GiftItemView.h"
@interface GiftItemView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@end
@implementation GiftItemView

- (void)setupAdjustContents {
    self.backgroundColor = [UIColor clearColor];
    
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 34, 34)];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.iconImageView];
    
    self.titleLabel = [[QMUILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 10)];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:9];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
    
    self.priceLabel = [[QMUILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 10)];
    self.priceLabel.textColor = [[UIColor hexColor:@"#F9F9F9"] colorWithAlphaComponent:0.7];
    self.priceLabel.font = [UIFont systemFontOfSize:8];
    self.priceLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.priceLabel];
}

- (void)reload:(NSDictionary *)item {
    NSString *name = item[@"giftname"];
    self.titleLabel.text = name;
    
    NSInteger price = [item[@"price"] integerValue];
    self.priceLabel.text = [NSString stringWithFormat:@"%ld金币", (long)price];
    
    [self.iconImageView loadImage:item[@"imgurl"]];
}

- (void)layoutAdjustContents {
    self.iconImageView.centerX = self.width/2;
    CGFloat top = (self.height-self.iconImageView.height-20)/2;
    self.iconImageView.top = top;
    self.titleLabel.top = self.iconImageView.bottom+2;
    self.priceLabel.top = self.titleLabel.bottom+2;
}
@end
