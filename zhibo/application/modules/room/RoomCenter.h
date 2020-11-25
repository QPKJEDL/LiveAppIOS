//
//  RoomCenter.h
//  zhibo
//
//  Created by qp on 2020/11/14.
//  Copyright © 2020 qp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RoomCenter : NSObject
+ (RoomCenter *)shared;
- (void)pause;
- (void)resume;

- (BOOL)isFront;
@end

NS_ASSUME_NONNULL_END
