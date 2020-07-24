//
//  LiveLabelItemView.m
//  zhibo
//
//  Created by qp on 2020/7/9.
//  Copyright © 2020 qp. All rights reserved.
//

#import "TopicItemView.h"
@interface TopicItemView ()
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) QMUILabel *titleLabel;
@property (nonatomic, strong) QMUILabel *heatLabel;
@property (nonatomic, strong) QMUIButton *canyuButton;
@end
@implementation TopicItemView

- (void)setupAdjustContents {
    self.backgroundColor = [UIColor clearColor];
    self.containView = [[UIView alloc] initWithFrame:self.bounds];
    self.containView.clipsToBounds = true;
    [self addSubview:self.containView];
    
    self.titleLabel = [[QMUILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [self addSubview:self.titleLabel];
    
    self.heatLabel = [[QMUILabel alloc] initWithFrame:CGRectZero];
    self.heatLabel.textColor = [UIColor hexColor:@"#A5A5A5"];
    self.heatLabel.font = [UIFont systemFontOfSize:12];
    self.heatLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [self addSubview:self.heatLabel];
    
    self.canyuButton = [[QMUIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 26)];
    [self.canyuButton setTitle:@"参与" forState:UIControlStateNormal];
    self.canyuButton.titleLabel.font = [UIFont PingFangSC:12];
    [self.canyuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.canyuButton.layer.cornerRadius = 13;
    self.canyuButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.canyuButton.layer.borderWidth = 1;
    [self.canyuButton addTarget:self action:@selector(onCanyuButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.canyuButton];
    [self.canyuButton setUserInteractionEnabled:false];
}

- (void)onCanyuButton {
    
}

- (void)reload:(NSDictionary *)item {
    NSString *name = item[@"label"];
    self.titleLabel.text = [NSString stringWithFormat:@"#%@", name];
    [self.titleLabel sizeToFit];

    self.heatLabel.text = [NSString stringWithFormat:@"%@次播放", item[@"heat"]];
    [self.heatLabel sizeToFit];
}

- (void)layoutAdjustContents {
    self.titleLabel.left = 15;
    self.heatLabel.left = 15;
    
    CGFloat top = (self.height-self.titleLabel.height-self.heatLabel.height-5)/2;
    self.titleLabel.top = top;
    self.heatLabel.top = self.titleLabel.bottom+5;
    
    self.canyuButton.left = self.width-15-self.canyuButton.width;
    self.canyuButton.centerY = self.height/2;
}


@end
