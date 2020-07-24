//
//  KaiBoInfoView.h
//  zhibo
//
//  Created by qp on 2020/7/9.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class RoomPushReadyTitleView;
@protocol RoomPushReadyTitleViewDelegate <NSObject>

- (void)titleViewOnCover:(RoomPushReadyTitleView *)titleView;
- (void)titleViewOnTip:(RoomPushReadyTitleView *)titleView;
- (void)titleViewOnChannel:(RoomPushReadyTitleView *)titleView;

@end
@interface RoomPushReadyTitleView : UIView
@property (nonatomic, strong) id<RoomPushReadyTitleViewDelegate> delegate;
@property (nonatomic, strong) UIImage *cover;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *label;
@property (nonatomic, strong) NSString *channel;
@end

NS_ASSUME_NONNULL_END
