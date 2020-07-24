//
//  FollowPresent.h
//  zhibo
//
//  Created by FaiWong on 2020/4/24.
//  Copyright © 2020 qp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class FollowPresent;
@protocol FollowPresentDelegate <NSObject>

- (void)present:(FollowPresent *)present onReceiveFollowList:(NSArray *)followList;
- (void)present:(FollowPresent *)present onReceiveFailure:(ABNetError *)error;
@end

@interface FollowPresent : NSObject<INetData>
@property (nonatomic, weak) id<FollowPresentDelegate> delegate;
@property (nonatomic, strong) NSArray *momentList;
@property (nonatomic, strong) NSMutableArray *commentList;
- (void)requestFollowList;
@end

NS_ASSUME_NONNULL_END
