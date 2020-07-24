//
//  ArrowItemView.m
//  zhibo
//
//  Created by qp on 2020/7/24.
//  Copyright © 2020 qp. All rights reserved.
//

#import "ArrowItemView.h"
@interface ArrowItemView ()
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@end
@implementation ArrowItemView

- (void)setupAdjustContents {
    
    self.containView = [[UIView alloc] initWithFrame:self.bounds];
    self.containView.backgroundColor = [UIColor whiteColor];
    self.containView.clipsToBounds = true;
    [self addSubview:self.containView];
    
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.iconImageView.backgroundColor = [UIColor hexColor:@"f3f3f2"];
    [self.containView addSubview:self.iconImageView];
    self.iconImageView.frame = CGRectMake(0, 0, 20, 20);
    self.iconImageView.backgroundColor = UIColor.whiteColor;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textColor = [UIColor hexColor:@"222222"];
    [self.containView addSubview:self.titleLabel];
    
//    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//    self.contentLabel.font = [UIFont systemFontOfSize:13];
//    self.contentLabel.textColor = [UIColor hexColor:@"B0B0B0"];
//    [self.containView addSubview:self.contentLabel];
    
    self.arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 8, 12)];
    self.arrowImageView.image = [UIImage imageNamed:@"huisefanhui"];
    self.arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.containView addSubview:self.arrowImageView];
    
}


- (void)reload:(NSDictionary *)item extra:(NSDictionary *)extra indexPath:(NSIndexPath *)indexPath {
    NSString *icon = item[@"icon"];
    NSString *title = item[@"title"];
//    NSString *content = item[@"content"];
    
    [self.titleLabel setHidden:false];
    self.titleLabel.text = title;
    [self.titleLabel sizeToFit];
    
    [_iconImageView setHidden:true];
    if (icon != nil) {
        [_iconImageView loadImage:icon];
        [_iconImageView setHidden:false];
    }
    
    if ([item[@"cc"] boolValue]) {
        self.containView.frame = CGRectInset(self.bounds, 10, 0);
        if ([extra[@"isFirst"] boolValue] && [extra[@"isEnd"] boolValue]) {
            [self.containView corner:UIRectCornerAllCorners radii:6];
        }
        else if ([extra[@"isFirst"] boolValue]) {
            [self.containView corner:UIRectCornerTopLeft|UIRectCornerTopRight radii:6];
        }
        else if ([extra[@"isEnd"] boolValue]) {
            [self.containView corner:UIRectCornerBottomLeft|UIRectCornerBottomRight radii:6];
        }
        
    }
}

- (void)layoutAdjustContents {
//    self.containView.frame = self.bounds;
    
    self.iconImageView.centerY = self.containView.height/2;
    self.iconImageView.left = 15;
    
    self.titleLabel.left = self.iconImageView.right+10;
    self.titleLabel.centerY = self.containView.height/2;
    if (_iconImageView.isHidden) {
        self.titleLabel.left = 15;
    }
    
    self.arrowImageView.left = self.containView.width-self.arrowImageView.width-15;
    self.arrowImageView.centerY = self.containView.height/2;
}

@end
