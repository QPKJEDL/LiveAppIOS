//
//  ChargeHistoryItemView.m
//  zhibo
//
//  Created by qp on 2020/7/30.
//  Copyright © 2020 qp. All rights reserved.
//

#import "ChargeHistoryItemView.h"
@interface ChargeHistoryItemView ()
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@end
@implementation ChargeHistoryItemView
+ (void)load {
    [[ABUIListViewMapping shared] registerClassString:@"chargeitem" native_id:[[self class] description]];
}

- (void)setupAdjustContents {
    self.backgroundColor = [UIColor whiteColor];
    self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self addSubview:self.moneyLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.timeLabel.textColor = [UIColor hexColor:@"999999"];
    self.timeLabel.font = [UIFont PingFangSC:12];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.timeLabel];
}

- (void)layoutAdjustContents {
    self.moneyLabel.left = 15;
    self.moneyLabel.centerY = self.height/2;
    
    self.timeLabel.left = self.width-15-self.timeLabel.width;
    self.timeLabel.centerY = self.height/2;
}

- (void)reload:(NSDictionary *)item {
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@", item[@"money"]];
    [self.moneyLabel sizeToFit];
    
    self.timeLabel.text = [ABTime timestampToTime:item[@"creatime"] format:nil];
    [self.timeLabel sizeToFit];
    
    [self layoutAdjustContents];
}

@end
