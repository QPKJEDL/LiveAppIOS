//
//  BetResultView.m
//  zhibo
//
//  Created by qp on 2020/7/7.
//  Copyright © 2020 qp. All rights reserved.
//

#import "BetResultView.h"
@interface BetResultView ()
@property (nonatomic, strong) UIButton *titleButton;
@end
@implementation BetResultView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor hexColor:@"#1B3F41"] colorWithAlphaComponent:0.6];
        
        self.titleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 36)];
        self.titleButton.layer.cornerRadius = 36/2;
        self.titleButton.clipsToBounds = true;
        self.titleButton.layer.borderWidth = LINGDIANWU;
        self.titleButton.layer.borderColor = [UIColor whiteColor].CGColor;
        [self.titleButton setTitle:@"本局结果" forState:UIControlStateNormal];
        self.titleButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.titleButton setTitleColor:[UIColor hexColor:@"#26E2DE"] forState:UIControlStateNormal];
        [self addSubview:self.titleButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleButton.centerX = self.width/2;
    self.titleButton.top = 18;
}

@end
