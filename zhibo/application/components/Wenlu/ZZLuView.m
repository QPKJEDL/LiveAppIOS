//
//  ZZLuView.m
//  zhibo
//
//  Created by qp on 2020/8/3.
//  Copyright © 2020 qp. All rights reserved.
//

#import "ZZLuView.h"
@interface ZZLuView ()
@property (nonatomic, strong) NSMutableArray *dataList;
@end
@implementation ZZLuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)push:(NSString *)pie {
    [self.dataList addObject:pie];
}


@end
