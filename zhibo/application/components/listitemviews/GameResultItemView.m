//
//  GameResultItemView.m
//  zhibo
//
//  Created by qp on 2020/7/15.
//  Copyright © 2020 qp. All rights reserved.
//

#import "GameResultItemView.h"
@interface GameResultItemView ()
@property (nonatomic, strong) UILabel *aLabel;
@property (nonatomic, strong) UILabel *bLabel;
@property (nonatomic, strong) UILabel *cLabel;
@end
@implementation GameResultItemView

- (void)setupAdjustContents {
    self.aLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.aLabel.font = [UIFont PingFangSCBlod:20];
    self.aLabel.textColor = [UIColor hexColor:@"#27DEE8"];
    [self addSubview:self.aLabel];
    
    self.bLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.bLabel.font = [UIFont PingFangSCBlod:20];
    self.bLabel.textColor = [UIColor hexColor:@"#FFFFFF"];
    [self addSubview:self.bLabel];
    
    self.cLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.cLabel.font = [UIFont PingFangSCBlod:20];
    self.cLabel.textColor = [UIColor hexColor:@"#FFFFFF"];
    [self addSubview:self.cLabel];
}

- (void)reload:(NSDictionary *)item {
    self.aLabel.text = item[@"a"];
    [self.aLabel sizeToFit];
    
    self.bLabel.text = item[@"b"];
    [self.aLabel sizeToFit];
    
    self.cLabel.text = item[@"c"];
    [self.cLabel sizeToFit];
    
    self.cLabel.textColor = [UIColor hexColor:@"#FFFFFF"];
    if ([self.cLabel.text isEqualToString:@"赢"]) {
        self.cLabel.textColor = [UIColor hexColor:@"#FF0000"];
    }
}

- (void)layoutAdjustContents {
    self.aLabel.centerY = self.height/2;
    self.bLabel.centerY = self.height/2;
    self.cLabel.centerY = self.height/2;
    
    self.aLabel.left = 55;
    self.bLabel.centerX = self.width/2;
    self.cLabel.left = self.width-self.cLabel.width-55;
}
@end
