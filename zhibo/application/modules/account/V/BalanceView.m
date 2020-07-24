//
//  BalanceView.m
//  zhibo
//
//  Created by FaiWong on 2020/4/25.
//  Copyright © 2020 qp. All rights reserved.
//

#import "BalanceView.h"

@interface BalanceView ()
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@end
@implementation BalanceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self gradient:GRADIENTCOLORS direction:0];
        self.backgroundColor = [UIColor hexColor:@"00BFCB"];
        self.layer.cornerRadius = 10;
        self.clipsToBounds = true;
        
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.font = [UIFont PingFangSCBlod:35];
        [self addSubview:self.textLabel];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.titleLabel.text = @"直播币";
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont PingFangMedium:13];
        [self addSubview:self.titleLabel];
        [self.titleLabel sizeToFit];
        self.titleLabel.centerX = self.width/2;
        self.titleLabel.top = 85;
    }
    return self;
}
- (void)reload:(NSDictionary *)data {
    self.textLabel.text = [NSString stringWithFormat:@"%@", data[@"info"]];
    [self.textLabel sizeToFit];
    self.textLabel.centerX = self.width/2;
    self.textLabel.top = 39;
   
}

@end
