//
//  PopUpOptionsView.m
//  zhibo
//
//  Created by FaiWong on 2020/4/23.
//  Copyright © 2020 qp. All rights reserved.
//  中间按钮点击弹出视图

#import "PopUpOptionsView.h"
#import "ButtonsView.h"
@interface PopUpOptionsView ()<ButtonsViewDelegate>
@property (nonatomic, strong) ButtonsView *buttonsView;
@end
@implementation PopUpOptionsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        [self corner:UIRectCornerTopLeft|UIRectCornerTopRight radii:10];
        [self addTopShadow];
        
        
        NSArray *list = [ResourceUtil popupData][@"data"];
        self.buttonsView = [[ButtonsView alloc] initWithFrame:CGRectMake(0, 40, self.width, 80) list:list];
        self.buttonsView.delegate = self;
        [self addSubview:self.buttonsView];
//        NSArray *list = [ResourceUtil popupData][@"data"];
//        CGFloat itemWidth = self.width/list.count;
//        NSInteger index = 0;
//        for (NSDictionary *item in list) {
//            ZBButton *btn = [[ZBButton alloc] initWithFrame:CGRectMake(index*itemWidth, 40, itemWidth, 80)];
//            btn.direction = ZBButtonDirectionColumn;
//            [btn setImage:[UIImage imageNamed:item[@"icon"]] forState:UIControlStateNormal];
//            [btn setTitle:item[@"title"] forState:UIControlStateNormal];
//            [btn setTitleColor:[UIColor hexColor:@"575757"] forState:UIControlStateNormal];
//            btn.titleLabel.font = [UIFont systemFontOfSize:16];
//            [btn addTarget:self action:@selector(onOptionAction:) forControlEvents:UIControlEventTouchUpInside];
//            btn.tag = index;
//            [self addSubview:btn];
//
//            index++;
//        }
//
        UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 173, 40, 40)];
        [closeButton setImage:[UIImage imageNamed:@"guan"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closeButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeButton];
        
        closeButton.centerX = self.width/2;
        
    }
    return self;
}

- (void)closeButtonAction {
    [[ABUIPopUp shared] remove];
}

- (void)buttonsView:(ButtonsView *)buttonsView didSelectIndex:(NSInteger)index {
    [[ABUIPopUp shared] remove];
    //直播
    if (index == 0) {
        [NSRouter gotoZhiBoPage];
    }
    //动态
    else if (index == 3) {
        [NSRouter gotoPublishDT];
    }
}

@end
