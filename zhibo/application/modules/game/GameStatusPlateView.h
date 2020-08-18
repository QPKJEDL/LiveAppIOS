//
//  GameStatusPlateView.h
//  zhibo
//
//  Created by qp on 2020/7/1.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    GameStatusPlateViewStatusWait,
    GameStatusPlateViewStatusStop,
    GameStatusPlateViewStatusOpen,
} GameStatusPlateViewStatus;
NS_ASSUME_NONNULL_BEGIN
@class GameStatusPlateView;
@protocol GameStatusPlateViewDelegate <NSObject>

- (void)plateView:(GameStatusPlateView *)plateView onStatusChanged:(GameStatusPlateViewStatus)status;

@end
@interface GameStatusPlateView : UIButton
@property (nonatomic, weak) id<GameStatusPlateViewDelegate> delegate;
- (void)please:(NSDictionary *)info;
- (void)finish;
- (void)wait;
- (void)watch;
- (void)stop;
@end

NS_ASSUME_NONNULL_END
