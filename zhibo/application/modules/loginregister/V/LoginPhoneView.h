//
//  LoginPhoneView.h
//  zhibo
//
//  Created by qp on 2020/7/2.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@class LoginPhoneView;
@protocol LoginPhoneViewDelegate <NSObject>

- (void)loginPhoneViewOnChange:(LoginPhoneView *)loginView;
- (void)loginPhoneView:(LoginPhoneView *)loginView onLoginPhone:(NSString *)phone code:(NSString *)code;
@end

@interface LoginPhoneView : UIView
@property (nonatomic, weak) id<LoginPhoneViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
