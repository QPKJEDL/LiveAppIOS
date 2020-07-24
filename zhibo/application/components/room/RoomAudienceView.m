//
//  RoomAudienceView.m
//  zhibo
//
//  Created by qp on 2020/7/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RoomAudienceView.h"
@interface RoomAudienceView ()<ABUIListViewDelegate>
@property (nonatomic, strong) ABUIListView *listView;
@property (nonatomic, strong) UICollectionView *collectionView;


@property (nonatomic, strong) NSArray *audiences;
@property (nonatomic, strong) UIView *maskView;
@end
@implementation RoomAudienceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width-51, 0, 51, self.height)];
        self.countLabel.layer.cornerRadius = 15;
        self.countLabel.textAlignment = NSTextAlignmentCenter;
        self.countLabel.clipsToBounds = true;
        self.countLabel.font = [UIFont systemFontOfSize:11];
        self.countLabel.textColor = [UIColor whiteColor];
        self.countLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        [self addSubview:self.countLabel];

        self.listView = [[ABUIListView alloc] initWithFrame:CGRectMake(0, 0, self.width-61, self.height)];
        self.listView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
         self.listView.collectionView.showsVerticalScrollIndicator = false;
        self.listView.collectionView.showsHorizontalScrollIndicator = false;
        self.listView.collectionView.alwaysBounceHorizontal = true;
        self.listView.collectionView.alwaysBounceVertical = false;
        self.listView.delegate = self;
        self.listView.startDirection = StatDirectionRight;
        [self addSubview:self.listView];

    }
    return self;
}

- (void)setCount:(NSInteger)count {
    self.countLabel.text = [NSString stringWithFormat:@"%li", (long)count];
}

- (void)setList:(NSArray *)list {
    self.audiences = [ABIteration iterationList:list block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
        dic[@"native_id"] = @"roomaudience";
        return dic;
    }];
    [self.listView setDataList:self.audiences css:@{@"item.size.width":@"30", @"item.size.height":@(self.height), @"item.rowSpacing": @"10"}];
//    CGFloat ll = self.listView.width-list.count*30;
//    if (ll<0) {
//        ll = 0;
//    }
}

@end
