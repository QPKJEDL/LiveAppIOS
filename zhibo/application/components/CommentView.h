//
//  CommentView.h
//  zhibo
//
//  Created by qp on 2020/7/29.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasePromptView.h"
NS_ASSUME_NONNULL_BEGIN

@interface CommentView : BasePromptView
+ (CommentView *)shared;
@property (nonatomic, strong) NSDictionary *data;
- (void)loadData:(NSInteger)live_uid zone_id:(NSInteger)zone_id;
@end

NS_ASSUME_NONNULL_END
