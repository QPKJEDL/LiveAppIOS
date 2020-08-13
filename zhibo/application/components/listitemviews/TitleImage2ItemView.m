//
//  TitleImage2ItemView.m
//  zhibo
//
//  Created by qp on 2020/7/20.
//  Copyright © 2020 qp. All rights reserved.
//

#import "TitleImage2ItemView.h"

@interface TitleImage2ItemView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@end
@implementation TitleImage2ItemView

- (void)setupAdjustContents {
    self.backgroundColor = [UIColor clearColor];
    
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 34, 34)];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.iconImageView.layer.borderColor = [UIColor hexColor:@"#FF2A40"].CGColor;
//    self.iconImageView.layer.cornerRadius = 34/2;
    self.iconImageView.clipsToBounds = true;
    [self addSubview:self.iconImageView];
    
    self.titleLabel = [[QMUILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 10)];
    self.titleLabel.textColor = [UIColor hexColor:@"#545454"];
    self.titleLabel.font = [UIFont systemFontOfSize:11];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
}

- (void)reload:(NSDictionary *)item extra:(NSDictionary *)extra indexPath:(NSIndexPath *)indexPath {
    self.titleLabel.text = item[@"title"];
    [self.iconImageView setImage:[UIImage imageNamed:item[@"icon"]]];
    if (item[@"color"] != nil) {
        self.titleLabel.textColor = [UIColor hexColor:item[@"color"]];
    }
    
    self.iconImageView.layer.borderWidth = 0;
    if ([extra[@"selected"] intValue] == 1) {
        self.iconImageView.layer.borderWidth = 1;
    }
}

- (void)layoutAdjustContents {
    self.iconImageView.centerX = self.width/2;
    CGFloat top = (self.height-self.iconImageView.height-10)/2;
    self.iconImageView.top = top;
    self.titleLabel.top = self.iconImageView.bottom+8;
}
@end
