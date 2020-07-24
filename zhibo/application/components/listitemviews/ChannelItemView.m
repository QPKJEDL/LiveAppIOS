//
//  ChannelItemView.m
//  zhibo
//
//  Created by qp on 2020/7/11.
//  Copyright © 2020 qp. All rights reserved.
//

#import "ChannelItemView.h"
@interface ChannelItemView ()
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) QMUILabel *titleLabel;
@property (nonatomic, strong) QMUIButton *canyuButton;
@end
@implementation ChannelItemView

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
    
    
    self.canyuButton = [[QMUIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 26)];
    [self.canyuButton setTitle:@"参与" forState:UIControlStateNormal];
    self.canyuButton.titleLabel.font = [UIFont PingFangSC:12];
    [self.canyuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.canyuButton.layer.cornerRadius = 13;
    self.canyuButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.canyuButton.layer.borderWidth = 1;
     [self.canyuButton setUserInteractionEnabled:false];

    [self addSubview:self.canyuButton];
}

- (void)reload:(NSDictionary *)item {
    NSString *name = item[@"channel"];
    self.titleLabel.text = [NSString stringWithFormat:@"%@", name];
    [self.titleLabel sizeToFit];

}

- (void)layoutAdjustContents {
    self.titleLabel.left = 15;

    self.titleLabel.centerY = self.height/2;
    
    self.canyuButton.left = self.width-15-self.canyuButton.width;
    self.canyuButton.centerY = self.height/2;
}

@end
