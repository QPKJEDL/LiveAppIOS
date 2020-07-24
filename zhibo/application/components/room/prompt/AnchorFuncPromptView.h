//
//  AnchorFuncPromptView.h
//  zhibo
//
//  Created by qp on 2020/7/12.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class AnchorFuncPromptView;
@protocol AnchorFuncPromptViewDelegate <NSObject>

- (void)anchorFuncPromptView:(AnchorFuncPromptView *)anchorFuncPromptView didSelectIndex:(NSInteger)index item:(NSDictionary *)item;

@end
@interface AnchorFuncPromptView : UIView
@property (nonatomic, weak) id<AnchorFuncPromptViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
