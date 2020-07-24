//
//  DeviceUtil.h
//  zhibo
//
//  Created by FaiWong on 2020/4/22.
//  Copyright © 2020 qp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeviceUtil : NSObject
+ (DeviceUtil *)shared;
- (void)saveImageToPhoto:(UIImage *)image;
- (void)takePhoto:(UIViewController *)vc success:(void(^)(NSDictionary * dic))success;
- (void)selectPhotos:(UIViewController *)vc;
@end

NS_ASSUME_NONNULL_END
