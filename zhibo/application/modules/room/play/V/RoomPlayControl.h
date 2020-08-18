//
//  RoomPlayControl.h
//  zhibo
//
//  Created by qp on 2020/7/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RoomControl.h"

NS_ASSUME_NONNULL_BEGIN
@class RoomPlayControl;

@protocol RoomPlayControlDelegate <NSObject>

- (void)roomPlayControl:(RoomPlayControl *)roomPlayControl closeWithData:(NSDictionary *)data;

@end
@interface RoomPlayControl : RoomControl
@property (nonatomic, weak) id<RoomPlayControlDelegate> delegate;
- (void)receiveDeskInfo:(NSDictionary *)deskInfo;
- (void)receiveBetRules:(NSDictionary *)betRules;
- (void)receiveBalance:(NSInteger)balance;
- (void)receiveBetSuccess;

- (void)anchorLeave;
- (void)anchorReturn;
@end

NS_ASSUME_NONNULL_END
