//
//  LiveUserView.h
//  zhibo
//
//  Created by FaiWong on 2020/5/3.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveUserView : UIView
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *fansTextLabel;
@property (nonatomic, strong) UILabel *fansCountLabel;

@property (nonatomic, strong) UIButton *followButton;

- (void)reload:(NSDictionary *)data;
@end

NS_ASSUME_NONNULL_END
