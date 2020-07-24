//
//  TimeUtil.h
//  zhibo
//
//  Created by FaiWong on 2020/4/24.
//  Copyright © 2020 qp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimeUtil : NSObject
+ (TimeUtil *)shared;
+ (NSString *)time;
+ (NSString *)timestamp;
- (NSString *)timestampToTime:(NSString *)timestamp;
- (NSString *)howMuchTimePassed:(NSString *)timestamp;
@end

NS_ASSUME_NONNULL_END
