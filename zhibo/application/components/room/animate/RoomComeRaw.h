//
//  RoomComeRaw.h
//  zhibo
//
//  Created by qp on 2020/7/16.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABUIAnimateBannerRawProtocol.h"
NS_ASSUME_NONNULL_BEGIN
@class RoomComeRaw;
@protocol RoomComeRawDelegate <NSObject>

- (void)roomComeRawFinished:(RoomComeRaw *)roomComeRaw;

@end
@interface RoomComeRaw : UIView<ABUIAnimateBannerRawProtocol>
@property (nonatomic, weak) id<RoomComeRawDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
