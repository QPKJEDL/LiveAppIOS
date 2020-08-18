//
//  RankTopView.m
//  zhibo
//
//  Created by qp on 2020/7/28.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RankTopView.h"
#import "PodiumView.h"
#import "RankActionsView.h"
@interface RankTopView ()
@property (nonatomic, strong) PodiumView *leftPodinumView;
@property (nonatomic, strong) PodiumView *centerPodinumView;
@property (nonatomic, strong) PodiumView *rightPodinumView;

@property (nonatomic, strong) NSArray *rankkList;

@end
@implementation RankTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.leftPodinumView = [[PodiumView alloc] initWithFrame:CGRectMake(0, self.height-150, 100, 150)];
        [self.leftPodinumView setTaiImageName:@"jt_dier" mc:2];
        [self addSubview:self.leftPodinumView];
        [self.leftPodinumView addTarget:self action:@selector(onLeftAction) forControlEvents:UIControlEventTouchUpInside];
        
        self.rightPodinumView = [[PodiumView alloc] initWithFrame:CGRectMake(0, self.height-150, 100, 150)];
        [self.rightPodinumView setTaiImageName:@"jt_disan" mc:3];
        [self addSubview:self.rightPodinumView];
        [self.rightPodinumView addTarget:self action:@selector(onRightAction) forControlEvents:UIControlEventTouchUpInside];
        
        self.centerPodinumView = [[PodiumView alloc] initWithFrame:CGRectMake(0, self.height-150, 120, 150)];
        [self.centerPodinumView setTaiImageName:@"zhongjian" mc:1];
        [self addSubview:self.centerPodinumView];
        [self.centerPodinumView addTarget:self action:@selector(onCenterAction) forControlEvents:UIControlEventTouchUpInside];
        
        self.centerPodinumView.centerX = self.width/2;
        self.leftPodinumView.left = self.centerPodinumView.left-self.leftPodinumView.width+10;
        self.rightPodinumView.left = self.centerPodinumView.right-10;
        
        self.rankActionsView = [[RankActionsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        [self addSubview:self.rankActionsView];
    
    }
    return self;
}

- (void)onLeftAction {
    if (self.rankkList.count >= 2) {
        NSInteger live_uid = [self.rankkList[1][@"live_uid"] intValue];
        [NSRouter gotoProfile:live_uid];
    }
    
}

- (void)onRightAction {
    if (self.rankkList.count >= 3) {
        NSInteger live_uid = [self.rankkList[2][@"live_uid"] intValue];
        [NSRouter gotoProfile:live_uid];
    }
}

- (void)onCenterAction {
    if (self.rankkList.count >= 1) {
        NSInteger live_uid = [self.rankkList[0][@"live_uid"] intValue];
        [NSRouter gotoProfile:live_uid];
    }
}

- (void)setRankList:(NSArray *)rankList {
    self.rankkList = rankList;
    [self.centerPodinumView clear];
    [self.leftPodinumView clear];
    [self.rightPodinumView clear];
    if (rankList.count >= 1) {
        [self.centerPodinumView setData:rankList[0]];
    }
    if (rankList.count >= 2) {
        [self.leftPodinumView setData:rankList[1]];
    }
    if (rankList.count >= 3) {
        [self.rightPodinumView setData:rankList[2]];
    }
}

@end
