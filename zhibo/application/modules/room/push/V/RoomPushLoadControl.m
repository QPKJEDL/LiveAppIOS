//
//  KaiBoLoadingControl.m
//  zhibo
//
//  Created by qp on 2020/7/9.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RoomPushLoadControl.h"
@interface RoomPushLoadControl ()
@property (nonatomic, strong) UILabel *ttLabel;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) int daojiCount;
@end
@implementation RoomPushLoadControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.daojiCount = 3;
        self.ttLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        self.ttLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.ttLabel.layer.cornerRadius = 50;
        self.ttLabel.clipsToBounds = true;
        self.ttLabel.textAlignment = NSTextAlignmentCenter;
        self.ttLabel.textColor = [UIColor whiteColor];
        self.ttLabel.font = [UIFont PingFangSCBlod:50];
        [self addSubview:self.ttLabel];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFreq) userInfo:nil repeats:true];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        [self timerFreq];
    }
    return self;
}

- (void)timerFreq {
    [self.ttLabel setText:[NSString stringWithFormat:@"%i", self.daojiCount]];
    self.daojiCount--;
    if (self.daojiCount == -1) {
        [self.timer invalidate];
        [self.delegate controlOnFinish:self];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.ttLabel.centerX = self.width/2;
    self.ttLabel.centerY = self.height/2;
}
@end
