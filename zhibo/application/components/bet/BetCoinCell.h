//
//  BetCoinCell.h
//  zhibo
//
//  Created by qp on 2020/6/22.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BetCoinCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *iconImageView;
- (void)reload:(NSDictionary *)data;
@end

NS_ASSUME_NONNULL_END
