//
//  TipSelectPromptView.h
//  zhibo
//
//  Created by qp on 2020/7/11.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class TopicsPromptView;
@protocol TipSelectPromptViewDelegate <NSObject>

- (void)tipSelectPromptView:(TopicsPromptView *)tipSelectPromptView didSelectTip:(NSString *)tip;

@end
@interface TopicsPromptView : UIView
@property (nonatomic, weak) id<TipSelectPromptViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
