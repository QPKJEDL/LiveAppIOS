//
//  ButtonsView.h
//  zhibo
//
//  Created by FaiWong on 2020/4/25.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ButtonsView;
@protocol ButtonsViewDelegate <NSObject>

- (void)buttonsView:(ButtonsView *)buttonsView didSelectIndex:(NSInteger)index;

@end

@interface ButtonsView : UIView
- (instancetype)initWithFrame:(CGRect)frame list:(NSArray<NSDictionary *> *)list;
@property (nonatomic, weak) id<ButtonsViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
