//
//  EditLowerTeamFeeView.h
//  zhibo
//
//  Created by qp on 2021/2/7.
//  Copyright © 2021 qp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBProgressView.h"
NS_ASSUME_NONNULL_BEGIN

@protocol EditLowerTeamFeeViewDelegate <NSObject>

- (void)onUpdateSuccessed;

@end

@interface EditLowerTeamFeeView : UIView
@property (nonatomic, weak) id<EditLowerTeamFeeViewDelegate> delegate;
@property (nonatomic, assign) int maxValue;
@property (nonatomic, strong) ZBProgressView *progressView;
@property (nonatomic, assign) NSInteger uid;
@end

NS_ASSUME_NONNULL_END
