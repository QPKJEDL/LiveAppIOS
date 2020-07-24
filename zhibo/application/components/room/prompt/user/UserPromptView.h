//
//  UserPromptView.h
//  zhibo
//
//  Created by qp on 2020/7/11.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class UserPromptView;

@interface UserPromptView : UIView
- (void)refreshWith:(NSInteger)uid roomid:(NSInteger)roomid;
- (void)removeActionView;
@end

NS_ASSUME_NONNULL_END
