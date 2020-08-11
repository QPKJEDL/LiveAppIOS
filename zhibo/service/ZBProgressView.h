//
//  ZBProgressView.h
//  zhibo
//
//  Created by qp on 2020/8/3.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBProgressView : UIView
@property (nonatomic, assign) NSInteger maxValue;
@property (nonatomic, assign) CGFloat progress;
@end

NS_ASSUME_NONNULL_END
