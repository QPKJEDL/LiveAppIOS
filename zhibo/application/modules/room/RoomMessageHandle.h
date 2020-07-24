//
//  RoomMessageHandle.h
//  zhibo
//
//  Created by qp on 2020/7/14.
//  Copyright © 2020 qp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IMService.h>
NS_ASSUME_NONNULL_BEGIN

@interface RoomMessageHandle : NSObject<RoomMessageObserver, PeerMessageObserver>

@end

NS_ASSUME_NONNULL_END
