//
//  LoginView.h
//  zhibo
//
//  Created by qp on 2020/7/1.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class LoginView;
@protocol LoginViewDelegate <NSObject>

- (void)loginViewOnChange:(LoginView *)loginView;
- (void)loginView:(LoginView *)loginView onLoginUserName:(NSString *)username password:(NSString *)password;
@end

@interface LoginView : UIView
@property (nonatomic, weak) id<LoginViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
