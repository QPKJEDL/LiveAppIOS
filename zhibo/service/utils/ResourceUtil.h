//
//  ResourceUtil.h
//  zhibo
//
//  Created by FaiWong on 2020/4/22.
//  Copyright © 2020 qp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResourceUtil : NSObject
+ (NSDictionary *)readDataWithFileName:(NSString *)name;

+ (NSDictionary *)tabData;

+ (NSDictionary *)popupData;

+ (NSDictionary *)momentData;

@end

NS_ASSUME_NONNULL_END
