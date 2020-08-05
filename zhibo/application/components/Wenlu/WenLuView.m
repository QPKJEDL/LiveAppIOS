//
//  WenLuView.m
//  zhibo
//
//  Created by qp on 2020/8/3.
//  Copyright © 2020 qp. All rights reserved.
//

#import "WenLuView.h"
#import "ZZLuView.h"
@interface WenLuView()
@property (nonatomic, strong) ZZLuView *zzLuView;
@end
@implementation WenLuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.zzLuView = [[ZZLuView alloc] initWithFrame:self.bounds];
//        [self addSubView:self.zzLuView];
    }
    return self;
}

@end
