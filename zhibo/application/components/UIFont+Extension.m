//
//  UIFont+Extension.m
//  zhibo
//
//  Created by qp on 2020/7/8.
//  Copyright © 2020 qp. All rights reserved.
//

#import "UIFont+Extension.h"

@implementation UIFont (Extension)
+ (UIFont *)fontMicrosoftYaHei:(CGFloat)size {
//    return [UIFont fontWithName:@"Microsoft YaHei" size:size];
    return [UIFont fontWithName:@"PingFangSC-Medium" size:size];
}

+ (UIFont *)PingFangSC:(CGFloat)size {
    return [UIFont fontWithName:@"PingFangSC-Regular" size:size];
}
+ (UIFont *)PingFangMedium:(CGFloat)size {
    return [UIFont fontWithName:@"PingFangSC-Medium" size:size];
}
+ (UIFont *)PingFangSCBlod:(CGFloat)size {
    return [UIFont fontWithName:@"PingFangSC-Semibold" size:size];
}

@end
