//
//  RechargeChannelItemView.m
//  zhibo
//
//  Created by qp on 2020/9/2.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RechargeChannelItemView.h"
@interface RechargeChannelItemView ()
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) UILabel *cLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *textLabel;
@end
@implementation RechargeChannelItemView

- (void)setupAdjustContents {
    
    self.containView = [[UIView alloc] initWithFrame:CGRectInset(self.bounds, 7, 7)];
    self.containView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.containView];
    
    self.containView.layer.shadowColor = [UIColor colorWithRed:88/255.0 green:85/255.0 blue:217/255.0 alpha:0.1].CGColor;
    self.containView.layer.shadowOffset = CGSizeMake(0,7);
    self.containView.layer.shadowOpacity = 1;
    self.containView.layer.shadowRadius = 10;
    self.containView.layer.cornerRadius = 4.8;
    self.containView.layer.borderWidth = 1;
    self.containView.layer.borderColor = [UIColor hexColor:@"#FF2A40"].CGColor;
    
    
    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    self.numberLabel.textColor = [UIColor hexColor:@"#222222"];
    self.numberLabel.font = [UIFont PingFangSCBlod:12];
    [self.containView addSubview:self.numberLabel];
    
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    self.textLabel.textColor = [UIColor hexColor:@"#999999"];
    self.textLabel.font = [UIFont systemFontOfSize:9];
    [self.containView addSubview:self.textLabel];
}

- (void)reload:(NSDictionary *)item extra:(NSDictionary *)extra indexPath:(NSIndexPath *)indexPath {

    self.numberLabel.text = item[@"title"];
    [self.numberLabel sizeToFit];
    
    self.textLabel.text = item[@"xian"];
    [self.textLabel sizeToFit];
    
    self.containView.layer.borderWidth = 0;
    if ([extra[@"selected"] intValue] == 1) {
        self.containView.layer.borderWidth = 1;
    }
    
    [self layoutAdjustContents];
}

- (void)layoutAdjustContents {
    self.numberLabel.centerX = self.containView.width/2;
    
    CGFloat t = (self.containView.height-self.numberLabel.height-self.textLabel.height)/2;
    
    self.numberLabel.top = t;
    self.cLabel.top = self.numberLabel.bottom-self.cLabel.height-5;
    
    self.textLabel.centerX = self.containView.width/2;
    self.textLabel.top = self.numberLabel.bottom;
}


@end
