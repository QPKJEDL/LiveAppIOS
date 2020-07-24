//
//  UserPromptActionView.h
//  zhibo
//
//  Created by qp on 2020/7/11.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserPromptActionView : UIView
@property (nonatomic, strong) UIButton *followButton;
@property (nonatomic, strong) UIButton *managerButton;
@property (nonatomic, strong) UIButton *ttButton;
@property (nonatomic, strong) UIButton *forbiddenButton;
@property (nonatomic, assign) BOOL isFollow;

- (void)loadFangzhu;
@end

NS_ASSUME_NONNULL_END
