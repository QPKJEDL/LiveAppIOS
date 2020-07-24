//
//  PopUp.m
//  zhibo
//
//  Created by FaiWong on 2020/4/23.
//  Copyright © 2020 qp. All rights reserved.
//

#import "PopUp.h"

@interface PopUp ()
@property (nonatomic, strong) UIControl *cover;
@property (nonatomic, strong) UIView *containView;
@end
@implementation PopUp
+ (PopUp *)shared {
    static PopUp *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)show:(UIView *)v from:(PopUpDirection)direction {
    [self show:v from:direction distance:0];
}

- (void)show:(UIView *)v from:(PopUpDirection)direction distance:(CGFloat)distance {
    self.distance = distance;
    [self _showCover];
    self.containView = v;
    [[UIApplication sharedApplication].keyWindow addSubview:v];
    [self _animateShow];
}

- (void)_animateShow {
    self.cover.alpha = 0;
    self.containView.top = [UIScreen mainScreen].bounds.size.height;
    [UIView animateWithDuration:0.1 animations:^{
        self.cover.alpha = 0.2;
        self.containView.top = [UIScreen mainScreen].bounds.size.height-self.containView.height-self.distance;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)_animateHidden:(CGFloat)duration {
    self.cover.alpha = 0.2;
    self.containView.top = [UIScreen mainScreen].bounds.size.height-self.containView.height;
    [UIView animateWithDuration:duration animations:^{
        self.cover.alpha = 0;
        self.containView.top = [UIScreen mainScreen].bounds.size.height;
    } completion:^(BOOL finished) {
        [self.cover removeFromSuperview];
        self.containView = nil;
        self.cover = nil;
    }];
}

- (void)_showCover {
    self.cover = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.cover.backgroundColor = UIColor.blackColor;
    [self.cover addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].keyWindow addSubview: self.cover];
}

- (void)remove {
    [self _animateHidden:0.1];
}

- (void)remove:(CGFloat)duration {
    [self _animateHidden:duration];
}

@end
