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
@property (nonatomic, strong) UIImageView *watchImageView;
@property (nonatomic, strong) UILabel *watchCountLabel;
@property (nonatomic, strong) UIImageView *gameImageView;
@end
@implementation AnchorItemView
- (void)setupAdjustContents {
    _containView = [[UIView alloc] initWithFrame:self.bounds];
    _containView.layer.cornerRadius = 8;
    _containView.backgroundColor = UIColor.whiteColor;
    [self addSubview:_containView];
    _containView.layer.shadowColor = [UIColor colorWithRed:117/255.0 green:120/255.0 blue:129/255.0 alpha:0.15].CGColor;
    _containView.layer.shadowOffset = CGSizeMake(0,3);
    _containView.layer.shadowOpacity = 1;
    _containView.layer.shadowRadius = 6;
    
    
    _coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(4, 4, self.width-8, self.width-8)];
    _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    _coverImageView.layer.cornerRadius = 8;
    _coverImageView.clipsToBounds = true;
//    [_coverImageView gradient:GRADIENTCOLORS direction:0];
    [self.containView addSubview:_coverImageView];
    
    _watchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, self.coverImageView.bottom-20, 10, 10)];
    _watchImageView.contentMode = UIViewContentModeScaleAspectFit;
    _watchImageView.image = [UIImage imageNamed:@"renshu2"];
    [self.coverImageView addSubview:_watchImageView];
    
    _watchCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _watchCountLabel.textColor = [UIColor whiteColor];
    _watchCountLabel.font = [UIFont boldSystemFontOfSize:10];
    [_watchCountLabel sizeToFit];
    [self.coverImageView addSubview:_watchCountLabel];
    
    _bottomBar = [[UIView alloc] initWithFrame:self.bounds];
    _bottomBar.alpha = 0.25;
//    [self.containView addSubview:_bottomBar];
    [_bottomBar gradient:@[(__bridge id)[UIColor clearColor].CGColor,(__bridge id)[UIColor hexColor:@"333333"].CGColor] direction:2];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _nameLabel.textColor = [UIColor hexColor:@"#2A323F"];
    _nameLabel.font = [UIFont PingFangSCBlod:12];
    [_nameLabel sizeToFit];
    [self.containView addSubview:_nameLabel];
    
    self.gameImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 45, 33)];
    self.gameImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.gameImageView setImage:[UIImage imageNamed:@"icon_niuniu"]];
    [self.coverImageView addSubview:self.gameImageView];
    
    
}

- (void)layoutAdjustContents {
    _nameLabel.top = self.height-20;
//    self.coverImageView.frame = self.bounds;
    _nameLabel.left = 6;
    _nameLabel.top = self.coverImageView.bottom+8;
    _bottomBar.top = self.height-self.bottomBar.height;
    
    _watchCountLabel.left = self.watchImageView.right+2;
    _watchCountLabel.centerY = self.watchImageView.centerY;
    
    self.gameImageView.left = self.coverImageView.width-5-self.gameImageView.width;
    self.gameImageView.top = self.coverImageView.height-5-self.gameImageView.height;
}

- (void)reload:(NSDictionary *)item {
    self.nameLabel.text = item[@"nickname"];
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:item[@"avatar"]] placeholderImage:[UIImage imageNamed:@"room_default"]];
    
    [self.nameLabel sizeToFit];
    self.nameLabel.height = 12;
    if (item[@"roomcount"] == nil) {
         _watchCountLabel.text = @"0";
    }else{
         _watchCountLabel.text = [NSString stringWithFormat:@"%@", item[@"roomcount"]];
    }
    
    [self.gameImageView setImage:nil];
    if (item[@"game_icon"] != nil) {
        [self.gameImageView setImage:[UIImage imageNamed:item[@"game_icon"]]];
    }
   
    [_watchCountLabel sizeToFit];
    
    _nameLabel.width = 100;
}
@end

