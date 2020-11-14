//
//  RoomSocket.h
//  zhibo
//
//  Created by qp on 2020/7/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IMService.h>
NS_ASSUME_NONNULL_BEGIN
@protocol RoomSocketDelegate <NSObject>

- (void)roomSocketDidConnected;

@end
@interface RoomSocket : NSObject
@property (nonatomic, weak) id<RoomSocketDelegate> delegate;
@property (nonatomic, assign) int64_t roomID;
@property (nonatomic, strong) IMService *imService;

- (void)startRoomWithID:(int64_t)roomID;
- (void)stopRoom;

- (void)sendText:(NSString *)text;

- (void)applicationDidEnterBackground;

- (void)applicationDidBecomeActive;
@end

NS_ASSUME_NONNULL_END
