//
//  ChannelsPromptView.h
//  zhibo
//
//  Created by qp on 2020/7/11.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasePromptView.h"
NS_ASSUME_NONNULL_BEGIN
@class ChannelsPromptView;
@protocol ChannelsPromptViewDelegate <NSObject>
- (void)channelsPromptView:(ChannelsPromptView *)channelsPromptView didSelectChannel:(NSString *)channel;
@end
@interface ChannelsPromptView : BasePromptView
@property (nonatomic, weak) id<ChannelsPromptViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
