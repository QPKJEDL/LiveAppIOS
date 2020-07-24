//
//  RoomAudienceView.h
//  zhibo
//
//  Created by qp on 2020/7/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RoomAudienceView : UIView
- (void)setCount:(NSInteger)count;
- (void)setList:(NSArray *)list;
@property (nonatomic, strong) UILabel *countLabel;
@end

NS_ASSUME_NONNULL_END
