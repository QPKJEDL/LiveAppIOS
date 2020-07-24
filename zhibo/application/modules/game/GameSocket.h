//
//  GameSocket.h
//  zhibo
//
//  Created by qp on 2020/7/14.
//  Copyright © 2020 qp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IMService.h>
NS_ASSUME_NONNULL_BEGIN

@interface GameSocket : NSObject
@property (nonatomic, assign) int64_t roomID;
@property (nonatomic, strong) IMService *imService;

- (void)startRoomWithID:(int64_t)roomID;
- (void)stopRoom;

- (void)sendText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
