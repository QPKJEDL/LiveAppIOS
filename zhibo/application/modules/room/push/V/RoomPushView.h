//
//  RoomPushView.h
//  zhibo
//
//  Created by qp on 2020/7/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface RoomPushView : UIView
@property (nonatomic, assign) float beautyLevel;
@property (nonatomic, assign) float whitenessLevel;
@property (nonatomic, assign) float ruddyLevel;
- (void)preview;
- (void)flip;
- (void)push:(NSString *)address;
- (void)stop;
@end

NS_ASSUME_NONNULL_END
