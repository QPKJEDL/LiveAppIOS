//
//  RoomBottomBar.h
//  zhibo
//
//  Created by qp on 2020/7/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class RoomBottomBar;
@protocol RoomBottomBarDelegate <NSObject>

- (void)bottomBar:(RoomBottomBar *)bottomBar onText:(NSString *)text;
- (void)bottomBarOnClose:(RoomBottomBar *)bottomBar;
- (void)bottomBarOnMore:(RoomBottomBar *)bottomBar;
- (void)bottomBarOnGift:(RoomBottomBar *)bottomBar;
@end
@interface RoomBottomBar : UIView
@property (nonatomic, weak) id<RoomBottomBarDelegate> delegate;
@property (nonatomic, weak) UIView *commentView;
@end

NS_ASSUME_NONNULL_END
