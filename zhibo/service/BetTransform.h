//
//  BetTransform.h
//  zhibo
//
//  Created by qp on 2020/8/20.
//  Copyright © 2020 qp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BetTransform : NSObject
+ (BetTransform *)shared;
- (NSString *)getBetDescriptionGid:(NSInteger)gid winner:(id)winner;
- (NSString *)getMusicGid:(NSInteger)gid winner:(id)winner;
@end

NS_ASSUME_NONNULL_END
