//
//  BaseViewController.h
//  zhibo
//
//  Created by FaiWong on 2020/4/22.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QMUIKit.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : QMUICommonViewController
- (void)showNoDataEmpty;
- (void)showSeat;
- (void)hideSeat;
- (void)refreshData;
@end

NS_ASSUME_NONNULL_END
