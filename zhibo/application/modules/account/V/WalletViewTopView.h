//
//  WalletViewTopView.h
//  zhibo
//
//  Created by FaiWong on 2020/4/25.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WalletViewTopView : UIView
@property (nonatomic, strong) UIButton *cashoutButton;
@property (nonatomic, strong) UIButton *rechargeButton;

- (void)reload:(NSDictionary *)data;
@end

NS_ASSUME_NONNULL_END
