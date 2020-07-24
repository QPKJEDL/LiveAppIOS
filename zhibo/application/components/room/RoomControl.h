//
//  RoomControl.h
//  zhibo
//
//  Created by qp on 2020/7/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RoomControl : UIView
@property (nonatomic, strong) NSDictionary *roomInfo;

- (void)onReceiveRoomMessage:(NSDictionary *)message;
- (void)onReceivePeerMessage:(NSDictionary *)message;

- (void)receiveRoomInfo:(NSDictionary *)roomInfo;
- (void)refreshRank;

//- (void)onFollow;
- (void)onClose;
- (void)onMore;
- (void)onGift;
//- (void)kickoff;

- (void)liveclose;
@end

NS_ASSUME_NONNULL_END
