//
//  UserBriefView.h
//  zhibo
//
//  Created by FaiWong on 2020/4/25.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserItem.h"
NS_ASSUME_NONNULL_BEGIN

@interface UserBriefView : UIControl
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *idLabel;
@property (nonatomic, strong) UILabel *followCountLabel;
@property (nonatomic, strong) UILabel *fansCountLabel;
@property (nonatomic, strong) UILabel *zanCountLabel;

- (void)reload:(NSDictionary *)data;
@end

NS_ASSUME_NONNULL_END
