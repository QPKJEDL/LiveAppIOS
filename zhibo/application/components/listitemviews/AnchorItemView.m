//
//  AnchorItemView.m
//  zhibo
//
//  Created by qp on 2020/6/17.
//  Copyright © 2020 qp. All rights reserved.
//

#import "AnchorItemView.h"
@interface AnchorItemView ()
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) UIView *bottomBar;
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *watchCountLabel;
@end
@implementation AnchorItemView
- (void)setupAdjustContents {
    _containView = [[UIView alloc] initWithFrame:self.bounds];
    _containView.clipsToBounds = true;
    _containView.layer.cornerRadius = 5;
    _containView.backgroundColor = UIColor.grayColor;
    [self addSubview:_containView];
    
    
    _coverImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    _coverImageView.clipsToBounds = true;
    [self.containView addSubview:_coverImageView];
    
    _bottomBar = [[UIView alloc] initWithFrame:self.bounds];
    _bottomBar.alpha = 0.25;
    [self.containView addSubview:_bottomBar];
    [_bottomBar gradient:@[(__bridge id)[UIColor clearColor].CGColor,(__bridge id)[UIColor hexColor:@"333333"].CGColor] direction:2];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.font = [UIFont boldSystemFontOfSize:14];
    [_nameLabel sizeToFit];
    [self.containView addSubview:_nameLabel];
    
    _watchCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _watchCountLabel.textColor = [UIColor whiteColor];
    _watchCountLabel.font = [UIFont boldSystemFontOfSize:14];
    [_watchCountLabel sizeToFit];
    [self.containView addSubview:_watchCountLabel];
}

- (void)layoutAdjustContents {
    _nameLabel.top = self.height-20;
    self.coverImageView.frame = self.bounds;
    _nameLabel.left = 10;
    _nameLabel.top = self.height-self.nameLabel.height-10;
    _bottomBar.top = self.height-self.bottomBar.height;
    
    _watchCountLabel.left = self.width-12-self.watchCountLabel.width;
    _watchCountLabel.top = self.height-10-self.watchCountLabel.height;
}

- (void)reload:(NSDictionary *)item {
    self.nameLabel.text = item[@"CoverName"];
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:item[@"CoverImg"]] placeholderImage:[UIImage imageNamed:@"anchor_default"]];
    
    [self.nameLabel sizeToFit];
    if (item[@"RoomCount"] == nil) {
         _watchCountLabel.text = @"0";
    }else{
         _watchCountLabel.text = [NSString stringWithFormat:@"%@", item[@"RoomCount"]];
    }
   

    [_watchCountLabel sizeToFit];
    
    _nameLabel.width = 100;
}
@end

