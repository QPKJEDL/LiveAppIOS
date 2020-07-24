//
//  RoomPlayPresent.h
//  zhibo
//
//  Created by qp on 2020/7/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RoomPresent.h"
NS_ASSUME_NONNULL_BEGIN
@class RoomPlayPresent;
@protocol RoomPlayPresentDelegate <NSObject>

- (void)roomPlayPresent:(RoomPlayPresent *)roomPlayPresent closeWithData:(NSDictionary *)data;

@end
@interface RoomPlayPresent : RoomPresent
@property (nonatomic, weak) id<RoomPlayPresentDelegate> delegate;
- (void)requestRoomInfo;
- (void)requestDeskInfo:(NSDictionary *)dic;

//- (void)followLiveWithUID:(NSInteger)uid;
//- (void)unfollowLiveWithUID:(NSInteger)uid;
- (void)doBet:(NSDictionary *)betInfo;
- (void)doBetCancel:(NSDictionary *)info;
@end

NS_ASSUME_NONNULL_END
