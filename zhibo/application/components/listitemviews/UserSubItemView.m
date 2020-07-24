//
//  UserSubItemView.m
//  zhibo
//
//  Created by qp on 2020/7/11.
//  Copyright © 2020 qp. All rights reserved.
//

#import "UserSubItemView.h"
@interface UserSubItemView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@end
@implementation UserSubItemView

- (void)setupAdjustContents {
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 20)];
    self.titleLabel.font = [UIFont PingFangSC:12];
    self.titleLabel.textColor = [UIColor hexColor:@"#333333"];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
    
    self.detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.titleLabel.bottom, self.width, 20)];
    self.detailLabel.font = [UIFont PingFangSC:10];
    self.detailLabel.textColor = [UIColor hexColor:@"#666666"];
    self.detailLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.detailLabel];
}

- (void)reload:(NSDictionary *)item {
    self.titleLabel.text = item[@"content"];
    self.detailLabel.text = item[@"title"];
}

- (void)layoutAdjustContents {

}

@end
