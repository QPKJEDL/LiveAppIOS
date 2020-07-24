//
//  GiftHistoryItemView.m
//  zhibo
//
//  Created by qp on 2020/7/20.
//  Copyright © 2020 qp. All rights reserved.
//

#import "GiftHistoryItemView.h"
@interface GiftHistoryItemView ()
@property (nonatomic, strong) UIImageView *giftImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@end
@implementation GiftHistoryItemView


- (void)setupAdjustContents {
    self.backgroundColor = [UIColor whiteColor];
    self.giftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    self.giftImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.giftImageView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.font = [UIFont PingFangSC:13];
    self.titleLabel.textColor = [UIColor hexColor:@"#343434"];
    [self addSubview:self.titleLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.timeLabel.font = [UIFont PingFangSC:10];
    self.timeLabel.textColor = [UIColor hexColor:@"#A8A8A8"];
    [self addSubview:self.timeLabel];
}

- (void)layoutAdjustContents {
    self.giftImageView.centerY = self.height/2;
    self.giftImageView.left = self.width-15-self.giftImageView.width;
    
    self.titleLabel.left = 15;
    self.titleLabel.top = self.height/2-self.titleLabel.height;
    
    self.timeLabel.left = 15;
    self.timeLabel.top = self.titleLabel.bottom+5;
}

- (void)reload:(NSDictionary *)item {
    [self.giftImageView loadImage:item[@"gift"][@"imgurl"]];

    self.titleLabel.text = item[@"text"];
    [self.titleLabel sizeToFit];
    
    self.timeLabel.text = item[@"time"];
    [self.timeLabel sizeToFit];
}



@end
