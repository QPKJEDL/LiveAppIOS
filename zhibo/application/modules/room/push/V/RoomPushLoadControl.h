//
//  KaiBoLoadingControl.h
//  zhibo
//
//  Created by qp on 2020/7/9.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class RoomPushLoadControl;
@protocol RoomPushLoadControlDelegate <NSObject>

- (void)controlOnFinish:(RoomPushLoadControl *)control;

@end

@interface RoomPushLoadControl : UIView
@property (nonatomic, weak) id<RoomPushLoadControlDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
