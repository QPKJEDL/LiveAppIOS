//
//  PodiumView.h
//  zhibo
//
//  Created by qp on 2020/7/28.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PodiumView : UIControl
@property (nonatomic, strong) UIImageView *avatarImageView;
- (void)setTaiImageName:(NSString *)imageName mc:(NSInteger)mc;
- (void)setData:(NSDictionary *)data;
- (void)clear;
@end

NS_ASSUME_NONNULL_END
