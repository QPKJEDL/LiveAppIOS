//
//  RoomPromptView.h
//  zhibo
//
//  Created by qp on 2020/7/14.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
#define RP [RoomPromptView shared]
@interface RoomPrompt : UIView
+ (RoomPrompt *)shared;

- (void)promptUserWithUid:(NSInteger)uid;

- (void)showEmpty;
- (void)hideEmpty;

- (void)showLoading;
- (void)hideLoading;
@end

NS_ASSUME_NONNULL_END
