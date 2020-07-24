//
//  GameSelectPromptView.h
//  zhibo
//
//  Created by qp on 2020/7/11.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class GamesPromptView;
@protocol GamesPromptViewDelegate <NSObject>
- (void)gamesPromptView:(GamesPromptView *)gamesPromptView didSelectIndex:(NSInteger)index item:(NSDictionary *)item;
@end
@interface GamesPromptView : UIView
@property (nonatomic, weak) id<GamesPromptViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
