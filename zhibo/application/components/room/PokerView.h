//
//  PokerView.h
//  zhibo
//
//  Created by qp on 2020/9/18.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PokerView : UIView
- (void)setDataList:(NSArray *)dataList;

- (void)setMaxColumn:(int)Column;
@end

NS_ASSUME_NONNULL_END
