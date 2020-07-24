//
//  ViewUtil.h
//  zhibo
//
//  Created by FaiWong on 2020/4/27.
//  Copyright © 2020 qp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ABUITextField.h"
NS_ASSUME_NONNULL_BEGIN

@interface ViewUtil : NSObject
//+ (ViewUtil *)shared;
+ (UIButton *)createButtonWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize isBold:(BOOL)isBold;

+ (UIButton *)createButtonWithImageName:(NSString *)imageName;

+ (ABUITextField *)createShadowInput;
@end

NS_ASSUME_NONNULL_END
