//
//  RoomStack.h
//  zhibo
//
//  Created by qp on 2020/7/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RoomStack : NSObject
+ (RoomStack *)shared;
@property (nonatomic, strong) NSDictionary *desk;
@property (nonatomic, strong) NSString *wstcp;
@property (nonatomic, strong) NSString *gametcp;
@end

NS_ASSUME_NONNULL_END
