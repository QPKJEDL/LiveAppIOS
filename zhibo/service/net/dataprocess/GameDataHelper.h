//
//  GameDataHelper.h
//  zhibo
//
//  Created by qp on 2020/6/29.
//  Copyright © 2020 qp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GameDataHelper : NSObject


- (NSDictionary *)getGameBetRuleWithParams:(NSDictionary *)params;

- (NSDictionary *)getGameBetResultWithParams:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
