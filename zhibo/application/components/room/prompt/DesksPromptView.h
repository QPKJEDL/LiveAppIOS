//
//  DesksPromptView.h
//  zhibo
//
//  Created by qp on 2020/7/12.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DesksPromptView;
@protocol DesksPromptViewDelegate <NSObject>

- (void)desksPromptView:(DesksPromptView *)desksPromptView didSelectIndex:(NSInteger)index item:(NSDictionary *)item;

@end
@interface DesksPromptView : UIView
@property (nonatomic, strong) id<DesksPromptViewDelegate> delegate;
- (void)refreshWithGameID:(NSInteger)gameid;
@end

NS_ASSUME_NONNULL_END
