//
//  AnchorPromptView.h
//  zhibo
//
//  Created by qp on 2020/7/12.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnchorPromptView : UIView
@property (nonatomic, assign) BOOL isFollow;
- (void)refreshWith:(NSInteger)uid;
@end

NS_ASSUME_NONNULL_END
