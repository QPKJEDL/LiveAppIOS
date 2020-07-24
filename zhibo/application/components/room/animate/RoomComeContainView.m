//
//  RoomComeContainView.m
//  zhibo
//
//  Created by qp on 2020/7/16.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RoomComeContainView.h"
#import "RoomComeRaw.h"
//@implementation RoomComeContainView
//
//- (void)pushUser:(NSDictionary *)user {
//    
//}
//@end

@interface RoomComeContainView ()
@property (nonatomic, strong) NSMutableArray<RoomComeRaw *> *pools;
@property (nonatomic, strong) NSMutableArray *quene;
@end
@implementation RoomComeContainView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.quene = [[NSMutableArray alloc] init];
//        self.pools = [[NSMutableArray alloc] init];
//        CGFloat x = 5;
//        for (int i=0; i<1; i++) {
//            RoomComeRaw *rawView = [[RoomComeRaw alloc] initWithFrame:CGRectMake(-self.width*2, i*(self.height/2)+i*5, self.width, (self.height-5)/2)];
//            rawView.delegate = self;
//            [self addSubview:rawView];
//            [self.pools addObject:rawView];
//        }
//
        
    }
    return self;
}

- (void)pushUser:(NSDictionary *)user {
    
}

@end
