//
//  BasePromptView.m
//  zhibo
//
//  Created by qp on 2020/7/16.
//  Copyright © 2020 qp. All rights reserved.
//

#import "BasePromptView.h"
@interface BasePromptView ()
@property (nonatomic, strong) QMUIEmptyView *emptyView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@end

@implementation BasePromptView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.emptyView = [[QMUIEmptyView alloc] initWithFrame:CGRectMake(0, 44, self.width, self.height-88)];
        [self.emptyView setLoadingViewHidden:true];
        [self.emptyView setImage:[UIImage imageNamed:@"shuju"]];
        [self.emptyView setTextLabelText:@"空空如也"];
        
        self.indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:self.bounds];
        self.indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [self addSubview:self.indicatorView];
        [self.indicatorView startAnimating];
    }
    return self;
}

- (void)showEmpty {
    if (self.emptyView.superview == nil) {
        [self addSubview:self.emptyView];
    }
}

- (void)hideEmpty {
    [self.emptyView removeFromSuperview];
}

- (void)showLoading {
    [self.indicatorView startAnimating];
}

- (void)hideLoading {
    [self.indicatorView stopAnimating];
}

@end
