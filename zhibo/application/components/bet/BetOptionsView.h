//
//  BetOptionsView.h
//  zhibo
//
//  Created by qp on 2020/6/22.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class BetOptionsView;
@protocol BetOptionsViewDelegate <NSObject>

- (void)betOptionsView:(BetOptionsView *)betOptionsView didSelectItemAtIndex:(NSInteger)index;

@end
@interface BetOptionsView : UIView
@property (nonatomic, weak) id<BetOptionsViewDelegate> delegate;
@property (nonatomic, assign) NSInteger selectIndex;
- (void)reload:(NSArray *)dataList;
@end

NS_ASSUME_NONNULL_END
