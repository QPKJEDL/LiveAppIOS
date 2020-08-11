//
//  TencentCOS.h
//  zhibo
//
//  Created by qp on 2020/8/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QCloudCOSXML.h>
NS_ASSUME_NONNULL_BEGIN
typedef void (^TencentCOSSuccessBlock)(NSArray *urls);
@interface TencentCOS : NSObject
+ (TencentCOS *)shared;
- (void)setup;
// 一个脚手架实例
@property (nonatomic) QCloudCredentailFenceQueue* credentialFenceQueue;
- (void)uploadImages:(NSArray<UIImage *> *)images foler:(NSString *)foler success:(TencentCOSSuccessBlock)success;
- (void)uploadImage:(UIImage *)image foler:(NSString *)foler success:(TencentCOSSuccessBlock)success;
@end

NS_ASSUME_NONNULL_END
