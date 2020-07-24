//
//  BetCoinCell.m
//  zhibo
//
//  Created by qp on 2020/6/22.
//  Copyright © 2020 qp. All rights reserved.
//

#import "BetCoinCell.h"
@interface BetCoinCell()
@property (nonatomic, strong) UIImageView *yunImageView;
@end
@implementation BetCoinCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.yunImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.yunImageView.layer.cornerRadius = self.width/2;
        self.yunImageView.clipsToBounds = true;
        [self addSubview:self.yunImageView];
        self.yunImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        self.yunImageView.layer.borderWidth = 2;
        
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        self.iconImageView.layer.cornerRadius = 22;
        self.iconImageView.clipsToBounds = true;
        [self addSubview:self.iconImageView];
    }
    return self;
}

- (void)reload:(NSDictionary *)data {
    int selected = [data[@"selected"] intValue];
    NSString *imageName = data[@"icon"];
    [self.iconImageView setImage:[UIImage imageNamed:imageName]];
    
    if (selected == 1) {
        [self.yunImageView setHidden:false];
    }else{
        [self.yunImageView setHidden:true];
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.iconImageView.center = CGPointMake(self.width/2, self.height/2);
    self.yunImageView.center = CGPointMake(self.width/2, self.height/2);
}
@end
