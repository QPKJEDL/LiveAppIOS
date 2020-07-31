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
@property (nonatomic, strong) UILabel *touzhuLabel;

@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong) UILabel *betTimeTextLabel;
@property (nonatomic, strong) UILabel *betTimeLabel;

@property (nonatomic, strong) UILabel *betStatusLabel;
@property (nonatomic, strong) UILabel *betMMLabel;
@end
@implementation GameHistoryItemView

- (void)setupAdjustContents {
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
    
    self.touzhuLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.xiangxiLabel.bottom, self.containView.width-30, 30)];
    self.touzhuLabel.textColor = [UIColor hexColor:@"#474747"];
    self.touzhuLabel.font = [UIFont PingFangSC:12];
    [self.containView addSubview:self.touzhuLabel];
    
    self.bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-48, self.containView.width, 1)];
    self.bottomLine.backgroundColor = [UIColor colorWithRed:240/255.0 green:239/255.0 blue:242/255.0 alpha:1.0];
    [self.containView addSubview:self.bottomLine];
    
    
    
    CGFloat xxw = floor(self.containView.width/3);
    self.betTimeTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bottomLine.bottom, xxw, 20)];
    self.betTimeTextLabel.textColor = [UIColor hexColor:@"#9393AB"];
    self.betTimeTextLabel.text = @"时间";
    self.betTimeTextLabel.textAlignment = NSTextAlignmentCenter;
    self.betTimeTextLabel.font = [UIFont PingFangMedium:10];
    [self.containView addSubview:self.betTimeTextLabel];
    
    self.betTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.betTimeTextLabel.bottom, xxw, 20)];
    self.betTimeLabel.textColor = [UIColor hexColor:@"#474747"];
    self.betTimeLabel.textAlignment = NSTextAlignmentCenter;
    self.betTimeLabel.font = [UIFont PingFangSC:12];
    [self.containView addSubview:self.betTimeLabel];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(xxw, self.bottomLine.bottom+11, 1, 24)];
    lineView1.backgroundColor = [UIColor hexColor:@"#F0EFF2"];
    [self.containView addSubview:lineView1];
    
    //------
    UILabel *shuyingLabel = [[UILabel alloc] initWithFrame:CGRectMake(xxw, self.bottomLine.bottom, xxw, 20)];
    shuyingLabel.textColor = [UIColor hexColor:@"#9393AB"];
    shuyingLabel.text = @"输赢";
    shuyingLabel.textAlignment = NSTextAlignmentCenter;
    shuyingLabel.font = [UIFont PingFangMedium:10];
    [self.containView addSubview:shuyingLabel];
    
    self.betStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(xxw, self.betTimeTextLabel.bottom, xxw, 20)];
    self.betStatusLabel.textColor = [UIColor hexColor:@"#474747"];
    self.betStatusLabel.textAlignment = NSTextAlignmentCenter;
    self.betStatusLabel.font = [UIFont PingFangSC:12];
    [self.containView addSubview:self.betStatusLabel];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(xxw*2, self.bottomLine.bottom+11, 1, 24)];
    lineView2.backgroundColor = [UIColor hexColor:@"#F0EFF2"];
    [self.containView addSubview:lineView2];
    
    //-------
    
    UILabel *zhuangtaiLabel = [[UILabel alloc] initWithFrame:CGRectMake(xxw*2, self.bottomLine.bottom, xxw, 20)];
    zhuangtaiLabel.textColor = [UIColor hexColor:@"#9393AB"];
    zhuangtaiLabel.text = @"投注状态";
    zhuangtaiLabel.textAlignment = NSTextAlignmentCenter;
    zhuangtaiLabel.font = [UIFont PingFangMedium:10];
    [self.containView addSubview:zhuangtaiLabel];
    
    self.betMMLabel = [[UILabel alloc] initWithFrame:CGRectMake(xxw*2, self.betTimeTextLabel.bottom, xxw, 20)];
    self.betMMLabel.textColor = [UIColor hexColor:@"#474747"];
    self.betMMLabel.textAlignment = NSTextAlignmentCenter;
    self.betMMLabel.font = [UIFont PingFangSC:12];
    [self.containView addSubview:self.betMMLabel];
    
}

- (void)layoutAdjustContents {  
}

- (void)reload:(NSDictionary *)item {
    self.timeLabel.text = item[@"time"];
    self.zhudanLabel.text = item[@"number"];
    self.xiangxiLabel.text = item[@"detail"];
    self.touzhuLabel.text = item[@"money"];
    
    self.betTimeLabel.text = @"00:00:00";
    self.betStatusLabel.text = @"-100";
    self.betMMLabel.text = @"输";
}

@end
