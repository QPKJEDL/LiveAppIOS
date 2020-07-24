//
//  RegisterView.h
//  zhibo
//
//  Created by qp on 2020/7/1.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RegisterView;
@protocol RegisterViewDelegate <NSObject>

- (void)registerView:(RegisterView *)registerView onRegisterUserName:(NSString *)username nickName:(NSString *)nickName password:(NSString *)password;
@end

@interface RegisterView : UIView
@property (nonatomic, weak) id<RegisterViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
