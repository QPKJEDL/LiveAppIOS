//
//  MinePresent.h
//  zhibo
//
//  Created by FaiWong on 2020/4/25.
//  Copyright © 2020 qp. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@class MinePresent;
@protocol MinePresentDelegate <NSObject>

- (void)minePresent:(MinePresent *)minePresent onReceiveTopInfo:(NSDictionary *)info;
@end
@interface MinePresent : NSObject
@property (nonatomic, weak) id<MinePresentDelegate> delegate;
@property (nonatomic, strong) NSArray<NSArray *> *settingSections;
- (void)refreshTopInfo;
@end

NS_ASSUME_NONNULL_END
