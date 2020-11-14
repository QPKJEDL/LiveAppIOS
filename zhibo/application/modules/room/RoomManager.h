//
//  RoomManager.h
//  zhibo
//
//  Created by qp on 2020/8/14.
//  Copyright © 2020 qp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RoomManager : NSObject
@property (nonatomic, assign) NSInteger roomid;
@property (nonatomic, assign) NSInteger anchorid;
@property (nonatomic, assign) BOOL isAnchor;
@property (nonatomic, assign) BOOL isOnline;

@property (nonatomic, strong) NSString *nickcolor;
@property (nonatomic, strong) NSString *talkcolor;
- (void)enterRoomId:(NSInteger)roomId;
- (void)sendText:(NSString *)text;
- (void)finish;
@end

NS_ASSUME_NONNULL_END
