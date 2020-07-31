//
//  ZBTabBar.m
//  zhibo
//
//  Created by FaiWong on 2020/4/23.
//  Copyright © 2020 qp. All rights reserved.
//

#import "ZBTabBar.h"

#define ScreenWidth  ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight  ([UIScreen mainScreen].bounds.size.height)

#define iPhoneX ((ScreenHeight == 812.0 || ScreenHeight == 896.0) ? YES : NO)
#define kBottomSafeSpace (iPhoneX ? 34.0 : 0.0)
@interface ZBTabBar ()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation ZBTabBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUpBackGroundImage];
        [self removeSystemTopBlackLine];
    }
    return self;
}


#pragma mark set tabbar backgroundimage
- (void)setUpBackGroundImage {

}

- (void)removeSystemTopBlackLine {    
    [self setBackgroundImage:[UIImage new]];
    [self setShadowImage:[UIImage new]];
}


#pragma mark adjust the system tabbarbutton position to fit the middle button position
- (void)adjustTabBarsButtonPostion {
//    CGFloat width = self.centerButton.width;
//    self.centerButton.frame = CGRectMake((ScreenWidth-width)/2, -15, width, width);
//
//    CGFloat tabBarButtonW = ScreenWidth / 5;
//    CGFloat tabBarButtonIndex = 0;
//    for (UIView *child in self.subviews) {
//
//        Class class = NSClassFromString(@"UITabBarButton");
//        if ([child isKindOfClass:class]) {
//
//            CGRect frame = CGRectMake(tabBarButtonIndex * tabBarButtonW, 0, tabBarButtonW, 49);
//            child.frame = frame;
//
//            if (tabBarButtonIndex == 1) {
//                tabBarButtonIndex++;
//            }
//            tabBarButtonIndex++;
//        }
//    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self adjustTabBarsButtonPostion];
    [self hidenShadowLine];
}

- (void)hidenShadowLine {
    for (UIView *v in self.subviews) {
        if ([[[v class] description]  isEqual: @"_UIBarBackground"]) {
            for (UIView *vv in v.subviews) {
                if ([[[vv class] description]  isEqual: @"_UIBarBackgroundShadowView"]) {
                    vv.alpha = 0;
                    break;
                }
            }
        }
    }
}

////处理超出区域点击无效的问题
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    if (self.hidden){
//        return [super hitTest:point withEvent:event];
//    }else {
//        //转换坐标
//        CGPoint tempPoint = [self.centerButton convertPoint:point fromView:self];
//        //判断点击的点是否在按钮区域内
//        if (CGRectContainsPoint(self.centerButton.bounds, tempPoint)){
//            //返回按钮
//            return self.centerButton;
//        }else {
//            return [super hitTest:point withEvent:event];
//        }
//    }
//}

- (void)centerButtonClick {
    if (self.delegatee && [self.delegate respondsToSelector:@selector(onCenterButtonAction)]) {
        [self.delegatee onCenterButtonAction];
    }
}

//- (UIControl *)centerButton {
//    
//    if (_centerButton == nil) {
//        
//        UIImage *img = [UIImage imageNamed:@"zhibo1"];
//        _centerButton = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
//
//        _centerButton.backgroundColor = UIColor.clearColor;
////        _centerButton.layer.cornerRadius = _centerButton.width/2;
//        [self addSubview:_centerButton];
//        
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -12, img.size.width, img.size.height)];
//        imageView.image = img;
//        [_centerButton addTarget:self action:@selector(centerButtonClick) forControlEvents:UIControlEventTouchUpInside];
//        [_centerButton addSubview:imageView];
//        
//        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        [_centerButton addSubview:self.titleLabel];
//        self.titleLabel.font = [UIFont boldSystemFontOfSize:10];
//        self.titleLabel.textColor = [UIColor hexColor:@"#C6C8D4"];
//        self.titleLabel.text = @"开播";
//        [self.titleLabel sizeToFit];
//        self.titleLabel.top = imageView.bottom+5;
//        self.titleLabel.centerX = imageView.centerX;
//        [self.titleLabel sizeToFit];
//    }
//    
//    return _centerButton;
//}


@end
