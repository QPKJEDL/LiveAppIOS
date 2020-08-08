//
//  GameHistoryItemView.m
//  zhibo
//
//  Created by qp on 2020/7/28.
//  Copyright © 2020 qp. All rights reserved.
//

#import "GameHistoryItemView.h"
@interface GameHistoryItemView ()
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *zhudanLabel;
@property (nonatomic, strong) UILabel *xiangxiLabel;
@property (nonatomic, strong) UILabel *touzhuTextLabel;
@property (nonatomic, strong) UILabel *touzhuLabel;

@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong) UILabel *betTimeTextLabel;
@property (nonatomic, strong) UILabel *betTimeLabel;

@property (nonatomic, strong) UILabel *betStatusLabel;
@property (nonatomic, strong) UILabel *betMMLabel;
@property (nonatomic, strong) UIView *bottomView;
@end
@implementation GameHistoryItemView

- (void)setupAdjustContents {
    self.clipsToBounds = true;
    self.containView = [[UIView alloc] initWithFrame:CGRectInset(self.bounds, 10, 0)];
    self.containView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.containView];
    self.containView.layer.shadowColor = [UIColor colorWithRed:117/255.0 green:0/255.0 blue:28/255.0 alpha:0.11].CGColor;
    self.containView.layer.shadowOffset = CGSizeMake(0,0);
    self.containView.layer.shadowOpacity = 1;
    self.containView.layer.shadowRadius = 5;
    self.containView.layer.cornerRadius = 3.3;
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.containView.width-30, 30)];
    self.timeLabel.textColor = [UIColor hexColor:@"#474747"];
    self.timeLabel.font = [UIFont PingFangSC:12];
    [self.containView addSubview:self.timeLabel];
    
    self.topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 30, self.containView.width, 1)];
    self.topLine.backgroundColor = [UIColor colorWithRed:240/255.0 green:239/255.0 blue:242/255.0 alpha:1.0];
    [self.containView addSubview:self.topLine];
    
    self.zhudanLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.topLine.bottom, self.containView.width-30, 30)];
    self.zhudanLabel.textColor = [UIColor hexColor:@"#474747"];
    self.zhudanLabel.font = [UIFont PingFangSC:12];
    [self.containView addSubview:self.zhudanLabel];
    
    self.xiangxiLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.zhudanLabel.bottom, self.containView.width-30, 30)];
    self.xiangxiLabel.textColor = [UIColor hexColor:@"#474747"];
    self.xiangxiLabel.font = [UIFont PingFangSC:12];
    [self.containView addSubview:self.xiangxiLabel];
    
    self.touzhuTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.xiangxiLabel.bottom+5, self.containView.width-30, 30)];
    self.touzhuTextLabel.textColor = [UIColor hexColor:@"#474747"];
    self.touzhuTextLabel.font = [UIFont PingFangSC:12];
    self.touzhuTextLabel.text = @"投注金额：";
    [self.containView addSubview:self.touzhuTextLabel];
    [self.touzhuTextLabel sizeToFit];
    
    self.touzhuLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.touzhuTextLabel.right, self.xiangxiLabel.bottom+5, self.containView.width-15-self.touzhuTextLabel.right, 30)];
    self.touzhuLabel.textColor = [UIColor hexColor:@"#474747"];
    self.touzhuLabel.font = [UIFont PingFangSC:12];
    self.touzhuLabel.numberOfLines = 0;
    [self.containView addSubview:self.touzhuLabel];
    
