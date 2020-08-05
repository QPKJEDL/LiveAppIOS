//
//  PopularizeCodeItemView.m
//  zhibo
//
//  Created by qp on 2020/8/4.
//  Copyright © 2020 qp. All rights reserved.
//

#import "PopularizeCodeItemView.h"
#import "TeamLowerItemView.h"
@interface PopularizeCodeItemView ()
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) TeamTextItem *itemA;
@property (nonatomic, strong) TeamTextItem *itemB;

@property (nonatomic, strong) QMUIButton *qrcodeButton;
@end
@implementation PopularizeCodeItemView

- (void)setupAdjustContents {
    self.backgroundColor = [UIColor whiteColor];
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    self.timeLabel.font = [UIFont PingFangSC:10];
    self.timeLabel.textColor = [UIColor hexColor:@"#A8A8A8"];
    [self addSubview:self.timeLabel];

    self.itemA = [[TeamTextItem alloc] initWithFrame:CGRectMake(0, 0, 92, 50)];
    self.itemA.bLabel.text = @"已邀请数";
    [self addSubview:self.itemA];
    
    self.itemB = [[TeamTextItem alloc] initWithFrame:CGRectMake(0, 0, 92, 50)];
    self.itemB.bLabel.text = @"返点率";
    [self addSubview:self.itemB];
    
    self.qrcodeButton = [[QMUIButton alloc] initWithFrame:CGRectMake(0, 0, 43, 43)];
    self.qrcodeButton.layer.cornerRadius = 22;
    [self.qrcodeButton setTitle:@"二维码" forState:UIControlStateNormal];
    [self addSubview:self.qrcodeButton];
    [self.qrcodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.qrcodeButton.backgroundColor = [UIColor hexColor:@"#FF2B2B"];
    self.qrcodeButton.titleLabel.font = [UIFont PingFangSC:11];
    self.qrcodeButton.clipsToBounds = true;
    
}

- (void)layoutAdjustContents {
    self.timeLabel.centerY = self.height/2;
    self.timeLabel.left = 15;
    
    self.contentLabel.left = self.width-self.contentLabel.width-15;
    self.contentLabel.centerY = self.height/2;
    
    self.itemA.left = self.timeLabel.right;
    self.itemA.centerY = self.height/2;
    
    self.itemB.left = self.itemA.right;
    self.itemB.centerY = self.height/2;
    
    self.qrcodeButton.left = self.width-15-self.qrcodeButton.width;
    self.qrcodeButton.centerY = self.height/2;
}

- (void)reload:(NSDictionary *)item {
    self.timeLabel.text = @"2020-01-01 00:00:00";
    [self.timeLabel sizeToFit];
    self.contentLabel.text = item[@"content"];
    
    self.itemA.aLabel.text = @"0";
    self.itemB.aLabel.text = @"0";
    
}

@end
