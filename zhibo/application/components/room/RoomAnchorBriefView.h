//
//  LiveAnchorView.h
//  zhibo
//
//  Created by qp on 2020/7/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class RoomAnchorBriefView;
@protocol RoomAnchorBriefViewDelegate <NSObject>

- (void)roomAnchorBriefViewOnFollow:(RoomAnchorBriefView *)roomAnchorBriefView;

@end
@interface RoomAnchorBriefView : UIControl
@property (nonatomic, weak) id<RoomAnchorBriefViewDelegate> delegate;
@property (nonatomic, assign) BOOL isFollowed;
- (void)setname:(NSString *)name icon:(NSString *)icon count:(NSInteger)count;
@end

NS_ASSUME_NONNULL_END
