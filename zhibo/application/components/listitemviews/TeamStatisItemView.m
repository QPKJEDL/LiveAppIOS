//
//  TeamStatisItemView.m
//  zhibo
//
//  Created by qp on 2020/8/1.
//  Copyright © 2020 qp. All rights reserved.
//

#import "TeamStatisItemView.h"
@interface TeamStatisItemView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@end
@implementation TeamStatisItemView

- (void)setupAdjustContents {
    self.backgroundColor = [UIColor whiteColor];
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    self.titleLabel.font = [UIFont PingFangSC:14];
    self.titleLabel.textColor = [UIColor hexColor:@"#A8A8A8"];
    [self addSubview:self.titleLabel];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    self.contentLabel.font = [UIFont PingFangSC:14];
    self.contentLabel.textColor = [UIColor hexColor:@"#A8A8A8"];
    self.contentLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.contentLabel];
}

- (void)layoutAdjustContents {
    self.titleLabel.centerY = self.height/2;
    self.titleLabel.left = 15;
    
    self.contentLabel.left = self.width-self.contentLabel.width-15;
    self.contentLabel.centerY = self.height/2;
}

- (void)reload:(NSDictionary *)item {
    self.titleLabel.text = item[@"title"];
    self.contentLabel.text = item[@"content"];
    
}

@end
