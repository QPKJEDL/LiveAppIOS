//
//  CashOutInputView.h
//  zhibo
//
//  Created by qp on 2020/7/20.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CashOutInputView : UIView
@property (nonatomic, assign) int num;
@property (nonatomic, strong) QMUITextField *textField;
- (void)setNoticeText:(NSString *)notice;
- (void)recharge;
@end

NS_ASSUME_NONNULL_END
