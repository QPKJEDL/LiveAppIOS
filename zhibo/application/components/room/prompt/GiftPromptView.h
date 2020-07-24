//
//  GiftView.h
//  zhibo
//
//  Created by qp on 2020/7/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GiftPromptView : UIView
- (void)refreshWithRoomID:(NSInteger)roomid liveuid:(NSInteger)liveuid;
@end

NS_ASSUME_NONNULL_END
