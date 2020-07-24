//
//  NoticeItemView.m
//  zhibo
//
//  Created by qp on 2020/7/11.
//  Copyright © 2020 qp. All rights reserved.
//

#import "NoticeItemView.h"
@interface NoticeItemView ()
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@end
@implementation NoticeItemView

- (void)setupAdjustContents {
    
    self.containView = [[UIView alloc] initWithFrame:CGRectInset(self.bounds, 10, 3)];
    self.containView.backgroundColor = [UIColor whiteColor];
    self.containView.layer.cornerRadius = 5;
    self.containView.clipsToBounds = true;
    [self addSubview:self.containView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 14, self.containView.width-32, 20)];
    self.titleLabel.font = [UIFont PingFangMedium:14];
    self.titleLabel.textColor = [UIColor hexColor:@"#333333"];
    [self.containView addSubview:self.titleLabel];
    
    self.detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, self.titleLabel.bottom, self.containView.width-32, 10)];
    self.detailLabel.font = [UIFont PingFangMedium:11];
    self.detailLabel.textColor = [UIColor hexColor:@"#9F9F9F"];
    self.detailLabel.numberOfLines = 0;
    [self.containView addSubview:self.detailLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.timeLabel.font = [UIFont PingFangMedium:12];
    self.timeLabel.textColor = [UIColor hexColor:@"#6A6A6A"];
    [self.containView addSubview:self.timeLabel];
}

- (void)reload:(NSDictionary *)item {
    self.titleLabel.text = item[@"title"];
    [self.titleLabel sizeToFit];
    
    self.detailLabel.text = item[@"content"];
    self.detailLabel.height = [item[@"h"] floatValue];
    
    self.timeLabel.text = item[@"time"];
    [self.timeLabel sizeToFit];
    
    [self layoutAdjustContents];
}

- (void)layoutAdjustContents {
    self.timeLabel.left = self.containView.width-self.timeLabel.width-15;
    self.timeLabel.centerY = self.titleLabel.centerY;
}

@end
