//
//  MineNavView.m
//  zhibo
//
//  Created by FaiWong on 2020/4/25.
//  Copyright © 2020 qp. All rights reserved.
//

#import "MineNavView.h"
@interface MineNavView ()

@end

@implementation MineNavView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.cameraButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
//        [self.cameraButton setImage:[UIImage imageNamed:@"sheying"] forState:UIControlStateNormal];
//        [self addSubview:self.cameraButton];
        
        self.settingButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [self.settingButton setImage:[UIImage imageNamed:@"shezhi"] forState:UIControlStateNormal];
        [self addSubview:self.settingButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.settingButton.left = self.width-self.settingButton.width-5;
    self.cameraButton.left = self.settingButton.left-self.cameraButton.width;
}

@end
