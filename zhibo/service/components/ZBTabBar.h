//
//  ZBTabBar.h
//  zhibo
//
//  Created by FaiWong on 2020/4/23.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZBTabbarDelegate <NSObject>

- (void)onCenterButtonAction;

@end

@interface ZBTabBar : UITabBar
@property (strong, nonatomic) UIControl *centerButton;
@property (nonatomic, weak) id<ZBTabbarDelegate> delegatee;
@end

NS_ASSUME_NONNULL_END
