//
//  RankTopView.h
//  zhibo
//
//  Created by qp on 2020/7/28.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RankActionsView.h"
NS_ASSUME_NONNULL_BEGIN

@interface RankTopView : UIView
@property (nonatomic, strong) RankActionsView *rankActionsView;
- (void)setRankList:(NSArray *)rankList;
@end

NS_ASSUME_NONNULL_END
