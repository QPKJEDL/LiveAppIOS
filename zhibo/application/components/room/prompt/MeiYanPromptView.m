//
//  MeiYanView.m
//  zhibo
//
//  Created by qp on 2020/7/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import "MeiYanPromptView.h"
@interface MeiYanPromptView ()<ABUIListViewDelegate, ABUIListViewDataSource>
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) ABUIListView *listView;
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, weak) UIView *thumbImageView;
@end
@implementation MeiYanPromptView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        
        self.slider = [[QMUISlider alloc] initWithFrame:CGRectMake(20, 20, self.width-40, 40)];
        self.slider.minimumTrackTintColor = [UIColor hexColor:@"#FF2A40"];
        self.slider.maximumTrackTintColor = [UIColor hexColor:@"FFFFFF"];
        self.slider.thumbColor = [UIColor whiteColor];
        self.slider.thumbSize = CGSizeMake(20, 20);
        [self.slider addTarget:self action:@selector(onSlicker) forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.slider];
        
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -15, 30, 20)];
        self.textLabel.text = @"100";
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.font = [UIFont PingFangSC:14];
//        self.textLabel.backgroundColor = [UIColor redColor];
        [self.slider addSubview:self.textLabel];
//        [self.textLabel sizeToFit];
        
        self.containView = [[UIView alloc] initWithFrame:CGRectMake(0, self.slider.bottom, self.width, self.height-self.slider.bottom)];
        self.containView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        [self addSubview:self.containView];
        [self.containView corner:UIRectCornerTopLeft|UIRectCornerTopRight radii:10];
        
        self.listView = [[ABUIListView alloc] initWithFrame:self.containView.bounds];
        self.listView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.listView.height = 100;
        self.listView.delegate = self;
        self.listView.dataSource = self;
        [self.containView addSubview:self.listView];
        
        NSArray *list = @[
            @{
                @"title":@"美颜",
                @"icon":@"yuan",
                @"native_id":@"titleimage"
            },
            @{
                @"title":@"美白",
                @"icon":@"yuan",
                @"native_id":@"titleimage"
            },
            @{
                @"title":@"红润",
                @"icon":@"yuan",
                @"native_id":@"titleimage"
            }
        ];
        NSDictionary *css = @{
            @"item.size.width":@"20%",
            @"item.size.height":@(self.listView.height),
        };
        [self.listView setDataList:list css:css];
        if (self.index == 0) {
            self.slider.value = [RoomContext shared].pushView.beautyLevel;
        }
        else if (self.index == 1) {
            self.slider.value = [RoomContext shared].pushView.whitenessLevel;
        }
        else if (self.index == 2) {
            self.slider.value = [RoomContext shared].pushView.ruddyLevel;
        }

    }
    return self;
}

- (void)onSlicker {
    if (self.index == 0) {
        [RoomContext shared].pushView.beautyLevel = self.slider.value;
    }
    else if (self.index == 1) {
        [RoomContext shared].pushView.whitenessLevel = self.slider.value;
    }
    else if (self.index == 2) {
        [RoomContext shared].pushView.ruddyLevel = self.slider.value;
    }
    [self refreshText];
}
- (void)refreshText {
    if (self.thumbImageView == nil) {
        for (UIView *v in self.subviews.firstObject.subviews) {
            if ([v isKindOfClass:[UIImageView class]]) {
                self.thumbImageView = v;
                break;
            }
        }
    }
    int v = self.slider.value*100;
    self.textLabel.text = [NSString stringWithFormat:@"%i", v];
    self.textLabel.centerX = self.thumbImageView.centerX;
}

- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item {
    self.index = indexPath.row;
    
    if (self.index == 0) {
        self.slider.value = [RoomContext shared].pushView.beautyLevel;
    }
    else if (self.index == 1) {
        self.slider.value = [RoomContext shared].pushView.whitenessLevel;
    }
    else if (self.index == 2) {
        self.slider.value = [RoomContext shared].pushView.ruddyLevel;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self refreshText];
    });
    [self.listView reloadData];
}

- (NSDictionary *)listView:(ABUIListView *)listView extraDataAtIndexPath:(NSIndexPath *)indexPath {
    if (self.index == indexPath.row) {
        return @{@"selected":@(1)};
    }
    return @{@"selected":@(0)};
}

- (void)setThumbImageView:(UIView *)thumbImageView {
    _thumbImageView = thumbImageView;
    [self refreshText];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self refreshText];
    });
}

@end
