//
//  TeamLowerItemView.h
//  zhibo
//
//  Created by qp on 2020/7/31.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface TeamTextItem : UIView
@property (nonatomic, strong) UILabel *aLabel;
@property (nonatomic, strong) UILabel *bLabel;
@property (nonatomic, strong) UIView *lineView;
@end
NS_ASSUME_NONNULL_BEGIN

@interface TeamLowerItemView : UIView<ABUIListItemViewProtocol>

@end

NS_ASSUME_NONNULL_END
