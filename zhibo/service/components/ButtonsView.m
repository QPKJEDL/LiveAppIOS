//
//  ButtonsView.m
//  zhibo
//
//  Created by FaiWong on 2020/4/25.
//  Copyright © 2020 qp. All rights reserved.
//

#import "ButtonsView.h"
@implementation ButtonsView
- (instancetype)initWithFrame:(CGRect)frame list:(NSArray<NSDictionary *> *)list {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat padding = (list.count-1)*9;
        CGFloat itemWidth = (self.width-padding)/list.count;
        NSInteger index = 0;
        for (NSDictionary *item in list) {
            QMUIButton *btn = [[QMUIButton alloc] initWithFrame:CGRectMake(index*itemWidth+index*9, 0, itemWidth, self.height)];
            btn.backgroundColor = [UIColor whiteColor];
            btn.layer.cornerRadius = 6;
            btn.clipsToBounds = true;
            btn.spacingBetweenImageAndTitle = 5;
            btn.imagePosition = QMUIButtonImagePositionTop;
            [btn setImage:[UIImage imageNamed:item[@"icon"]] forState:UIControlStateNormal];
            [btn setTitle:item[@"title"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor hexColor:@"#4D4D68"] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont PingFangMedium:14];
            [btn addTarget:self action:@selector(onOptionAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = index;
            [self addSubview:btn];
            
            index++;
        }
    }
    return self;
}

- (void)onOptionAction:(UIButton *)btn {
    [self.delegate buttonsView:self didSelectIndex:btn.tag];
}

@end
