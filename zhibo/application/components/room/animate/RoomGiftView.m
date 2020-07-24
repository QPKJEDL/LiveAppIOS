//
//  RoomGiftView.m
//  zhibo
//
//  Created by qp on 2020/7/13.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RoomGiftView.h"
#import "GiftRawView.h"
#import "GiftEffectsPlayView.h"
@interface RoomGiftView ()<GiftRawViewDelegate>
@property (nonatomic, strong) NSMutableArray<GiftRawView *> *pools;
@property (nonatomic, strong) NSMutableArray *quene;
@end
@implementation RoomGiftView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.quene = [[NSMutableArray alloc] init];
        self.pools = [[NSMutableArray alloc] init];
        for (int i=0; i<2; i++) {
            GiftRawView *rawView = [[GiftRawView alloc] initWithFrame:CGRectMake(-self.width*2, i*(self.height/2)+i*5, self.width, (self.height-5)/2)];
            
            rawView.delegate = self;
            [self addSubview:rawView];
            [self.pools addObject:rawView];
        }
        
        
    }
    return self;
}

- (void)push:(NSDictionary *)gift {
    [self.quene insertObject:gift atIndex:0];
    [self messageDistribute];
}

- (void)messageDistribute {
    for (GiftRawView *raw in self.pools) {
        NSDictionary *lastObj = self.quene.lastObject;
        if (lastObj == nil) {
            return;
        }
        if (raw.isFree || [raw isRefresh:lastObj]) {
            [raw showWithData:lastObj];
            [self.quene removeLastObject];
        }
    }
}

- (void)giftRawViewFinish {
    [self messageDistribute];
}

- (void)giftRawView:(GiftRawView *)giftRawView onDidSelectUid:(NSInteger)uid {
    
}
@end
