//
//  SwitchItemView.m
//  zhibo
//
//  Created by qp on 2020/7/24.
//  Copyright © 2020 qp. All rights reserved.
//

#import "SwitchItemView.h"
@interface SwitchItemView ()
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UISwitch *switchView;
@end
@implementation SwitchItemView

- (void)setupAdjustContents {
    self.containView = [[UIView alloc] initWithFrame:self.bounds];
    self.containView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.containView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textColor = [UIColor hexColor:@"222222"];
    [self.containView addSubview:self.titleLabel];

    self.switchView = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 46, 28)];
    self.switchView.onTintColor = [UIColor hexColor:@"FF3483"];
    self.switchView.tintColor = [UIColor hexColor:@"f3f3f2"];
    self.switchView.backgroundColor = [UIColor whiteColor];
    [self.containView addSubview:self.switchView];
    self.switchView.transform = CGAffineTransformMakeScale(46/51.0, 28/31.0);
}

- (void)layoutAdjustContents {
    self.containView.frame = self.bounds;
    
    self.titleLabel.left = 15;
    self.titleLabel.centerY = self.height/2;
    
    self.switchView.left = self.containView.width-15-self.switchView.width;
    self.switchView.centerY = self.containView.height/2;
}

- (void)reload:(NSDictionary *)item {
    self.titleLabel.text = item[@"title"];
    [self.titleLabel sizeToFit];
}

@end
