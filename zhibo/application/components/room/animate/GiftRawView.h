//
//  GiftRawView.h
//  zhibo
//
//  Created by qp on 2020/7/13.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class GiftRawView;
@protocol GiftRawViewDelegate <NSObject>

- (void)giftRawViewFinish;
- (void)giftRawView:(GiftRawView *)giftRawView onDidSelectUid:(NSInteger)uid;
@end
@interface GiftRawView : UIView
@property (nonatomic, weak) id<GiftRawViewDelegate> delegate;
@property (nonatomic, assign) BOOL isFree;
- (void)showWithData:(NSDictionary *)data;
- (BOOL)isRefresh:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
