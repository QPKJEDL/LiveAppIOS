//
//  ADBannerView.h
//  zhibo
//
//  Created by qp on 2020/7/27.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ADBannerView;
@protocol ADBannerViewDelegate <NSObject>
- (void)adBannerView:(ADBannerView *)adBannerView didSelectIndex:(NSInteger)index;
@end
@interface ADBannerView : UIView
@property (nonatomic, weak) id<ADBannerViewDelegate> delegate;
- (void)setUrls:(NSArray *)urls;
@end

NS_ASSUME_NONNULL_END
