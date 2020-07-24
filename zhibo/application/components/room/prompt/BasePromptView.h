//
//  BasePromptView.h
//  zhibo
//
//  Created by qp on 2020/7/16.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BasePromptView : UIView
- (void)showEmpty;
- (void)hideEmpty;

- (void)showLoading;
- (void)hideLoading;
@end

NS_ASSUME_NONNULL_END
