//
//  RankActionsView.h
//  zhibo
//
//  Created by qp on 2020/7/28.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RankActionsView : UIControl
@property (nonatomic, strong) QMUIButton *leftButton;
@property (nonatomic, strong) QMUIButton *rightButton;
@property (nonatomic, assign) NSInteger selectIndex;
- (void)setleft:(NSString *)left right:(NSString *)right;
@end

NS_ASSUME_NONNULL_END
