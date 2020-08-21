//
//  SettingPresent.h
//  zhibo
//
//  Created by FaiWong on 2020/4/27.
//  Copyright © 2020 qp. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@class SettingPresent;
@protocol SettingPresentDelegate <NSObject>

- (void)present:(SettingPresent *)present onDataList:(NSArray *)dataList;

@end
@interface SettingPresent : NSObject
@property (nonatomic, weak) id<SettingPresentDelegate> delegate;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSDictionary *actions;
@property (nonatomic, strong) NSArray<NSArray *> *settingSections;
- (void)getSettingData:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