//    self.bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-48, self.containView.width, 1)];
//    self.bottomLine.backgroundColor = [UIColor colorWithRed:240/255.0 green:239/255.0 blue:242/255.0 alpha:1.0];
//    [self.containView addSubview:self.bottomLine];
    
    
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-48, self.containView.width, 48)];
    [self.bottomView addLineDirection:LineDirectionTop color: [UIColor colorWithRed:240/255.0 green:239/255.0 blue:242/255.0 alpha:1.0] width:LINGDIANWU];
    [self addSubview:self.bottomView];
    
    CGFloat xxw = floor(self.containView.width/3);
    self.betTimeTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, xxw, 20)];
    self.betTimeTextLabel.textColor = [UIColor hexColor:@"#9393AB"];
    self.betTimeTextLabel.text = @"时间";
    self.betTimeTextLabel.textAlignment = NSTextAlignmentCenter;
    self.betTimeTextLabel.font = [UIFont PingFangMedium:10];
    [self.bottomView addSubview:self.betTimeTextLabel];
    
    self.betTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, xxw, 20)];
    self.betTimeLabel.textColor = [UIColor hexColor:@"#474747"];
    self.betTimeLabel.textAlignment = NSTextAlignmentCenter;
    self.betTimeLabel.font = [UIFont PingFangSC:12];
    [self.bottomView addSubview:self.betTimeLabel];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(xxw, 11, 1, 24)];
    lineView1.backgroundColor = [UIColor hexColor:@"#F0EFF2"];
    [self.bottomView addSubview:lineView1];
    
    //------
    UILabel *shuyingLabel = [[UILabel alloc] initWithFrame:CGRectMake(xxw, 0, xxw, 20)];
    shuyingLabel.textColor = [UIColor hexColor:@"#9393AB"];
    shuyingLabel.text = @"输赢";
    shuyingLabel.textAlignment = NSTextAlignmentCenter;
    shuyingLabel.font = [UIFont PingFangMedium:10];
    [self.bottomView addSubview:shuyingLabel];
    
    self.betStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(xxw, self.betTimeTextLabel.bottom, xxw, 20)];
    self.betStatusLabel.textColor = [UIColor hexColor:@"#474747"];
    self.betStatusLabel.textAlignment = NSTextAlignmentCenter;
    self.betStatusLabel.font = [UIFont PingFangSC:12];
    [self.bottomView addSubview:self.betStatusLabel];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(xxw*2, 11, 1, 24)];
    lineView2.backgroundColor = [UIColor hexColor:@"#F0EFF2"];
    [self.bottomView addSubview:lineView2];
    
    //-------
    
    UILabel *zhuangtaiLabel = [[UILabel alloc] initWithFrame:CGRectMake(xxw*2, 0, xxw, 20)];
    zhuangtaiLabel.textColor = [UIColor hexColor:@"#9393AB"];
    zhuangtaiLabel.text = @"投注状态";
    zhuangtaiLabel.textAlignment = NSTextAlignmentCenter;
    zhuangtaiLabel.font = [UIFont PingFangMedium:10];
    [self.bottomView addSubview:zhuangtaiLabel];
    
    self.betMMLabel = [[UILabel alloc] initWithFrame:CGRectMake(xxw*2, self.betTimeTextLabel.bottom, xxw, 20)];
    self.betMMLabel.textColor = [UIColor hexColor:@"#474747"];
    self.betMMLabel.textAlignment = NSTextAlignmentCenter;
    self.betMMLabel.font = [UIFont PingFangSC:12];
    [self.bottomView addSubview:self.betMMLabel];
    
}

- (void)layoutAdjustContents {
    self.containView.frame = CGRectInset(self.bounds, 10, 0);
    self.bottomView.top = self.height-48;
}

- (void)reload:(NSDictionary *)item {
    self.timeLabel.text = [NSString stringWithFormat:@"日期：%@", item[@"date"]];
    self.zhudanLabel.text = [NSString stringWithFormat:@"下注单号：%@", item[@"order_sn"]];
    self.xiangxiLabel.text = [NSString stringWithFormat:@"详细注单：%@", item[@"detail"]];
    self.touzhuLabel.text = [NSString stringWithFormat:@"%@", item[@"betStr"]];
    
    self.betTimeLabel.text = item[@"time"];
    self.betStatusLabel.text = item[@"gmoney"];
    self.betMMLabel.text = item[@"statusStr"];
    
    self.touzhuLabel.height = [item[@"betStrHeight"] floatValue];
}

@end
