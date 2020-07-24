//
//  RoomChatView.h
//  zhibo
//
//  Created by qp on 2020/7/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class RoomChatView;
@protocol RoomChatViewDelegate <NSObject>

- (void)roomChatView:(RoomChatView *)roomChatView didSelectUid:(NSInteger)uid;

@end
@interface RoomChatView : UIView
@property (nonatomic, weak) id<RoomChatViewDelegate> delegate;
- (void)receiveNewMessage:(NSDictionary *)message;
- (void)receiveNewNotice:(NSDictionary *)notice;
@end

NS_ASSUME_NONNULL_END
