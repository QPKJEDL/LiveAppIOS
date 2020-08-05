//
//  ADBannerView.m
//  zhibo
//
//  Created by qp on 2020/7/27.
//  Copyright © 2020 qp. All rights reserved.
//

#import "ADBannerView.h"
#import <SDCycleScrollView.h>
@interface ADBannerView ()<SDCycleScrollViewDelegate>
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@end
@implementation ADBannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.containView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, self.width-30, 103)];
        self.containView.layer.cornerRadius = 8;
        self.containView.backgroundColor = [UIColor whiteColor];
        self.containView.clipsToBounds = true;
        [self addSubview:self.containView];
        
        self.containView.layer.shadowColor = [[UIColor hexColor:@"3A4C82"] CGColor];
        self.containView.layer.shadowOpacity = 0.07;
        self.containView.layer.shadowOffset = CGSizeMake(0, 0);
        self.containView.layer.shadowRadius = 38;
        
        // 网络加载图片的轮播器
        _cycleScrollView = [[SDCycleScrollView alloc] initWithFrame:self.containView.bounds];
        _cycleScrollView.autoScrollTimeInterval = 5.0f;
        _cycleScrollView.delegate = self;
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        [self.containView addSubview:self.cycleScrollView];
        
    }
    return self;
}

- (void)setUrls:(NSArray *)urls {
//    _cycleScrollView.imageURLStringsGroup = @[@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=587361437,2958469427&fm=15&gp=0.jpg", @"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3554609148,2724423662&fm=26&gp=0.jpg"];
    _cycleScrollView.imageURLStringsGroup = urls;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    [self.delegate adBannerView:self didSelectIndex:index];

}
@end
