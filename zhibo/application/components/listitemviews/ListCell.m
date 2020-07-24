//
//  ListCell.m
//  zhibo
//
//  Created by qp on 2020/4/29.
//  Copyright © 2020 qp. All rights reserved.
//

#import "ListCell.h"
@interface ListCell ()

@end
@implementation ListCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.containView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:self.containView];
        
        [self setupAdjustContents];
    }
    return self;
}

- (void)reload:(NSDictionary *)item {
    NSString *icon = item[@"icon"];
    NSString *title = item[@"title"];
    NSString *content = item[@"content"];
    
    //标题
    [self.titleLabel setHidden:true];
    if (title != nil) {
        [self.titleLabel setHidden:false];
        self.titleLabel.text = title;
        [self.titleLabel sizeToFit];
    }
    
    //内容
    [self.contentLabel setHidden:true];
    if (content != nil) {
        [self.contentLabel setHidden:false];
        self.contentLabel.text = content;
        [self.contentLabel sizeToFit];
    }
    
    //图标/头像
    [_iconImageView setHidden:true];
    if (icon != nil) {
        [_iconImageView loadImage:icon];
        [_iconImageView setHidden:false];
    }
}


- (void)setupAdjustContents {
    
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.iconImageView.backgroundColor = [UIColor hexColor:@"f3f3f2"];
    [self.containView addSubview:self.iconImageView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textColor = [UIColor hexColor:@"222222"];
    [self.containView addSubview:self.titleLabel];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.contentLabel.font = [UIFont systemFontOfSize:13];
    self.contentLabel.textColor = [UIColor hexColor:@"B0B0B0"];
    [self.containView addSubview:self.contentLabel];
    
}

- (void)setAccessoryView:(UIView *)accessoryView {
    _accessoryView = accessoryView;
    [_accessoryView removeFromSuperview];
    [self.containView addSubview:_accessoryView];
}

- (void)layoutAdjustContents {
    self.containView.frame = self.bounds;
    
    CGFloat titleLabelLeft = 15;
    if (_iconImageView.isHidden == false) {
        self.iconImageView.left = 15;
        titleLabelLeft = self.iconImageView.right+10;
        self.iconImageView.centerY = self.containView.height/2;
    }

    self.titleLabel.left = titleLabelLeft;
    self.contentLabel.left = titleLabelLeft;
    
    self.titleLabel.centerY = self.containView.height/2;
    if (self.contentLabel.text != nil) {
        self.titleLabel.top = self.containView.height/2-self.titleLabel.height-3;
        self.contentLabel.top = self.containView.height/2+3;
    }
    
    self.accessoryView.centerY = self.containView.height/2;
    self.accessoryView.left = self.containView.width-self.accessoryView.width-15;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self layoutAdjustContents];
}
@end
