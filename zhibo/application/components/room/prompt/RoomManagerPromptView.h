//
//  RoomManagerPromptView.h
//  zhibo
//
//  Created by qp on 2020/7/14.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasePromptView.h"
NS_ASSUME_NONNULL_BEGIN

@interface RoomManagerPromptView : BasePromptView
- (void)refreshWithRoomID:(NSInteger)roomid;
@end

NS_ASSUME_NONNULL_END
