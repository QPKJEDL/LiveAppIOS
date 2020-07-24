//
//  PopUp.h
//  zhibo
//
//  Created by FaiWong on 2020/4/23.
//  Copyright © 2020 qp. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum : NSUInteger {
    PopUpDirectionTop,
    PopUpDirectionBottom,
} PopUpDirection;

NS_ASSUME_NONNULL_BEGIN

@interface PopUp : NSObject
@property (nonatomic, assign) CGFloat distance;
+ (PopUp *)shared;
- (void)show:(UIView *)v from:(PopUpDirection)direction;
- (void)show:(UIView *)v from:(PopUpDirection)direction distance:(CGFloat)distance;
- (void)remove;
- (void)remove:(CGFloat)duration;
@end

NS_ASSUME_NONNULL_END
