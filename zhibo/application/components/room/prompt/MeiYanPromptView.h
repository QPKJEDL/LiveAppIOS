//
//  MeiYanView.h
//  zhibo
//
//  Created by qp on 2020/7/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class MeiYanPromptView;
@protocol MeiYanPromptViewDelegate <NSObject>

//- (void)meiyanPromptView:(MeiYanPromptView *)meiyanPromptView onMeiYanChanged:(CGFloat)progress;
//- (void)meiyanPromptView:(MeiYanPromptView *)meiyanPromptView onMeiBaiChanged:(CGFloat)progress;
//- (void)meiyanPromptView:(MeiYanPromptView *)meiyanPromptView onHongRunChanged:(CGFloat)progress;

@end
@interface MeiYanPromptView : UIView
@property (nonatomic, weak) id<MeiYanPromptViewDelegate> delegate;
@property (nonatomic, strong) QMUISlider *slider;
@end

NS_ASSUME_NONNULL_END
