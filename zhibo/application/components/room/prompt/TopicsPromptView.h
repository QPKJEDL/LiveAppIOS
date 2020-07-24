//
//  TipSelectPromptView.h
//  zhibo
//
//  Created by qp on 2020/7/11.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasePromptView.h"
NS_ASSUME_NONNULL_BEGIN
@class TopicsPromptView;
@protocol TopicsPromptViewDelegate <NSObject>

- (void)topicsPromptView:(TopicsPromptView *)topicsPromptView didSelectTopic:(NSString *)topic;

@end
@interface TopicsPromptView : BasePromptView
@property (nonatomic, weak) id<TopicsPromptViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
