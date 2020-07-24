//
//  GiftPlayView.h
//  zhibo
//
//  Created by qp on 2020/7/13.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GiftEffectsPlayView : UIView
+ (GiftEffectsPlayView *)shared;

- (void)showWithVideoFile:(NSString *)fileName;
@end

NS_ASSUME_NONNULL_END
