//
//  RoomPushPresent.h
//  zhibo
//
//  Created by qp on 2020/7/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RoomPresent.h"
NS_ASSUME_NONNULL_BEGIN
@class RoomPushPresent;
@protocol RoomPushPresentDelegate <NSObject>

- (void)present:(RoomPushPresent *)present startLive:(NSString *)address;

@end
@interface RoomPushPresent : RoomPresent
@property (nonatomic, assign) id<RoomPushPresentDelegate> delegate;
@property (nonatomic, strong) NSString *address;
- (void)requestRoomInfo;

- (void)setcover:(NSString *)covername gameid:(NSInteger)gameid deskid:(NSInteger)deskid channel:(NSString *)channel;

@end

NS_ASSUME_NONNULL_END
