//
//  RankActionsView.m
//  zhibo
//
//  Created by qp on 2020/7/28.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RankActionsView.h"
@interface RankActionsView ()
@property (nonatomic, strong) QMUIButton *leftButton;
@property (nonatomic, strong) QMUIButton *rightButton;
@end
@implementation RankActionsView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.leftButton = [self bbb];
        self.leftButton.tag = 0;
        self.rightButton = [self bbb];
        self.rightButton.tag = 1;
        
        self.selectIndex = 0;
    }
    return self;
}

- (QMUIButton *)bbb {
    QMUIButton *btn = [[QMUIButton alloc] initWithFrame:CGRectMake(0, 0, 94, 26)];
    btn.titleLabel.font = [UIFont PingFangMedium:12];
    btn.clipsToBounds = true;
    btn.layer.cornerRadius = 13;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor hexColor:@"#C7CBDB"]] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor hexColor:@"#FF2B2B"]] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(onAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    return btn;
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    
    [self.leftButton setSelected:false];
    [self.rightButton setSelected:false];
    if (selectIndex == self.leftButton.tag) {
        [self.leftButton setSelected:true];
    }
    
    if (selectIndex == self.rightButton.tag) {
        [self.rightButton setSelected:true];
    }
    
}

- (void)setleft:(NSString *)left right:(NSString *)right {
    [self.leftButton setTitle:left forState:UIControlStateNormal];
    [self.rightButton setTitle:right forState:UIControlStateNormal];

}

- (void)onAction:(QMUIButton *)btn {
    self.selectIndex = btn.tag;

}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.leftButton.left = self.width/2-35/2-self.leftButton.width;
    self.rightButton.left = self.width/2+35/2;
    
    self.leftButton.centerY = self.height/2;
    self.rightButton.centerY = self.height/2;
}
@end
