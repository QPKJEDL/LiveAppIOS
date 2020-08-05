//
//  MineActionsView.m
//  zhibo
//
//  Created by FaiWong on 2020/4/25.
//  Copyright © 2020 qp. All rights reserved.
//

#import "MineActionsView.h"
#import "ButtonsView.h"
#import "MainViewController.h"
@interface MineActionsView ()<ButtonsViewDelegate>
@property (nonatomic, strong) ButtonsView *buttonsView;
@end
@implementation MineActionsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *list = [Config getMeActions];
        self.buttonsView = [[ButtonsView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) list:list];
        self.buttonsView.delegate = self;
        [self addSubview:self.buttonsView];
    }
    return self;
}

- (void)buttonsView:(ButtonsView *)buttonsView didSelectIndex:(NSInteger)index {
    if (index == 0) {
        [NSRouter gotoReCharge];
    }
    if (index == 1) {
        [NSRouter gotoCashOut];
    }
    if (index == 2) {
        [NSRouter gotoTransform];
    }
    if (index == 3) {
        [NSRouter gotoPopularize];
    }
}

@end
