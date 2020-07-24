//
//  BetCoinsView.h
//  zhibo
//
//  Created by qp on 2020/6/22.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class BetCoinsView;
@protocol BetCoinsViewDelegate <NSObject>

- (void)betCoinsView:(BetCoinsView *)betCoinsView didSelectItemAtIndex:(NSInteger)index;

@end

@interface BetCoinsView : UIView
@property (nonatomic, weak) id<BetCoinsViewDelegate> delegate;
@property (nonatomic, assign) NSInteger selectIndex;
- (void)reload:(NSArray *)dataList;
@end

NS_ASSUME_NONNULL_END
